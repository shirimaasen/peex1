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
  default     = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
}

variable "owners" {
  description = "The owners of the AMI"
  type        = list(string)
  default     = ["099720109477"]
}

variable "private_ip" {
  description = "The private IP to assign"
  type        = string
  default = "10.0.1.50"
}

variable "key_pair_name" {
  description = "The key name to use for the instance"
  type        = string
  default = "peex"
}

variable "lifecycle_ignore_changes" {
  description = "lifecycle_ignore_changesr"
  type        = bool
  default     = false
}