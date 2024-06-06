variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "ami_name" {
  description = "The name of the AMI to use"
  type        = string
  default = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
}

variable "virtualization_type" {
  description = "EC2 architecture"
  type        = string
}

variable "owners" {
  description = "The owners of the AMI"
  type        = list(string)
}

variable "private_ip" {
  description = "The private IP to assign"
  type        = string
}

variable "ec2_key_pair_name" {
  description = "The key name to use for the instance"
  type        = string
}

variable "ec2_key_pair_value" {
  description = "The value of the key pair"
  type        = string
}

variable "lifecycle_ignore_changes" {
  description = "lifecycle_ignore_changesr"
  type        = bool
  default     = false
}

variable "sql_creds_name" {
  description = "The name of the MySQL credentials secret"
  type        = string
}

variable "secret_username" {
  type        = string
}

variable "passwd_len" {
  description = "The length of the random password"
  type        = number
}


variable "vpc_name" {
  description = "The name for the VPC"
  type        = string
}

variable "subnet_name" {
  description = "The name for the subnet"
  type        = string
}

variable "igw_name" {
  description = "The name for the internet gateway"
  type        = string
}

variable "route_table_name" {
  description = "The name for the route table"
  type        = string
}

variable "role_name" {
  description = "The name of the IAM role"
  type        = string
}

variable "policy_name" {
  description = "The name of the IAM policy"
  type        = string
}

variable "instance_profile_name" {
  description = "The name of the instance profile"
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

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
}

variable "tf_state_bucket" {
  description = "The name of the S3 bucket for storing Terraform state"
  type        = string
}

variable "tf_state_dynamodb_table" {
  description = "The name of the DynamoDB table for Terraform state locking"
  type        = string
}

variable "tf_state_key" {
  description = "The key for the Terraform state file in the S3 bucket"
  type        = string
}
