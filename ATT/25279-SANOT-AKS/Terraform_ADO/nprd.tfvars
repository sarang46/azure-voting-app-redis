aks_resource_id = "/subscriptions/474edc39-4b93-4b70-8436-6c5b890eebae/resourcegroups/WFECAST-eastus2-nprd-rg-01/providers/Microsoft.ContainerService/managedClusters/wfe-29624-nprd-AKScluster"
location        = "eastus2"
# - Private DNS for ADO agent connectivity
ado_k8s_private_endpoint_name   = "wfecast-nprd-ado-pe-01"
ado_subnet_name                 = "eastus2-29624-devops-vnet-snet"
ado_vnet_name                   = "eastus2-29624-devops-vnet"
ado_k8s_private_connection_name = "wfecast-nprd-ado-pec-01"
ado_resource_group_name         = "29624-eastus2-devops-rg"
ado_private_dns_vnet_link_name  = "wfecast-nprd-ado-vnet-link"
ado_aks_zone = "ad06e69f-ebba-42d1-9355-b359ced4e7c1.privatelink.eastus2.azmk8s.io"
ado_aks_arecord = "wfecastnprd-35a9147d"

# Azure container registry 
acr_name = "29624wfecastacr"
acr_pe_name = "wfecast-nprd-acr-pe-01"
pe_acr_record_name = "29624wfecastnprdacr"
pe_acr_vnetlink_name = "29624-wfecast-nprd-vlink-acr"
acr_private_connection_name = "wfecast-nprd-acr-pec-01"