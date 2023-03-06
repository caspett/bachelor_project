variable "target_resource_group" {
  description = "Location to deploy infrastructure"
  default     = "rg-confidential-dev"
}

variable "config_path" {
  description = "Path to kube config"
  default = "C:/Users/Cn5043/.kube/config"
}

# Azure mysql server and database variables
variable "mysql_server_name" {
  description = "Server name"
  default = "conf-mysqlserver"
}

variable "mysql_database_name" {
  description = "Database name"
  default = "mydb"
}

variable "cluster_name" {
  description = "Target cluster name"
  default = "conf-arck-web-cluster"
}

variable "mysql_passwd" {
  default = "H@Sh1CoR3!123"
  sensitive = true
}
