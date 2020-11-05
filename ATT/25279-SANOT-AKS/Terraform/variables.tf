#############################################################################
# TERRAFORM BACKEND STATE VARIABLES
#############################################################################

variable "tenant_id" {
  description = "Azure tenant Id"
}
variable "subscription_id" {
  description = "Azure subscription Id."
}
variable "client_id" {
  description = "Azure service principal application Id"
}
variable "client_secret" {
  description = "Azure service principal application Secret"
}


#############################################################################
# GENERAL VARIABLES
#############################################################################

variable "resource_group_name" {
  type        = string
  description = "The Azure resource group where your resources will be created"
}

variable "location" {
  type        = string
  description = "The Azure region where your resources will be created"
}

variable "additional_tags" {
  type        = map(string)
  description = "A key value pair tags for your resources"
  default = {
    iac = "terraform"
  }
}

variable "mandatory_tags" {
  type = any
  default = {
    created_by = "sb288n@att.com"
    contact_dl = "AzMig-TM-Team10@list.att.com"
    mots_id    = "10584"
    auto_fix   = "yes"
  }
}

variable "base_infra_keyvault_name" {
  type        = string
  description = "The default Keyvault that will be created as part of Base Infrastructure"
}

variable "base_infra_storage_accounts" {
  type        = any
  description = "The default storage account that will be created as part of Base Infrastructure"
}

variable "base_infra_log_analytics_name" {
  type        = string
  description = "The default storage account that will be created as part of Base Infrastructure"
}

variable "administrator_user_name" {
  default = "unset"
}
variable "administrator_login_password" {
  default = "unset"
}

#############################################################################
# VARIABLES
#############################################################################

# -
# - Network object
# -
variable "virtual_networks" {
  type = any
}

variable "subnets" {
  type = any
}

# -
# - Route Table
# -
variable "route_tables" {
  type = any
}

# -
# - Network Security Group
# -
variable "network_security_groups" {
  type = any
}

# -
# - Log Analytics Workspace
# -
variable "sku" {
  type = string
}
variable "retention_in_days" {
  type = string
}
variable "log_analytics_workspace" {
  type = string
}

###### Storage Account

# Container
variable "containers" {
  type        = any
  default     = {}
  description = "map of storage containers."
}

# Blob
variable "blobs" {
  type        = map
  default     = {}
  description = "map of storage blobs."
}

# File Share
variable "file_shares" {
  type        = any
  default     = {}
  description = "map of storage file shares."
}

# Queue
variable "queues" {
  type        = any
  default     = {}
  description = "map of storages queues."
}

# Table
variable "tables" {
  type        = any
  default     = {}
  description = "map of storage tables."
}

###### Key Vault
variable "network_acls" {
  default = null
  type    = any
}

# -
# - Private LoadBalancer
# -
variable "zones" {
  description = "SKU of the load balancer. Basic if empty"
  type        = list(string)
  default     = []
}

variable "Lbs" {
  type    = any
  default = {}
}

variable "LbRules" {
  type    = any
  default = {}
}

variable "LbNatRules" {
  type    = any
  default = {}
}

variable "lb_outbound_rules" {
  type    = any
  default = {}
}

# -
# - VM
# -

variable "linux_vms" {
  type = any
}


variable "hgphs_app_image_id" {
  type = any
}

variable "windows_vms" {
  type = any
}

variable "linux_image_ids" {
  type    = map
  description = "The ID of an Image which each Virtual Machine should be based on."
  default = {}
}


# -
# - PRIVATE ENDPOINTS
# -
variable "private_endpoints" {
  type = any
}


# -
# - PRIVATE Link Services
# -
variable "private_link_services" {
  type = any
}


# -
# - Recovery Services Vault
# -
#variable "recovery_services_vaults" {
#  type = any
#}

############################
# Storage Account
############################
#variable "storage_accounts" {
#  type = map(object({
#    name            = string
#    sku             = string
#    account_kind    = string
#    access_tier     = string
#    assign_identity = bool
#    cmk_enable      = bool
#    network_rules = object({
#      bypass                     = list(string) # (Optional) Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None.
#      default_action             = string       # (Required) The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny.
#      ip_rules                   = list(string) # (Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault.
#      virtual_network_subnet_ids = list(string) # (Optional) One or more Subnet ID's which should be able to access this Key Vault.
#    })
#  }))
#  description = "Map of storage accouts which needs to be created in a resource group"
#}


variable "managed_data_disks" {
  type = any
  description = "Map containing storage data disk configurations"
  default     = {}
}

## DNS ##

variable "private_dns_zones" {
  type = map(object({
    dns_zone_name            = string
    vnet_name                = string
    zone_exists              = bool
    zone_to_vnet_link_exists = bool
    registration_enabled     = bool
  }))
  description = "Map containing Private DNS Zone Objects"
}

variable "dns_a_records" {
  type = map(object({
    a_record_name         = string
    dns_zone_name         = string
    ttl                   = number
    ip_addresses          = list(string)
    private_endpoint_name = string
  }))
  description = "Map containing Private DNS A Records Objects"
}

# - AKS
# -

variable "k8s_default_pool" {
  type = any
}

variable "k8s_cluster" {
  type = object({
    name                  = string
    dns_prefix            = string
    kubernetes_version    = string
    service_address_range = string
    dns_ip                = string
    node_subnet_name      = string
  })
}

variable "k8s_extra_node_pools" {
  type = any
}

## mysql variables
variable "server_name" {
  type        = string
  description = "The name of the MyQL Server"
}

variable "database_names" {
  type        = list(string)
  description = "List of MySQL database names"
}

variable "mysql_administrator_login_name" {
  type        = string
  description = "The administrator username of MySQL Server"
}

variable "mysql_administrator_login_password" {
  type        = string
  description = "The administrator password of the MySQL Server"
}

variable "allowed_subnet_names" {
  type        = list(string)
  description = "The list of subnet names that the MySQL server will be connected to"
}

variable "mysql_sku_name" {
  type        = string
  description = "Specifies the SKU Name for this MySQL Server"
}

variable "mysql_version" {
  type        = number
  description = "Specifies the version of MySQL to use. Valid values are 5.6, 5.7, and 8.0"
}

variable "storage_mb" {
  type        = number
  description = "Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 4194304 MB(4TB) for General Purpose/Memory Optimized SKUs."
}

variable "backup_retention_days" {
  type        = number
  description = "Backup retention days for the server, supported values are between 7 and 35 days."
}

variable "geo_redundant_backup" {
  type        = string
  description = "Enable Geo-redundant or not for server backup. Valid values for this property are Enabled or Disabled, not supported for the basic tier."
}

variable "auto_grow" {
  type        = string
  description = "(Optional) Defines whether autogrow is enabled or disabled for the storage. Valid values are Enabled or Disabled."
}

variable "mysql_configurations" {
  type        = map(any)
  description = "Map of MySQL configuration settings to create. Key is name, value is server parameter value"
}

variable "firewall_rules" {
  type        = any
  description = "List of MySQL Server firewall rule specification"
}

variable "private_endpoint_connection_enabled" {
  type        = bool
  description = "Specify if only private endpoint connections will be allowed to access this resource"
}

##### app gateway
variable "resourcetags" {
  type = map(string)
}

variable "ruletype" {

}
variable "msienable" {
  default = "false"
}

variable "app_gw" {
  type = map(object({
    name = string

    frontend_ip = list(object({
      name = string
    }))

    gateway_ips = list(object({
      name        = string
      subnet_name = string
    }))


    frontend_port = list(object({
      name = string
      port = number
    }))

    probe = list(object({
      name                = string
      protocol            = string
      path                = string
      host                = string
      interval            = number
      timeout             = number
      unhealthy_threshold = number

    }))

    backend_address_pool = list(object({
      name = string
    }))
    backend_http_settings = list(object({
      name                  = string
      cookie_based_affinity = string
      path                  = string
      port                  = number
      protocol              = string
      request_timeout       = number
    }))
    http_listener = list(object({
      name                           = string
      frontend_port_name             = string
      protocol                       = string
      ssl_certificate_name           = string
      frontend_ip_configuration_name = string
      # for basic listener you can define host_name as "null"
      host_name   = string
      require_sni = bool
    }))

    request_routing_rule = list(object({

      name                       = string
      ruletype                   = string
      http_listener_name         = string
      backend_address_pool_name  = string
      backend_http_settings_name = string
      url_path_map_name          = string
    }))

    url_path_map = list(object({

      name                               = string
      default_backend_http_settings_name = string
      default_backend_address_pool_name  = string
    }))
    path_rule = list(object({
      name                       = string
      paths                      = string # use format "path1:path2:path3"
      backend_http_settings_name = string
      backend_address_pool_name  = string

    }))
  }))
  description = "Map containing load balancers"
  default     = {}
}

