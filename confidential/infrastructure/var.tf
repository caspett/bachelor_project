variable "target_resource_group" {
  description = "Location to deploy infrastructure"
  default     = "rg-confidential-dev"
}

variable "config_path" {
  description = "Path to kube config"
}

variable "mysql_passwd" {
  default   = "H@Sh1CoR3!123"
  sensitive = true
}

