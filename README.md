# beautiful-nodes
This is a Terraform deployment for a high availability k3s architecture on AWS.

 - The k3s server nodes use a shared external RDS Postgres db and are deployed on multiple AZs. 
 - Multiple public and private subnets are provisioned based on your settings in `beautiful-nodes.tfvars`. 
 - Load balancer routes traffic to healthy server nodes.
 - When the k3s nodes are started, the kubeconfig and certificates are copied to a local directory on your machine. This will allow you to perform kubectl commands from your local machine. 
 - Note the `access_ip` variable should only include your public IP. If this is left at 0.0.0.0/0, it will open to world

# Prerequisites
Terraform
Kubectl (if you wish to control the server nodes from your local machine)

# Usage - Infrastructure Deployment

 1. Fork and clone the repository
 2. Replace the contents of backends.tf with: 
    ```
    terraform {
        backend "local" { }
    }
    ```
 3. Open `beautiful-nodes.tfvars` and fill out the details as per the instructions in that file
     - Keep in mind the cost of resources when selectin the node sizes and the number of nodes / instance count
 4. Run `make plan` to perform a terraform plan
 5. Run `make apply` to deploy the infrastructure

# Usage - Connecting to Nodes
`Work in progress` 