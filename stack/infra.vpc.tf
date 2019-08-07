resource "aws_vpc" "swarm_poc_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true

    tags = {
        usage = "poc"
        project = "foxint"
    }
}

resource "aws_route" "vpc_defroute" {
  route_table_id         = "${aws_vpc.swarm_poc_vpc.default_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id             = "${aws_nat_gateway.nat_poc_gw.id}"
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

resource "aws_s3_bucket" "bastion" {
    bucket = "bastion"
    acl = "private"
}

resource "aws_s3_bucket_object" "bastionkey" {
    bucket = "${aws_s3_bucket.bastion.id}"
    source = "/tmp/bastion.pem"
    key = "bastion.pem"
}


module "bastion" {
  source  = "telia-oss/bastion/aws"
  version = "0.1.2"
  # insert the 8 required variables here
  name_prefix = "bastion"
  vpc_id = "${aws_vpc.swarm_poc_vpc.id}"
  subnet_ids = local.three_public_subnets
  instance_type = "t2.micro"
  pem_bucket = "${aws_s3_bucket.bastion.id}"
  pem_path = "bastion.pem"
  authorized_cidr = "163.172.128.35/32"
  authorized_keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFcpCFHqpadw9yP3Nf1gD+GyGFuemrAXkgXNLIRuaeVY"]
  instance_ami = "ami-06358f49b5839867c"
  
  depends_on = ["${aws_s3_bucket_object.bastionkey.id}"]
}
