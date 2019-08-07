#!/bin/bash
INSTANCE_ID=`wget -qO- http://instance-data/latest/meta-data/instance-id`
REGION=`wget -qO- http://instance-data/latest/meta-data/placement/availability-zone | sed 's/.$//'`
aws ec2 describe-tags --region $REGION --filter "Name=resource-id,Values=$INSTANCE_ID" --output=text | sed -r 's/TAGS\t(.*)\t.*\t.*\t(.*)/\1="\2"/' > /etc/ec2-tags

source /etc/ec2-tags

export NODE_TYPE="${swarm_node_type}"
export DYNAMODB_TABLE="swarm_locking_manager"
docker run -v /var/run/docker.sock:/var/run/docker.sock -v /home/ubuntu/join-swarm-entry.sh:/entry.sh -v /usr/bin/docker:/usr/bin/docker -v /var/log:/var/log -e REGION -e DYNAMODB_TABLE -e NODE_TYPE srikalyan/aws-swarm-init 

