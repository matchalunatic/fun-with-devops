/* subnets for Swarm workers */

resource "aws_subnet" "subnet_swarm_wkr_aza" {
    vpc_id = "${aws_vpc.swarm_poc_vpc.id}"
    cidr_block = var.swarm_wkrs_cidr_aza
    availability_zone = "${data.aws_availability_zones.azs.names[0]}"
}

resource "aws_subnet" "subnet_swarm_wkr_azb" {
    vpc_id = "${aws_vpc.swarm_poc_vpc.id}"
    cidr_block = var.swarm_wkrs_cidr_azb
    availability_zone = "${data.aws_availability_zones.azs.names[1]}"
}

resource "aws_subnet" "subnet_swarm_wkr_azc" {
    vpc_id = "${aws_vpc.swarm_poc_vpc.id}"
    cidr_block = var.swarm_wkrs_cidr_azc
    availability_zone = "${data.aws_availability_zones.azs.names[2]}"
}

/* subnets for Swarm managers */

resource "aws_subnet" "subnet_swarm_mgr_aza" {
    vpc_id = "${aws_vpc.swarm_poc_vpc.id}"
    cidr_block = var.swarm_mgrs_cidr_aza
    availability_zone = "${data.aws_availability_zones.azs.names[0]}"
}

resource "aws_subnet" "subnet_swarm_mgr_azb" {
    vpc_id = "${aws_vpc.swarm_poc_vpc.id}"
    cidr_block = var.swarm_mgrs_cidr_azb
    availability_zone = "${data.aws_availability_zones.azs.names[1]}"
}

resource "aws_subnet" "subnet_swarm_mgr_azc" {
    vpc_id = "${aws_vpc.swarm_poc_vpc.id}"
    cidr_block = var.swarm_mgrs_cidr_azc
    availability_zone = "${data.aws_availability_zones.azs.names[2]}"
}

