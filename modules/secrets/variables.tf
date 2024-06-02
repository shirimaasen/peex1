variable "passwd_len" {
  description = "The length of the random password"
  type        = number
  default     = 16
}

variable "peex_creds" {
  description = "The name of the MySQL credentials secret"
  type        = string
}

variable "peex_creds_desc" {
  description = "The name of the MySQL credentials secret"
  type        = string
}

variable "username" {
  description = "The name of the MySQL credentials secret"
  type        = string
  default     = "admin"
}

variable "peex_key_pair_name" {
  description = "The name of the key pair secret"
  type        = string
}

variable "peex_key_pair_desc" {
  description = "The name of the key pair secret"
  type        = string
}

variable "peex_key_pair_value" {
  description = "The value of the key pair"
  type        = string
  default     = "peex"
}
