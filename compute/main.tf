# Get ubuntu 18.04 public ami to use for the server nodes. Adeeb TODO: Upgrade to 20.04 or 21.04
data "aws_ami" "server_ami" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

resource "random_id" "beautiful_node_id" {
  byte_length = 2
  count       = var.instance_count
  keepers = {
    key_name = var.key_name
  }
}

resource "aws_key_pair" "beautiful_auth" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

# Server node definition 
resource "aws_instance" "beautiful_node" {
  count         = var.instance_count
  instance_type = var.instance_type
  ami           = data.aws_ami.server_ami.id

  tags = {
    Name = "beautiful_node-${random_id.beautiful_node_id[count.index].dec}"
  }

  key_name               = aws_key_pair.beautiful_auth.id
  vpc_security_group_ids = [var.public_sg]
  subnet_id              = var.public_subnets[count.index]

  # This points to the userdata script, which bootstraps k3s on the server node
  user_data = templatefile(var.user_data_path,
    {
      nodename    = "beautiful-${random_id.beautiful_node_id[count.index].dec}"
      db_endpoint = var.db_endpoint
      dbuser      = var.dbuser
      dbpass      = var.dbpassword
      dbname      = var.dbname
    }
  )


  root_block_device {
    volume_size = var.vol_size
  }

  # This is a delay script that will run on the node and wait until k3s is bootstrapped
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = self.public_ip
      private_key = file(var.private_key_path)
    }
    script = "${path.root}/scripts/lolwait.sh"
  }

  # Copies the k3s kubeconfig file from the node, into the local .nodeconfigs folder
  provisioner "local-exec" {
    command = templatefile("${path.cwd}/templates/get_remote_k3s_config.tpl",
      {
        nodeip           = self.public_ip
        k3s_path         = "${path.cwd}/.nodeconfigs/"
        nodename         = self.tags.Name
        private_key_path = var.private_key_path
      }
    )
  }
  # Remove this directory upon destroy as we dont need it. Adeeb-TODO: test for remote exec too?
  provisioner "local-exec" {
    when    = destroy
    command = "rm -f ${path.cwd}/../k3s-beautiful_node-*"
  }
}

# Attach the load balancer to the server nodes (ec2 instances)
resource "aws_lb_target_group_attachment" "beautiful_tg_attach" {
  count            = var.instance_count
  target_group_arn = var.lb_target_group_arn
  target_id        = aws_instance.beautiful_node[count.index].id
  port             = var.tg_port
}
