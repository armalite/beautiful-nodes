terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "beautiful-intelligence"

    workspaces {
      name = "beautiful-data-cli"
    }
  }
}