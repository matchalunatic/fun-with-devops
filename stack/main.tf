provider "aws" {
    version = "~> 2.0"
}

data "aws_availability_zones" "azs" {
  state = "available"
}

locals {
    three_azs = ["${data.aws_availability_zones.azs.names[0]}", "${data.aws_availability_zones.azs.names[1]}", "${data.aws_availability_zones.azs.names[2]}"]

    three_workers_subnets_o = [
        "${aws_subnet.subnet_swarm_wkr_az1}",
        "${aws_subnet.subnet_swarm_wkr_az2}",
        "${aws_subnet.subnet_swarm_wkr_az3}"

    ]
    three_workers_subnets = [for s in local.three_workers_subnets_o: s.id]
    three_managers_subnets_o = [
        "${aws_subnet.subnet_swarm_mgr_az1}",
        "${aws_subnet.subnet_swarm_mgr_az2}",
        "${aws_subnet.subnet_swarm_mgr_az3}"
    ]
    three_managers_subnets = [for s in local.three_managers_subnets_o: s.id]

    three_public_subnets_o = [
        "${aws_subnet.subnet_public_az1}",
        "${aws_subnet.subnet_public_az2}",
        "${aws_subnet.subnet_public_az3}"
    ]
    three_public_subnets = [for s in local.three_public_subnets_o: s.id]

    three_workers_cidr = [for s in local.three_workers_subnets_o: s.cidr_block]
    three_managers_cidr = [for s in local.three_managers_subnets_o: s.cidr_block]
}
