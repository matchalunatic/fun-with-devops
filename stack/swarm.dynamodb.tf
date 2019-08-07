/*
Use a dynamodb service as a locking manager as suggested in
https://www.srikalyan.com/post/151553721118/automate-docker-swarm-cluster-setup-in-aws

Then on each Docker node that is started, run a docker container (bound to the
host Docker socket) that will either start a cluster or join it. We know whether
the node is a worker or a manager simply with its instance tags.

Docker to run: srikalyan/aws-swarm-init

This is a clever and very minimal solution hence my implementation of it.

*/

resource "aws_dynamodb_table" "swarm-locking-manager" {
    name = "swarm_locking_manager"
    billing_mode = "PROVISIONED"
    read_capacity = 1
    write_capacity = 1
    hash_key = "node_type"
    attribute {
        type = "S"
        name = "node_type"
    }
}


