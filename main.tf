provider "aws" {
region = "us-east-1"
}

resource "aws_instance" "server1" {
 tag{
 Name = "ec2-server1"
}
instance_type = "micro"
ami = "ami-0e0dab2e7d3136219"
key_name = "Mahadev"
availability_zone = "us-east-1a"
vpc_security_group_ids = "sg-0d31b7d6f4c99f15e"
root_block_device{
volume_size = 20
}
count = 1
}
