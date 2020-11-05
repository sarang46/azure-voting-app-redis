#############################################################################
# OUTPUTS Network
#############################################################################

output "network_security_group_ids" {
  value = module.BaseInfrastructure.network_security_group_ids
}
output "map_vnets" {
  value = module.BaseInfrastructure.map_vnets
}
output "map_subnets" {
  value = module.BaseInfrastructure.map_subnets
}
output "subnets_with_serviceendpoints" {
  value = module.BaseInfrastructure.subnets_with_serviceendpoints
}
output "private_endpoint_vnets" {
  value = module.BaseInfrastructure.private_endpoint_vnets
}
output "private_endpoint_subnets" {
  value = module.BaseInfrastructure.private_endpoint_subnets
}

#############################################################################
# OUTPUTS LAW
#############################################################################

output "law_workspace" {
  description = ""
  value       = module.BaseInfrastructure.law_workspace
}

output "law_id" {
  description = ""
  value       = module.BaseInfrastructure.law_id
}

output "law_name" {
  description = ""
  value       = module.BaseInfrastructure.law_name
}

output "law_key" {
  description = ""
  value       = module.BaseInfrastructure.law_key
}

#############################################################################
# OUTPUTS Storage Account
#############################################################################

output "sa_name" {
  value = module.BaseInfrastructure.sa_name
}

output "sa_id" {
  value = module.BaseInfrastructure.sa_id
}

output "primary_blob_endpoint" {
  value = module.BaseInfrastructure.primary_blob_endpoint
}

output "container_id" {
  value = module.BaseInfrastructure.container_id
}

output "blob_id" {
  value = module.BaseInfrastructure.blob_id
}

output "blob_url" {
  value = module.BaseInfrastructure.blob_url
}

output "file_share_id" {
  value = module.BaseInfrastructure.file_share_id
}

output "file_share_url" {
  value = module.BaseInfrastructure.file_share_url
}

#############################################################################
# OUTPUTS Key Vault
#############################################################################

output "key_vault_id" {
  value = module.BaseInfrastructure.key_vault_id
}

output "key_vault" {
  value = module.BaseInfrastructure.key_vault
}

output "key_vault_policy" {
  value = module.BaseInfrastructure.key_vault_policy
}

############################################################################
# OUTPUTS Private loadbalancer
############################################################################

output "pri_lb_names" {
  value = module.LoadBalancer.pri_lb_names
}

output "pri_lb_private_ip_address" {
  value =  module.LoadBalancer.pri_lb_private_ip_address
}

output "pri_lb_backend_ids" {
  value = module.LoadBalancer.pri_lb_backend_ids
}

output "pri_lb_rule_ids" {
  value =  module.LoadBalancer.pri_lb_rule_ids
}
output "pri_lb_probe_ids" {
  value =  module.LoadBalancer.pri_lb_probe_ids
}