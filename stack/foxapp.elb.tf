resource "aws_elb" "public_app_access" {
    name = "fox-devops-frontend-elb"
#     availability_zones = local.three_azs
    # this is a public ELB
    internal = false
    listener {
        instance_port = 3000
        instance_protocol = "http"
        lb_port = 3000
        lb_protocol = "http"
    }


    health_check {
      healthy_threshold   = 2
      unhealthy_threshold = 2
      timeout             = 3
      target              = "HTTP:3000/"
      interval            = 30
    }


    security_groups = [
        "${aws_security_group.fox-front-sg.id}"
    ]

#    subnets = local.three_public_subnets
    subnets = local.three_workers_subnets
}

/* glue between ELBs and ASGs */

resource "aws_autoscaling_attachment" "public_app_access_glue" {
    autoscaling_group_name = "${aws_autoscaling_group.asg_workers.id}"
    elb = "${aws_elb.public_app_access.id}"
}

output public_dns_name {
    value = "${aws_elb.public_app_access.dns_name}"
}
