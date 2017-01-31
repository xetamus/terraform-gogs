variable "aws" { default =  {} }

# free tier instance type
variable "instance_type" { default = "t2.micro" }

# free tier ubuntu xenial image
variable "ami_ids" {
  default {
    "us-east-1" = "ami-e13739f6"
    "us-east-2" = "ami-d1cb91b4"
  }
}
