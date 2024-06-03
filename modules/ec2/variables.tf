variable "ami_name" {
  description = "The name of the AMI to use"
  type        = string
  default     = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
}

variable "owners" {
  description = "The owners of the AMI"
  type        = list(string)
  default     = ["099720109477"]
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "sg_name" {
  description = "EC2 user data"
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

variable "key_pair_name" {
  description = "The key name to use for the instance"
  type        = string
}

variable "iam_instance_profile" {
  description = "The IAM instance profile to use for the instance"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the instance"
  type        = map(string)
}

variable "user_data" {
  description = "EC2 user data"
  type        = string
}

variable "key_pair_version" {
  description = "The ID of the key pair version from Secrets Manager"
  type        = string
}
