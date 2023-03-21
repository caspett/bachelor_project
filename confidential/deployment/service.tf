# This creates a LoadBalancer, which routes traffic from the external load balancer to pods with the matching selector.
resource "kubernetes_service" "load_balancer" {
  metadata {
    name = "conf-load-balancer"
  }
  spec {
    selector = {
      # App = kubernetes_deployment.apache_server.spec.0.template.0.metadata[0].labels.App
      App = "sgx-test"

    }
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
    depends_on = [
    kubernetes_deployment.apache_server, data.azurerm_kubernetes_cluster.this
  ]  
}

# This will set lb_ip to your Azure ingress' IP address.
output "lb_ip" {
  value = kubernetes_service.load_balancer.status.0.load_balancer.0.ingress.0.ip
}

output "app-name" {
  value = kubernetes_deployment.apache_server.spec.0.template.0.metadata[0].labels.App
}