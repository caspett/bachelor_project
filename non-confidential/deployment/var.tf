variable "target_resource_group" {
  description = "Location to deploy infrastructure"
  default     = "rg-non-confidential-dev"
}

variable "config_path" {
  description = "Path to kube config"
  default = "C:/Users/Cn5043/.kube/config"
}

variable "mssql_server_name" {
  description = "Server name"
  default = "non-confidential-sqlserver"
}

variable "mssql_database_name" {
  description = "Database name"
  default = "acctest-db-d"
}

variable "cluster_name" {
  description = "Target cluster name"
  default = "arck-web-cluster"
}

variable "administrator_login_password" {
  default = "4-v3ry-53cr37-p455w0rd"
  sensitive = true
}

variable "mysql_passwd" {
  default = "H@Sh1CoR3!123"
  sensitive = true
}
