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

The MongoDB service is stateful and so it needs access to a persistent data storage.
Therefore we have a small Elastic File System mounted on all worker nodes. This is not
the most efficient way to do it perf-wise but it is by far the simplest.

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
