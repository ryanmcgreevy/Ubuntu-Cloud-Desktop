provider "aws" {
  region = "us-east-1"
}

module "single_instance" {
  source = "./modules/services/single_instance"

  tag           = "fresh-install"
  #ami_id        = ["ami-020cba7c55df1f615","ami-07041441b708acbd6"]
  #instance_type = ["g5.xlarge","g5g.xlarge"]
  ami_id        = ["ami-0f140b8689f89b1cd"]
  instance_type = ["g5g.xlarge"]
}