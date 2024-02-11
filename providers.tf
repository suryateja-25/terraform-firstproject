terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "aws" {
  region     = "us-west-2"
  access_key = "AKIAZKVR2BRJZZ7ZVMDS"
  secret_key = var.aws_secret_key
}