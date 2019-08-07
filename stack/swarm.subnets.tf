resource "aws_subnet" "subnet_public_az1" {
    vpc_id = "${aws_vpc.swarm_poc_vpc.id}"
    cidr_block = var.swarm_public_az1
    availability_zone = "${data.aws_availability_zones.azs.names[0]}"
}

resource "aws_subnet" "subnet_public_az2" {
    vpc_id = "${aws_vpc.swarm_poc_vpc.id}"
    cidr_block = var.swarm_public_az2
    availability_zone = "${data.aws_availability_zones.azs.names[1]}"
}

resource "aws_subnet" "subnet_public_az3" {
    vpc_id = "${aws_vpc.swarm_poc_vpc.id}"
    cidr_block = var.swarm_public_az3
    availability_zone = "${data.aws_availability_zones.azs.names[2]}"
}

/* subnets for Swarm workers */
resource "aws_subnet" "subnet_swarm_wkr_az1" {
    vpc_id = "${aws_vpc.swarm_poc_vpc.id}"
    cidr_block = var.swarm_wkrs_cidr_az1
    availability_zone = "${data.aws_availability_zones.azs.names[0]}"
}

resource "aws_subnet" "subnet_swarm_wkr_az2" {
    vpc_id = "${aws_vpc.swarm_poc_vpc.id}"
    cidr_block = var.swarm_wkrs_cidr_az2
    availability_zone = "${data.aws_availability_zones.azs.names[1]}"
}

resource "aws_subnet" "subnet_swarm_wkr_az3" {
    vpc_id = "${aws_vpc.swarm_poc_vpc.id}"
    cidr_block = var.swarm_wkrs_cidr_az3
    availability_zone = "${data.aws_availability_zones.azs.names[2]}"
}
/* subnets for Swarm managers */

resource "aws_subnet" "subnet_swarm_mgr_az1" {
    vpc_id = "${aws_vpc.swarm_poc_vpc.id}"
    cidr_block = var.swarm_mgrs_cidr_az1
    availability_zone = "${data.aws_availability_zones.azs.names[0]}"
}

resource "aws_subnet" "subnet_swarm_mgr_az2" {
    vpc_id = "${aws_vpc.swarm_poc_vpc.id}"
    cidr_block = var.swarm_mgrs_cidr_az2
    availability_zone = "${data.aws_availability_zones.azs.names[1]}"
}

resource "aws_subnet" "subnet_swarm_mgr_az3" {
    vpc_id = "${aws_vpc.swarm_poc_vpc.id}"
    cidr_block = var.swarm_mgrs_cidr_az3
    availability_zone = "${data.aws_availability_zones.azs.names[2]}"
}

/* subnets for Bastion */
resource "aws_subnet" "subnet_bastion_az1" {
    vpc_id = "${aws_vpc.swarm_poc_vpc.id}"
    cidr_block = var.swarm_bastion_az1
    availability_zone = "${data.aws_availability_zones.azs.names[0]}"
}

resource "aws_subnet" "subnet_bastion_az2" {
    vpc_id = "${aws_vpc.swarm_poc_vpc.id}"
    cidr_block = var.swarm_bastion_az2
    availability_zone = "${data.aws_availability_zones.azs.names[1]}"
}

resource "aws_subnet" "subnet_bastion_az3" {
    vpc_id = "${aws_vpc.swarm_poc_vpc.id}"
    cidr_block = var.swarm_bastion_az3
    availability_zone = "${data.aws_availability_zones.azs.names[2]}"
}



/* RT association */

resource "aws_route_table_association" "wkr_az1" {
    subnet_id = aws_subnet.subnet_swarm_wkr_az1.id
    route_table_id = aws_route_table.nat_rt.id
}

resource "aws_route_table_association" "wkr_az2" {
    subnet_id = aws_subnet.subnet_swarm_wkr_az2.id
    route_table_id = aws_route_table.nat_rt.id
}

resource "aws_route_table_association" "wkr_az3" {
    subnet_id = aws_subnet.subnet_swarm_wkr_az3.id
    route_table_id = aws_route_table.nat_rt.id
}

resource "aws_route_table_association" "mgr_az1" {
    subnet_id = aws_subnet.subnet_swarm_mgr_az1.id
    route_table_id = aws_route_table.nat_rt.id
}

resource "aws_route_table_association" "mgr_az2" {
    subnet_id = aws_subnet.subnet_swarm_mgr_az2.id
    route_table_id = aws_route_table.nat_rt.id
}

resource "aws_route_table_association" "mgr_az3" {
    subnet_id = aws_subnet.subnet_swarm_mgr_az3.id
    route_table_id = aws_route_table.nat_rt.id
}
