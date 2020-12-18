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

resource "github_actions_secret" "deploy_aws_access_key" {
  repository       = "floss"
  secret_name      = "DEPLOY_AWS_ACCESS_KEY_ID"
  plaintext_value  = module.aws-static-site.deploy-id
}

resource "github_actions_secret" "deploy_aws_access_secret" {
  repository       = "floss"
  secret_name      = "DEPLOY_AWS_SECRET_ACCESS_KEY"
  plaintext_value  = module.aws-static-site.deploy-secret
}
