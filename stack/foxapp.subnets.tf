/* the subnets for a HA MongoDB service (3 groups) */

resource "aws_subnet" "subnet_mongo_aza" {
    vpc_id = "${aws_vpc.swarm_poc_vpc.id}"
    cidr_block = var.mongo_subnet_aza_cidr
    availability_zone = "${data.aws_availability_zones.azs.names[0]}"
}

resource "aws_subnet" "subnet_mongo_azb" {
    vpc_id = "${aws_vpc.swarm_poc_vpc.id}"
    cidr_block = var.mongo_subnet_azb_cidr
    availability_zone = "${data.aws_availability_zones.azs.names[1]}"
}

resource "aws_subnet" "subnet_mongo_azc" {
    vpc_id = "${aws_vpc.swarm_poc_vpc.id}"
    cidr_block = var.mongo_subnet_azc_cidr
    availability_zone = "${data.aws_availability_zones.azs.names[2]}"
}
