provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "sap_sles" {
  ami           = "ami-0c2d3a4e5fcb5df59" # SLES AMI
  instance_type = "t3.medium"

  tags = {
    Name = "sap-sles-instance"
  }
}
