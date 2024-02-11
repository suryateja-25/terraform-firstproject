variable "aws_secret_key" {
  type        = string
  sensitive   = true
  description = "value of the secret key for the AWS provider"
}

variable "ec2_ami" {
  type        = string
  description = "AMI to use for the EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "Type of EC2 instance to launch"
}

variable "env" {
  type        = string
  description = "The environment for the resources"
}

variable "availability_zone" {
  type        = string
  description = "The availability zone for the resources"
}

variable "availability_zone_2" {
  type        = string
  description = "The second availability zone for the resources"
}