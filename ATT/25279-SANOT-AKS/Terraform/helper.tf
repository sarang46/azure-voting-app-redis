
locals {
  resource_ids = {
    mysql    = module.MySqlDatabase.mysql_server_id
    sa       = lookup(module.BaseInfrastructure.sa_ids_map, var.base_infra_storage_accounts.sa1.name, null)
    sadbbkp  = lookup(module.BaseInfrastructure.sa_ids_map, var.base_infra_storage_accounts.sa2.name, null)
    keyvault = module.BaseInfrastructure.key_vault_id
    nva      = "/subscriptions/7eb51ca3-6c6a-4b62-a476-763c7d336385/resourceGroups/cnxs01-eastus2-lb-rg-001/providers/Microsoft.Network/privateLinkServices/30050-cnxs01-eastus2-001-nva-proxy-pls"
    squid    = "/subscriptions/7eb51ca3-6c6a-4b62-a476-763c7d336385/resourceGroups/cnxs01-eastus2-lb-rg-001/providers/Microsoft.Network/privateLinkServices/30050-cnxs01-eastus2-001-proxy-pls"
  }
  subnet_names = [for s in module.BaseInfrastructure.map_subnets : s.id]

linux_image_ids = {
    "hgphs-eastus2-preprod-jump-vm-001"  = var.hgphs_app_image_id

  }
}