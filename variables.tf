variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "ap-southeast-2"
}

variable "aws_ami" {
  default = {
    "ap-southeast-2" = "ami-0b55fc9b052b03618"
  }
}
# Need to add more AMI for shell catching

