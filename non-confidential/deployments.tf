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
          image = "nginx:1.7.8"

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
    azurerm_kubernetes_cluster.this
  ]  
}

