/* launch template: workers */
resource "aws_launch_template" "lt_workers" {
    name_prefix = "workers-"
    image_id = var.workers_ami
    instance_type = var.workers_instance_type
    network_interfaces {
      associate_public_ip_address = false
    }
    vpc_security_group_ids = [
        "${aws_security_group.docker-swarm-worker-wg.id}"
    ]
}

/* asg: workers */
resource "aws_autoscaling_group" "asg_workers" {
    availability_zones = local.three_azs 
    min_size = var.workers_min
    max_size = var.workers_max
    launch_template {
        id = "${aws_launch_template.lt_worker.id}"
        version = "$Latest"
    }
    vpc_zone_identifier = [
        "${aws_subnet.subnet_swarm_wkr_aza.id}",
        "${aws_subnet.subnet_swarm_wkr_azb.id}",
        "${aws_subnet.subnet_swarm_wkr_azc.id}",
    ]
}

/* launch template: managers */
resource "aws_launch_template" "lt_manager" {
    name_prefix = "ds-mgr-"
    image_id = var.swarm_ami
    instance_type = var.swarm_instance_type_mgr
    network_interfaces {
      associate_public_ip_address = false
    }
    vpc_security_group_ids = ["${aws_security_group.docker-swarm-manager-sg.id}"]
}

/* asg: managers */
resource "aws_autoscaling_group" "asg_managers" {
    availability_zones = local.three_azs 
    min_size = var.managers_min
    max_size = var.managers_max
    launch_template {
        id = "${aws_launch_template.lt_worker.id}"
        version = "$Latest"
    }
    vpc_zone_identifier = [
        "${aws_subnet.subnet_swarm_mgr_aza.id}",
        "${aws_subnet.subnet_swarm_mgr_azb.id}",
        "${aws_subnet.subnet_swarm_mgr_azc.id}",
    ]
}

