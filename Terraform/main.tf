# 1. Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# 2. Create Azure Container Registry (ACR) to hold Docker Images
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic" # Cost-effective for students
  admin_enabled       = true
}

# 3. Create Azure Kubernetes Service (AKS) Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "devopsprojectaks"

  default_node_pool {
    name       = "default"
    node_count = 1              # Uses a single node to fit student quotas
    vm_size    = "Standard_B2s" # Cheap burstable tier VM
  }

  identity {
    type = "SystemAssigned"
  }
}

# 4. Bind AKS and ACR so Kubernetes can fetch images
resource "azurerm_role_assignment" "aks_to_acr" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kube_let_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}