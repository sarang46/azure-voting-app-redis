aks_resource_id = "/subscriptions/b240e872-199b-4398-8da5-410ad8137c0a/resourcegroups/wfecast-eastus2-prd-rg-01/providers/Microsoft.ContainerService/managedClusters/wfecast-29624-prd-AKScluster"
location            = "eastus2"
# - Private DNS for ADO agent connectivity
ado_k8s_private_endpoint_name   = "wfecast-prd-ado-pe-01"
ado_subnet_name                 = "eastus2-29624-devops-vnet-snet"
ado_vnet_name                   = "eastus2-29624-devops-vnet"
ado_k8s_private_connection_name = "wfecast-prd-ado-pec-01"
ado_resource_group_name         = "29624-eastus2-devops-rg"
ado_private_dns_vnet_link_name  = "wfecast-prd-ado-vnet-link"
ado_aks_zone = "bca7a0ed-69aa-485d-9ac5-1b9b703ba59f.privatelink.eastus2.azmk8s.io"
ado_aks_arecord = "wfecastprd-df2f53e3"

# Azure container registry 
acr_name = "29624wfecastacr"
acr_pe_name = "wfecast-prd-acr-pe-01"
pe_acr_record_name = "29624wfecastprdacr"
pe_acr_vnetlink_name = "29624-wfecast-prd-vlink-acr"
acr_private_connection_name = "wfecast-prd-acr-pec-01"