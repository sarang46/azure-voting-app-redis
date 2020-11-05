# ---------------------------------------------------------
# Resources                                              
# ---------------------------------------------------------

module "BaseInfrastructure" {
  source                           = "../../common-library/TerraformModules/BaseInfrastructure"
  resource_group_name              = var.resource_group_name
  location                         = var.location
  virtual_networks                 = var.virtual_networks
  subnets                          = var.subnets
  route_tables                     = var.route_tables
  network_security_groups          = var.network_security_groups
  net_additional_tags              = var.additional_tags
  sku                              = var.sku               # law sku
  retention_in_days                = var.retention_in_days # law retention_in_days
  base_infra_keyvault_name         = var.base_infra_keyvault_name
  enabled_for_disk_encryption      = true
  network_acls                     = var.network_acls
  base_infra_log_analytics_name    = var.base_infra_log_analytics_name
  base_infra_storage_accounts      = var.base_infra_storage_accounts
  vnet_peering                     = {}
  diagnostics_storage_account_name = var.base_infra_storage_accounts.sa1.name
#  app_security_group_ids_map       = module.ApplicationSecurityGroup.app_security_group_ids_map
  app_security_group_ids_map       = {}
  mandatory_tags                   = var.mandatory_tags
}

module "LoadBalancer" {
  source                  = "../../common-library/TerraformModules/LoadBalancer"
  load_balancers          = var.Lbs
  resource_group_name     = module.BaseInfrastructure.resource_group_name
  zones                   = var.zones #based on zones will change the LB sku
  subnet_ids              = module.BaseInfrastructure.map_subnet_ids
  lb_additional_tags      = var.additional_tags
  load_balancer_rules     = var.LbRules
  load_balancer_nat_rules = var.LbNatRules
  lb_outbound_rules       = var.lb_outbound_rules
}

module "PrivateDNSZone" {
  source                   = "../../common-library/TerraformModules/PrivateDNSZone"
  private_dns_zones        = var.private_dns_zones
  resource_group_name      = module.BaseInfrastructure.resource_group_name
  vnet_ids                 = module.BaseInfrastructure.map_vnet_ids
  dns_zone_additional_tags = var.additional_tags
}

module "PrivateDNSARecord" {
  source                        = "../../common-library/TerraformModules/PrivateDNSARecord"
  dns_a_records                 = var.dns_a_records
  resource_group_name           = module.BaseInfrastructure.resource_group_name
  dns_arecord_additional_tags   = var.additional_tags
  private_endpoint_ip_addresses = module.PrivateEndpoint.private_ip_addresses_map
  a_records_depends_on          = module.PrivateDNSZone
}

# Private Link Services
module "PrivateLinkService" {
  source                         = "../../common-library/TerraformModules/PrivateLinkService"
  private_link_services          = var.private_link_services
  resource_group_name            = module.BaseInfrastructure.resource_group_name
  subnet_ids                     = module.BaseInfrastructure.map_subnet_ids
  frontend_ip_configurations_map = module.LoadBalancer.frontend_ip_configurations_map
  pls_additional_tags            = var.additional_tags
}


# Private Endpoints
module "PrivateEndpoint" {
  source              = "../../common-library/TerraformModules/PrivateEndpoint"
  private_endpoints   = var.private_endpoints
  resource_group_name = module.BaseInfrastructure.resource_group_name
  subnet_ids          = module.BaseInfrastructure.map_subnet_ids
  vnet_ids            = module.BaseInfrastructure.map_vnet_ids
  resource_ids        = local.resource_ids
  pe_additional_tags     = var.additional_tags
}

module "Virtualmachine" {
  source                       = "../../common-library/TerraformModules/VirtualMachine"
  resource_group_name          = module.BaseInfrastructure.resource_group_name
  key_vault_id                 = module.BaseInfrastructure.key_vault_id
  linux_vms                    = var.linux_vms
  linux_image_ids              = local.linux_image_ids
  administrator_user_name      = var.administrator_user_name
  administrator_login_password = var.administrator_login_password
  subnet_ids                   = module.BaseInfrastructure.map_subnet_ids
  lb_backend_address_pool_map  = module.LoadBalancer.pri_lb_backend_map_ids             #(Optional set it to null)
  sa_bootdiag_storage_uri      = module.BaseInfrastructure.primary_blob_endpoint[0] #(Mandatory)
  diagnostics_sa_name          = module.BaseInfrastructure.sa_name[0]
  law_workspace_id             = module.BaseInfrastructure.law_workspace_id
  law_workspace_key            = module.BaseInfrastructure.law_key
  vm_additional_tags           = var.additional_tags
#  recovery_services_vaults    = module.RecoveryServicesVault.map_recovery_vaults
  recovery_services_vaults     = null
  app_security_group_ids_map   = {}
  dependencies                 = [module.BaseInfrastructure.depended_on_kv, module.BaseInfrastructure.depended_on_sa]
}

module "Kubernetes" {
  source                     = "../../common-library/TerraformModules/Kubernetes"
  resource_group_name        = module.BaseInfrastructure.resource_group_name
  k8s_client_id              = var.client_id
  k8s_client_secret          = var.client_secret
  default_pool_subnet_id     = module.BaseInfrastructure.subnet_ids[0]
  k8s_cluster                = var.k8s_cluster
  k8s_default_pool           = var.k8s_default_pool
  k8s_extra_node_pools       = var.k8s_extra_node_pools
  log_analytics_workspace_id = module.BaseInfrastructure.law_id
}

module "MySqlDatabase" {
  source                              = "../../common-library/TerraformModules/MySqlDatabase"
  resource_group_name                 = module.BaseInfrastructure.resource_group_name
  subnet_ids                          = module.BaseInfrastructure.map_subnet_ids
  key_vault_id                        = module.BaseInfrastructure.key_vault_id
  server_name                         = var.server_name
  database_names                      = var.database_names
  administrator_login_password        = var.mysql_administrator_login_password
  administrator_login_name            = var.mysql_administrator_login_name
  allowed_subnet_names                = var.allowed_subnet_names
  sku_name                            = var.mysql_sku_name
  mysql_version                       = var.mysql_version
  storage_mb                          = var.storage_mb
  backup_retention_days               = var.backup_retention_days
  geo_redundant_backup                = var.geo_redundant_backup
  auto_grow                           = var.auto_grow
  private_endpoint_connection_enabled = var.private_endpoint_connection_enabled
  mysql_additional_tags               = var.additional_tags
  firewall_rules                      = var.firewall_rules
  mysql_configurations                = var.mysql_configurations
}

######### App Gateway #####
locals {
  sku      = "WAF_v2"
  tier     = "WAF_v2"
  capacity = "1"
}
#####################
# Public IP
#####################
resource "azurerm_public_ip" "agw_pip" {
  for_each            = var.app_gw
  name                = "${each.value["name"]}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  lifecycle {
    create_before_destroy = true
  }

}
resource "azurerm_application_gateway" "appgw" {
  for_each            = var.app_gw
  name                = each.value["name"]
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.resourcetags
  sku {
    name     = local.sku
    tier     = local.tier
    capacity = local.capacity
  }


  dynamic frontend_ip_configuration {
    for_each = lookup(each.value, "frontend_ip", [])
    content {
      name                 = frontend_ip_configuration.value.name
      public_ip_address_id = azurerm_public_ip.agw_pip[each.key].id
    }
  }

  dynamic gateway_ip_configuration {
    for_each = lookup(each.value, "gateway_ips", [])
    content {
      name      = gateway_ip_configuration.value.name
      subnet_id = lookup(module.BaseInfrastructure.map_subnet_ids, gateway_ip_configuration.value.subnet_name, null)
    }
  }

  dynamic frontend_port {
    for_each = lookup(each.value, "frontend_port", [])
    content {
      name = frontend_port.value.name
      port = frontend_port.value.port
    }
  }

  dynamic "identity" {
    for_each = var.msienable == "false" ? [] : list(var.msienable)
    content {
      type         = "UserAssigned"
      identity_ids = var.msienable
    }
  }

  waf_configuration {
    firewall_mode    = "Prevention"
    rule_set_type    = "OWASP"
    rule_set_version = "3.0"
    enabled          = true

  }

  dynamic probe {
    for_each = lookup(each.value, "probe", [])
    content {
      name                = probe.value.name
      protocol            = probe.value.protocol
      path                = probe.value.path
      host                = probe.value.host
      interval            = probe.value.interval
      timeout             = probe.value.timeout
      unhealthy_threshold = probe.value.unhealthy_threshold
    }
  }

  dynamic backend_address_pool {
    for_each = lookup(each.value, "backend_address_pool", [])
    content {
      name = backend_address_pool.value.name
    }
  }

  dynamic backend_http_settings {
    for_each = lookup(each.value, "backend_http_settings", [])
    content {
      name                  = backend_http_settings.value.name
      cookie_based_affinity = backend_http_settings.value.cookie_based_affinity == null ? null : backend_http_settings.value.cookie_based_affinity
      path                  = backend_http_settings.value.path
      port                  = backend_http_settings.value.port
      protocol              = backend_http_settings.value.protocol
      request_timeout       = backend_http_settings.value.request_timeout
    }
  }
  dynamic http_listener {
    for_each = lookup(each.value, "http_listener", null)
    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = http_listener.value.frontend_ip_configuration_name
      frontend_port_name             = http_listener.value.frontend_port_name
      protocol                       = http_listener.value.protocol
      ssl_certificate_name           = http_listener.value.ssl_certificate_name
      # for basic listener you can define host_name as "null"
      host_name   = http_listener.value.host_name
      require_sni = http_listener.value.require_sni
    }

  }
  dynamic request_routing_rule {
    for_each = lookup(each.value, "request_routing_rule", [])
    content {
      name                       = request_routing_rule.value["name"]
      rule_type                  = lookup(request_routing_rule.value, "ruletype", null) == "PathBasedRouting" ? "PathBasedRouting" : "Basic"
      http_listener_name         = request_routing_rule.value.http_listener_name
      backend_address_pool_name  = request_routing_rule.value.backend_address_pool_name
      backend_http_settings_name = request_routing_rule.value.backend_http_settings_name
      url_path_map_name          = lookup(request_routing_rule.value, "ruletype", null) == "PathBasedRouting" ? request_routing_rule.value.url_path_map_name : null
    }
  }
  dynamic url_path_map {
    for_each = var.ruletype == "PathBasedRouting" ? lookup(each.value, "url_path_map", []) : []
    content {
      name                               = url_path_map.value["name"]
      default_backend_http_settings_name = url_path_map.value["default_backend_http_settings_name"]
      default_backend_address_pool_name  = url_path_map.value["default_backend_address_pool_name"]
      dynamic path_rule {
        for_each = var.ruletype == "PathBasedRouting" ? lookup(each.value, "path_rule", []) : []
        content {
          name                       = path_rule.value.name
          paths                      = split(":", path_rule.value.paths)
          backend_http_settings_name = path_rule.value.backend_http_settings_name
          backend_address_pool_name  = path_rule.value.backend_address_pool_name

        }
      }
    }
  }


  // dynamic ssl_certificate {
  //   for_each = lookup(each.value, "ssl_certificate", null)
  //   content {
  //   name     = ssl_certificate.value.name
  //   data     = filebase64(ssl_certificate.value.name)
  //   password = ssl_certificate.value.password
  //   }
  // }

  //   ssl_policy {
  //     disabled_protocols = ["TLSv1_0", "TLSv1_1"]
  //   }
}
