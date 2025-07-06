resource "azurerm_resource_group" "aks_rg" {
  name     = "aks-h09-rg"
  location = "Canada Central"
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "aks-h09-cluster"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "h09lab"

  default_node_pool {
    name                = "default"
    vm_size             = "Standard_B2s"
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 3
    type                = "VirtualMachineScaleSets"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }

  tags = {
    environment = "lab"
    owner       = "student"
  }
}

