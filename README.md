# beautiful-nodes
README is a work in progress...

This is my Terraform deployment for a high availability k3s architecture on AWS.

The k3s server nodes use a shared external RDS Postgres db, and deployed on multiple AZs. 

Multiple public and private subnets are provisioned based on the _subnet_count variable inputs supplied in tfvars. 

Load balancer routes traffic to healthy server nodes.

When the k3s nodes are started, the kubeconfig and certificates are copied to a local directory on your machine using a local-exec provisioner. This will allow you to perform kubectl commands from your local machine. 

Currently this deploys X number of k3s server nodes on ec2 t3.small instances. Number of nodes can be defined in terraform.tfvars:
<code> server_nodes_count = 2 </code>

Have a look inside the rename-this-to-terraform.tfvars file to see all required inputs. Rename this file to terraform.tfvars.
Note the access_ip variable should only include your public IP. If this is left at 0.0.0.0/0, it will open to world

# Architecture

# Prerequisites
Terraform
Kubectl (if you wish to control the server nodes from your local machine)

# Usage
