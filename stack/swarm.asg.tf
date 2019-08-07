/* instance profile for ASG instances */
data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_instance_profile" "readonlycaller" {
    name = "readonlycaller"
    role = aws_iam_role.ec2_description.name
}

resource "aws_iam_role" "ec2_description" {
  name = "EC2Description"
  path = "/"
  assume_role_policy = "${data.aws_iam_policy_document.instance-assume-role-policy.json}"
}

/* launch template: workers */
resource "aws_launch_template" "lt_worker" {
    key_name = var.ssh_key_name
    name_prefix = "workers-"
    image_id = var.swarm_ami
    instance_type = var.swarm_instance_type_wkr
    iam_instance_profile {
        name = aws_iam_instance_profile.readonlycaller.name
    }
    network_interfaces {
      associate_public_ip_address = false
      security_groups =  [
        "${aws_security_group.docker-swarm-worker-sg.id}",
        "${aws_security_group.basic-server-access.id}"
    ]
    }
}

/* asg: workers */
resource "aws_autoscaling_group" "asg_workers" {
#    availability_zones = local.three_azs 
    min_size = var.workers_min
    max_size = var.workers_max
    launch_template {
        id = "${aws_launch_template.lt_worker.id}"
        version = "$Latest"
    }
    vpc_zone_identifier = [
        "${aws_subnet.subnet_swarm_wkr_az1.id}",
        "${aws_subnet.subnet_swarm_wkr_az2.id}",
        "${aws_subnet.subnet_swarm_wkr_az3.id}",
    ]
    tag {
        key = "swarm_node_type"
        value = "worker"
        propagate_at_launch = true
    }
}

/* launch template: managers */
resource "aws_launch_template" "lt_manager" {
    key_name = var.ssh_key_name
    name_prefix = "ds-mgr-"
    image_id = var.swarm_ami
    instance_type = var.swarm_instance_type_mgr
    iam_instance_profile {
        name = aws_iam_instance_profile.readonlycaller.name
    }
    network_interfaces {
      associate_public_ip_address = false
      security_groups = ["${aws_security_group.docker-swarm-manager-sg.id}",
        "${aws_security_group.basic-server-access.id}"
        ]
    }
}

/* asg: managers */
resource "aws_autoscaling_group" "asg_managers" {
#    availability_zones = local.three_azs 
    min_size = var.managers_min
    max_size = var.managers_max
    launch_template {
        id = "${aws_launch_template.lt_manager.id}"
        version = "$Latest"
    }
    vpc_zone_identifier = [
        "${aws_subnet.subnet_swarm_mgr_az1.id}",
        "${aws_subnet.subnet_swarm_mgr_az2.id}",
        "${aws_subnet.subnet_swarm_mgr_az3.id}",
    ]
    tag {
        key = "swarm_node_type"
        value  = "manager"
        propagate_at_launch = true
    }
}

