resource "azurerm_resource_group" "wordpress" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "wordpress" {
  name                = var.cluster_name
  kubernetes_version  = "1.29.4"
  location            = azurerm_resource_group.wordpress.location
  resource_group_name = azurerm_resource_group.wordpress.name
  dns_prefix          = var.dns_prefix

  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }

  default_node_pool {
    name                        = "agentpool"
    temporary_name_for_rotation = "tmpnppool01"
    node_count                  = var.agent_count
    vm_size                     = "Standard_B2pls_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "kubenet"
  }

  tags = {
    Environment = "Development"
  }
}
