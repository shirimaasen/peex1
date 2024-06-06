variable "ami_name" {
  description = "The name of the AMI to use"
  type        = string
}

variable "virtualization_type" {
  description = "EC2 architecture"
  type        = string
}

variable "owners" {
  description = "The owners of the AMI"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "sg_name" {
  description = "SG name"
  type        = string
}

variable "sg_tag" {
  description = "SG tag"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID"
  type        = string
}

variable "private_ip" {
  description = "The private IP to assign"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
}

variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
}

variable "iam_instance_profile" {
  description = "The IAM instance profile to use for the instance"
  type        = string
}

variable "instance_profile_name" {
  description = "The name of the instance profile"
  type        = string
}

variable "role_name" {
  description = "The name of the instance profile"
  type        = string
}

variable "ec2_tags" {
  description = "A map of tags to assign to the instance"
  type        = map(string)
}

variable "user_data" {
  description = "EC2 user data"
  type        = string
}
