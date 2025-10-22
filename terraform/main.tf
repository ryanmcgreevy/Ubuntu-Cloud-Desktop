provider "aws" {
  region = "us-east-1"
}

module "single_instance" {
  source = "./modules/services/single_instance"

  tag           = "fresh-install"
  # ami_id        = ["ami-0f30a0245a537000d", "ami-0a8c16a4360048851"]
  # instance_type = ["g5.xlarge","g5g.xlarge"]
  ami_id        = ["ami-0f30a0245a537000d"]
  instance_type = ["t3.medium"]
  
}