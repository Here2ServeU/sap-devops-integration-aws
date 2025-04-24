terraform {
  backend "s3" {
    bucket         = "t2s-bank-terraform-state"
    key            = "sap/ec2/prod/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "t2s-terraform-locks"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "sap_ec2" {
  source        = "../../modules/ec2"
  ami           = var.ami
  instance_type = var.instance_type
  name          = var.name
}