resource "aws_vpc" "swarm_poc_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    usage   = "poc"
    project = "foxint"
  }
}

resource "aws_route" "vpc_defroute" {
  route_table_id         = aws_vpc.swarm_poc_vpc.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.poc_gw.id
}

resource "aws_route_table" "nat_rt" {
  vpc_id = aws_vpc.swarm_poc_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_poc_gw.id
  }
}

resource "aws_internet_gateway" "poc_gw" {
  vpc_id = "${aws_vpc.swarm_poc_vpc.id}"

  tags = {
    Name = "poc_gw"
  }
}

resource "aws_eip" "nat_ip" {
  vpc = true
}


resource "aws_nat_gateway" "nat_poc_gw" {
  allocation_id = "${aws_eip.nat_ip.id}"
  subnet_id     = "${aws_subnet.subnet_public_az1.id}"

  depends_on = ["aws_internet_gateway.poc_gw"]
}




/* bastion, quick & dirty */


module "ssh-bastion-service" {
  source                        = "joshuamkite/ssh-bastion-service/aws"
  version                       = "5.0.0"
  aws_region                    = "eu-west-1"
  aws_profile                   = "default"
  bastion_allowed_iam_group     = "DevOps"
  vpc                           = aws_vpc.swarm_poc_vpc.id
  subnets_asg                   = local.three_bastion_subnets
  subnets_lb                    = local.three_bastion_subnets
  cidr_blocks_whitelist_service = ["85.68.24.103/32", "163.172.128.35/32"]
  public_ip                     = true
}

output bastion_dns {
  value       = module.ssh-bastion-service.lb_dns_name
  description = "SSH to this"
}
