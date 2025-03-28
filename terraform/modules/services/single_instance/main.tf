locals {
  http_port    = 80
  ssh_port     = 22
  rdp_port     = 3389
  vnc_port     = 5900
  any_port     = 0
  any_protocol = "-1"
  tcp_protocol = "tcp"
  all_ips      = ["0.0.0.0/0"]
}

resource "aws_security_group" "sec_group" {
  name = "apachevncrdp"
}

resource "aws_security_group_rule" "allow_http" {
  type = "ingress"
  security_group_id = aws_security_group.sec_group.id
  from_port   = local.http_port
  to_port     = local.http_port
  protocol    = local.tcp_protocol
  cidr_blocks = local.all_ips
}

resource "aws_security_group_rule" "allow_vnc" {
  type = "ingress"
  security_group_id = aws_security_group.sec_group.id
  from_port   = local.vnc_port
  to_port     = local.vnc_port
  protocol    = local.tcp_protocol
  cidr_blocks = local.all_ips
}

resource "aws_security_group_rule" "allow_ssh" {
  type = "ingress"
  security_group_id = aws_security_group.sec_group.id
  from_port   = local.ssh_port
  to_port     = local.ssh_port
  protocol    = local.tcp_protocol
  cidr_blocks = local.all_ips
}

resource "aws_security_group_rule" "allow_rdp" {
  type = "ingress"
  security_group_id = aws_security_group.sec_group.id
  from_port   = local.rdp_port
  to_port     = local.rdp_port
  protocol    = local.tcp_protocol
  cidr_blocks = local.all_ips
}

 resource "aws_key_pair" "deployer" {
   key_name   = "deployer-key"
   public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGOrmtRK7DeHDOJ4am6idvME6qM9B+sPMfitahtt/DDJ"
 }

resource "aws_instance" "single" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.sec_group.id]
  root_block_device {
    volume_size = 15
  }
  
  tags = {
    Name = var.tag
  }
}