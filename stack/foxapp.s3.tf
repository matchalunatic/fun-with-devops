resource "aws_s3_bucket" "swarmstacksbucket" {
    bucket = "swarmstacksbucket"
    acl = "private"
}

resource "aws_s3_bucket_object" "foxappStack" {
    bucket = "${aws_s3_bucket.swarmstacksbucket.id}"
    source = "stacks/foxapp.dab"
    key = "foxapp.dab"
}


