provider "aws" {
  region = "us-east-1"
}

module "single_instance" {
  source = "./modules/services/single_instance"

  tag           = "fresh-install"
  ami_id        = "ami-0ec612e1caf93df8c"
  instance_type = "t3.medium"
}