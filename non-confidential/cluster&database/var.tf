variable "target_resource_group" {
  description = "Location to deploy infrastructure"
  default     = "rg-non-confidential-dev"
}

variable "config_path" {
  description = "Path to kube config"
  default = "C:/Users/Cn5043/.kube/config"
}

variable "administrator_login_password" {
  default = "4-v3ry-53cr37-p455w0rd"
  sensitive = true
}
