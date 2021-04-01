
variable "key_name" {
  type = string
}

variable "instance_type" {
  type = string
}

terraform {
  backend "s3" {
    bucket     = "rt-tf-test-bucket"
    key        = "terraform.tfstate"
    region     = "ap-southeast-1"
    access_key = "AKIA32GTTIRLA5S2MNE5"
    secret_key = "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"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-southeast-1"
}

module "ec2-instance-trmodule" {
  source  = "trivbuit.scalr.io/env-tct37d1oddo7u4g/ec2-instance-trmodule/aws"
  version = "1.0.4"

  count = 2

  ami           = "ami-01581ffba3821cdf3"
  instance_type = var.instance_type

  key_name = var.key_name
}

output "ec2-user" {
  value = module.ec2-instance-trmodule.*.ec2_user
}