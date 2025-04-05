variable "instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
  type        = list(string)
}

variable "ami_id" {
  description = "The ami id to use"
  type        = list(string)
}

variable "tag" {
  description = "The ami id to use"
  type        = string
}