terraform {

  required_version = "~>1.14"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.72"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-south-2"


  default_tags {
    tags = {
      Project     = "p3-nominas"
      Environment = "dev"
      Owner       = "Andreu"
      ManagedBy   = "Terraform"
    }
  }
}
