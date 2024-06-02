variable "role_name" {
  description = "The name of the IAM role"
  type        = string
}

variable "policy_name" {
  description = "The name of the IAM policy"
  type        = string
}

variable "secret_arn" {
  description = "The ARN of the secret"
  type        = string
}

variable "instance_profile_name" {
  description = "The name of the instance profile"
  type        = string
}
