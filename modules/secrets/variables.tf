variable "passwd_len" {
  description = "The length of the random password"
  type        = number
  default     = 16
}

variable "secret_name" {
  description = "The name of the MySQL credentials secret"
  type        = string
}

variable "secret_description" {
  description = "The name of the MySQL credentials secret"
  type        = string
}

variable "secret_string" {
  description = "The name of the MySQL credentials secret"
  type        = string
}

variable "username" {
  description = "The name of the MySQL credentials secret"
  type        = string
  default     = "admin"
}

variable "lifecycle_ignore_changes" {
  description = "lifecycle_ignore_changesr"
  type        = bool
  default     = false
}
