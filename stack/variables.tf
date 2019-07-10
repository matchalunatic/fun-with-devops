variable "swarm_aws_region" {
    description = "AWS region for the Docker swarm"
    default = "eu-west-1"
}

variable "swarm_ami" {
    /* (default is Ubuntu 18.04 + Docker on eu-west-1 as built here) */
    description = "AMI to use for Docker Swarm"
    default = "ami-0fdaaadc99892a713"
}

variable "swarm_instance_type_mgr" {
    description = "Instance type for the Docker Swarm manager nodes"
    default = "t2.micro"
}

variable "swarm_instance_type_wkr" {
    description = "Instance type for the Docker Swarm worker nodes"
    default = "t2.micro"
}

variable "mongo_instance" {
    description = "Instance type for the MongoDB nodes"
    default = "t2.micro"
}

variable "swarm_common_ssh_key_path" {
    description = "Path to SSH public key path"

}

variable "swarm_ssh_key_name" {
    description = "Name for Docker key pair"
    default = "swarm-key"
}

variable "bootstrap_script" {
    description = "Script for configuring a node inside the swarm"
    default = "install-docker-stuff.sh"
}

variable "vpc_cidr" {
    default = "172.23.0.0/16"
}
variable "mongo_subnet_aza_cidr" {
    default = "172.23.10.0/24"
}

variable "mongo_subnet_azb_cidr" {
    default = "172.23.11.0/24"
}

variable "mongo_subnet_azc_cidr" {
    default = "172.23.12.0/24"
}

variable "swarm_wkrs_cidr_aza" {
    default = "172.23.20.0/24"
}

variable "swarm_wkrs_cidr_azb" {
    default = "172.23.21.0/24"
}

variable "swarm_wkrs_cidr_azc" {
    default = "172.23.22.0/24"
}

variable "swarm_mgrs_cidr_aza" {
    default = "172.23.30.0/24"
}

variable "swarm_mgrs_cidr_azb" {
    default = "172.23.31.0/24"
}

variable "swarm_mgrs_cidr_azc" {
    default = "172.23.32.0/24"
}

variable "workers_min" {
    default = 1
}

variable "workers_max" {
    default = 3
}

variable "managers_min" {
    default = 1
}

variable "managers_max" {
    default = 3
}
