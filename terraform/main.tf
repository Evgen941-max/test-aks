terraform {
  required_providers {
    azurerm = {
        source          = "hashicorp/azurerm"
        version         = "2.48.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name          = "leark8sResourceGroup"
  location      = "northeurope"
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = "learnk8scluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "learnk8sclustertest"

  default_node_pool {
    name              = "default"
    node_count        = 1
    vm_size           = "standard_d2_v2"
  }

  identity {
    type              = "SystemAssigned"
  }

  addon_profile {
    http_application_routing {
      enabled         = true
    }
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "mem" {
  kubernetes_cluster_id   = azurerm_kubernetes_cluster.cluster.id
  name                    = "mem"
  node_count              = "1"
  vm_size                 = "standard_d11_v2"
}

resource "azurerm_container_registry" "mem" {
  name                = var.name-acr
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Premium"
  admin_enabled       = true
}