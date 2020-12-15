terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "VargasArts"
    workspaces {
      prefix = "public-garden"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "secret" {
  type = string
}

module "aws-static-site" {
  source  = "dvargas92495/static-site/aws"
  version = "1.2.1"

  domain = "garden.davidvargas.me"
  secret = var.secret
  tags = {
    Application = "Public Garden"
  }
}
