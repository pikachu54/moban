provider "aws" {
  region  = "us-east-1"
}

provider "random" {}

terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 2.0"
    } 
    random = {
      source = "hashicorp/random"
      version = "~> 3.1.0"
    } 
  }
} 
