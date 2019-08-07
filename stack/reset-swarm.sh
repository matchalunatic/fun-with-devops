#!/bin/sh
terraform taint aws_dynamodb_table.swarm-locking-manager
