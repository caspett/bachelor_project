# resource "kubernetes_secret" "database-creds" {
#   metadata {
#     name = "database-creds"
#   }
#   data = {
#     username = azurerm_mssql_server.this.administrator_login
#     password = azurerm_mssql_server.this.administrator_login_password
#     server   = azurerm_mssql_server.this.fully_qualified_domain_name
#     database = azurerm_mssql_database.this.name
#   }
#   type = "Opaque"
# }

#The "kubernetes_deployment" resource defines the desired state of your application, including the number of replicas you want to run, the container image to use, and the ports to expose. 
# The deployment ensures that the desired number of replicas are running at any given time.

resource "kubernetes_deployment" "nginx" {
  metadata {
    name = "scalable-nginx-example"
    labels = {
      App = "ScalableNginxExample"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "ScalableNginxExample"
      }
    }
    template {
      metadata {
        labels = {
          App = "ScalableNginxExample"
        }
      }
      spec {
        container {
          name  = "example"
          # image = "nginx:1.7.8"
          image = "kubdocker.azurecr.io/apache_server:latest"
          # image_pull_policy = "Never"
          env {
              name  = "DB_HOST"
              value = data.azurerm_mysql_server.this.fqdn
            }

          env {
              name  = "DB_USER"
              value = data.azurerm_mysql_server.this.administrator_login
            }
          env {
              name  = "DB_PASS"
              value = var.mysql_passwd
            }
          env {
              name  = "DB_NAME"
              value = "mydb"
            }
          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
    depends_on = [
    data.azurerm_kubernetes_cluster.this, azurerm_role_assignment.this
  ]  
}

output "username" {
 value =  data.azurerm_mysql_server.this
}
