variable "aws_region" {
  default = "us-east-1"
}

variable "ami_id" {
  description = "Amazon Linux 2023 AMI ID"
}

variable "key_name" {
  description = "EC2 Key Pair Name"
}
