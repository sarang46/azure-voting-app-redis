data "azurerm_virtual_network" "this" {
  name                = var.ado_vnet_name
  resource_group_name = var.ado_resource_group_name
}

data "azurerm_subnet" "this" {
  name                 = var.ado_subnet_name
  virtual_network_name = var.ado_vnet_name
  resource_group_name  = var.ado_resource_group_name
}

data "azurerm_container_registry" "this" {   
  name                = var.acr_name  
  resource_group_name = var.ado_resource_group_name
}

# private endpoint to AKS API server from PE subnet  which is in devops services rg
resource "azurerm_private_endpoint" "aksapi" {
  name                = var.ado_k8s_private_endpoint_name
  location            = var.location
  resource_group_name = var.ado_resource_group_name
  subnet_id           = data.azurerm_subnet.this.id

  private_service_connection {
    name                           = var.ado_k8s_private_connection_name
    private_connection_resource_id = var.aks_resource_id
    is_manual_connection           = false
    subresource_names = [
      "management"
    ]
  }
}

resource "azurerm_private_dns_zone" "aks" {
  name                = var.ado_aks_zone
  resource_group_name = var.ado_resource_group_name
}

resource "azurerm_private_dns_a_record" "aks" {
  name                = var.ado_aks_arecord
  zone_name           = azurerm_private_dns_zone.aks.name
  resource_group_name = var.ado_resource_group_name
  ttl                 = 300
  records             = [azurerm_private_endpoint.aksapi.private_service_connection[0].private_ip_address]
}

resource "azurerm_private_dns_zone_virtual_network_link" "aks" {
  name                  = var.ado_private_dns_vnet_link_name
  resource_group_name   = var.ado_resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.aks.name
  virtual_network_id    = data.azurerm_virtual_network.this.id
}


output "acr_id" {
  value = data.azurerm_container_registry.this.id
}

## private endpoint for ACR which is in devops services rg
# resource "azurerm_private_endpoint" "acr" {
#   name                = var.acr_pe_name
#   location            = var.location
#   resource_group_name = module.BaseInfrastructure.resource_group_name
#   subnet_id           = module.BaseInfrastructure.subnet_ids[3]

#   private_service_connection {
#     name                           = var.acr_private_connection_name
#     private_connection_resource_id = data.azurerm_container_registry.this.id
#     is_manual_connection           = false
#     subresource_names = [
#       "registry"
#     ]
#   }
# }

# resource "azurerm_private_dns_zone" "acr" {
#   name                = "privatelink.azurecr.io"
#   resource_group_name = module.BaseInfrastructure.resource_group_name
# }

# resource "azurerm_private_dns_a_record" "acr" {
#   name                = var.pe_acr_record_name
#   zone_name           = azurerm_private_dns_zone.acr.name
#   resource_group_name = module.BaseInfrastructure.resource_group_name
#   ttl                 = 300
#   records             = [azurerm_private_endpoint.acr.private_service_connection[0].private_ip_address]
# }

# resource "azurerm_private_dns_zone_virtual_network_link" "acr" {
#   name                  = var.pe_acr_vnetlink_name
#   resource_group_name   = module.BaseInfrastructure.resource_group_name
#   private_dns_zone_name = azurerm_private_dns_zone.acr.name
#   virtual_network_id    = module.BaseInfrastructure.vnet_ids[0]
# }