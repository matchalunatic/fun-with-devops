variable "swarm_aws_region" {
  description = "AWS region for the Docker swarm"
  default     = "eu-west-1"
}
variable "swarm_ami" {
  description = "AMI to use for Docker Swarm"

}

variable "swarm_instance_type_mgr" {
  description = "Instance type for the Docker Swarm manager nodes"
  default     = "t2.micro"
}

variable "swarm_instance_type_wkr" {
  description = "Instance type for the Docker Swarm worker nodes"
  default     = "t2.micro"
}

variable "mongo_instance" {
  description = "Instance type for the MongoDB nodes"
  default     = "t2.micro"
}

variable "bootstrap_script" {
  description = "Script for configuring a node inside the swarm"
  default     = "install-docker-stuff.sh"
}

variable "vpc_cidr" {
  default = "172.23.0.0/16"
}
variable "mongo_subnet_az1_cidr" {
  default = "172.23.10.0/24"
}

variable "mongo_subnet_az2_cidr" {
  default = "172.23.11.0/24"
}

variable "mongo_subnet_az3_cidr" {
  default = "172.23.12.0/24"
}

variable "swarm_wkrs_cidr_az1" {
  default = "172.23.20.0/24"
}

variable "swarm_wkrs_cidr_az2" {
  default = "172.23.21.0/24"
}

variable "swarm_wkrs_cidr_az3" {
  default = "172.23.22.0/24"
}

variable "swarm_mgrs_cidr_az1" {
  default = "172.23.30.0/24"
}

variable "swarm_mgrs_cidr_az2" {
  default = "172.23.31.0/24"
}

variable "swarm_mgrs_cidr_az3" {
  default = "172.23.32.0/24"
}

variable "swarm_public_az1" {
  default = "172.23.50.0/24"
}

variable "swarm_public_az2" {
  default = "172.23.51.0/24"
}

variable "swarm_public_az3" {
  default = "172.23.52.0/24"
}

variable "swarm_bastion_az1" {
  default = "172.23.150.0/24"
}

variable "swarm_bastion_az2" {
  default = "172.23.151.0/24"
}

variable "swarm_bastion_az3" {
  default = "172.23.152.0/24"
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

variable "ssh-key-path" {
  default = "~/.ssh/docker-ed25519"
}

variable "ssh_key_name" {
  description = "SSH key name for bastion / must be created otherwise"
}
