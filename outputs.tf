resource "local_file" "kubeconfig" {
  depends_on    = [ azurerm_kubernetes_cluster.cluster ]
  filename      = "kubeconfig"
  content       = azurerm_kubernetes_cluster.cluster.kube_config_raw
}

output "acr-id" {
  value = azurerm_container_registry.mem.id
}

output "acr-login-server" {
  value = azurerm_container_registry.mem.login_server
}

output "acr-name" {
  value = azurerm_container_registry.mem.name
}

output "acr-password" {
  value = azurerm_container_registry.mem.admin_password
  sensitive = true
}

output "acr-user" {
  value = azurerm_container_registry.mem.admin_username
}