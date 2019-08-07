# Status

I currently have 2 separate components up and running:

- proper Docker-Swarm cluster starting as needed
- properly running Docker-Compose app


General improvement goals:

- SSH-less automation for the Docker-Swarm cluster to start a swarm of the app
- Decent security group management pertaining to the App
- Better automation overall


To be done:

- proper startup call of a docker stack deployment of stack files stored in
the S3 bucket (needs a script that does just that that would be call at
start-up) => this goes for SSH-less auth

Cutoff reason: time is lacking.

# How to use

## Configure AWS account

1. Edit top-level env.sh (start with env.sh.dist) and set proper value
2. Always run `source env.sh` before working on this project
3. Create a user with a SSH key (Under IAM -> Users -> Security Credentials -> Upload SSH key) / this is for bastion use.
4. Create an EC2 role instance under IAM with name EC2Description and strategy AmazonEC2ReadOnlyAccess

## Configure the Docker stack

```bash
cd fox-dockerswarm/stack
test ! -f .env_back && cp env_back_example .env_back && $EDITOR .env_back
test ! -f .env_mongo && cp env_mongo_example .env_mongo && $EDITOR .env_mongo
source .env_mongo
source .env_back
make
```

## Create container images and publish them

1. Login to your Docker.io account or to a private registry (not tested/needs
tweaks) in order to be able to publish Docker images.
2. Edit stack/foxapp/environment to reflect proper Docker tags for the pushes
you will make (self-explicit, set with default values that will not work unless
you are me)
3. Run `cd stack/foxapp; source environment; make`

Now you have the app images in your account. Time to create an AMI

## Create the AMI

1. Install Packer
2. Run `cd vm-images/docker-swarm; packer build -var swarm_image_name=bionic-swarm-test-1.0 packer.json` (the swarm_image_name should be changed)
3. Retrieve the AMI id from Packer or from your AWS interface

## Prepare Terraform stack

1. Enter the stack/ directory
2. Create a `terraform.tfvars` file setting the proper variables. See `variables.tf` for details
   Minimal set is: 
     - `swarm_aws_region` (I use eu-west-1 for dev)
     - `swarm_ami` (defaultless variable, fill it in with the created AMI ID)
3. ~~~Check that `foxapp.dab` is in the stacks/ directory (built in the Docker process,
should never be versioned as it contains config information) -> This is not supported by current docker versions as it is still experimental.
500. Before redeploying an updated AMI for the ASG, you must run ./reset-swarm.sh
(this will clean-up the locking mechanism for Swarm creation)
999. You have to run the terraform apply twice due to a bug in the AWS provider pertaining
to module management.

...FIXME: to be completed for automated deployment of stacks.

## Deploy the app

1. Connect to the SSH bastion
2. Connect to the manager node
3. One way or another (git clone, tar + scp...), get `docker-compose.yml`,
`.env_mongo` & `.env_back` on the manager node in a folder (say: foxapp)
4. `cd foxapp; docker stack create -c docker-compose.yml foxapp`

# An exercise

## Purpose

Deploy a Docker Swarm HA stack (size not specified)

Then deploy an app on this stack with:

- A MongoDB instance
- A NodeJS app that listens on port 3000 (public front-end)
- A Golang app that listens on port 8080 (private back-end)

The back-end app must be able to access an external S3 bucket.

## Implementation

I chose to deploy a 1-3 managers + 1-3 workers cluster using ASGs and auto-provisioning.

The MongoDB service is stateful and so it would normally need access to a persistent
data storage. As I do not see this as a requirement I don't implement it.

Public app access is managed by an ELB.

Backend is handled by Docker Swarm services and is therefore by design isolated from the
public.

The programs are run as services in the Swarm. The docker images are built using Travis CI
and are pushed to the public Docker registry.

## Discussion

The MongoDB service could be better off in its own cluster accessed as a service by the
app deployed in the Docker Swarm but this is beyond the scope of this exercise.

Another option would be to dynamically mount an EBS before the MongoDB service is started
on a node but this would need us to have a locking mechanism and to play with the AWS API
from EC2 instances, and in turn this would imply the creation of a dedicated EC2 IAM role
for this purpose, all in Terraform and this is beyond "simple".

Using an ECR is just a quick way to host Docker images. Another option would be to setup
a full-fledged private registry but this implies some heavy lifting (generating certs...)
which is beyond the point of this POC.

The test service has some bugs, like it will insert movies already present in the
base. I assume it's because it is a simple test and not a full-fledged application.

As the data has not been marked as mission-critical, we will not persist it.
