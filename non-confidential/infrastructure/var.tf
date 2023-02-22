variable "target_resource_group" {
  description = "Location to deploy infrastructure"
  default     = "rg-non-confidential-dev"
}

variable "config_path" {
  description = "Path to kube config"
  default     = "C:/Users/Cn5043/.kube/config"
}

variable "mssql_passwd" {
  default   = "4-v3ry-53cr37-p455w0rd"
  sensitive = true
}

variable "mysql_passwd" {
  default   = "H@Sh1CoR3!123"
  sensitive = true
}

