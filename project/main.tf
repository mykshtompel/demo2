variable "region" {
  description = "The AWS region for the project"
  default     = "us-east-2"
}

provider "aws" {
  region = var.region
}

module "network" {
  source = "./modules/network"

  cidr_block        = "10.10.0.0/16"
  aws_dns           = true
  env               = "stage"
  app               = "new_app"
  app_port          = 80
  app_target_port   = 8080
  health_check_path = "/"
}
