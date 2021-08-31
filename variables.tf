variable "aws_region" {
  default = "us-west-2"
}

variable "access_ip" {}

#-------database variables

variable "dbname" {
  type = string
}
variable "dbuser" {
  type = string
}
variable "dbpassword" {
  type      = string
  sensitive = true
}

variable "public_key_path" {
  type = string
}
variable "private_key_path" {
  type = string
}
variable "key_name" {
  type = string
}

variable "tg_port" {
  type = number
}

variable "server_nodes_count" {
  type = number
}

variable "private_subnet_count" {
  type = number
}

variable "public_subnet_count" {
  type = number
}