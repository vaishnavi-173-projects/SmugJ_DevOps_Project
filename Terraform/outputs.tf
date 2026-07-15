output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "Exposes resource group name for pipeline consumption"
}

output "acr_login_server" {
  value       = azurerm_container_registry.acr.login_server
  description = "Exposes registry address for image tag mapping"
}

output "aks_cluster_name" {
  value       = azurerm_kubernetes_cluster.aks.name
  description = "Exposes cluster context identifier for Kubernetes deploy actions"
}