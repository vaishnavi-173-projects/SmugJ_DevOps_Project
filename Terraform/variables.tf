variable "resource_group_name" {
  type        = string
  description = "Name of the main corporate resource group"
}

variable "location" {
  type        = string
  description = "Target Azure data center region"
}

variable "cluster_name" {
  type        = string
  description = "Name of the production AKS cluster"
}

variable "acr_name" {
  type        = string
  description = "Globally unique name for Azure Container Registry"
}