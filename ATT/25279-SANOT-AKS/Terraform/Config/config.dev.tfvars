
# - General Terraform vars

location            = "eastus2"
resource_group_name = "sanot-eastus2-preprod-rg-001"

administrator_user_name      = "sanotadmin"
administrator_login_password = "sanotadmin@2020"												



additional_tags = {}
sanot_app_image_id = "/subscriptions/96c55142-3197-4960-9a42-a76d02205e2e/resourceGroups/att-golden-images/providers/Microsoft.Compute/galleries/ATT_Shared_Images/images/RHEL-7/versions/1.4089.20200714"
							   

# - Virtual Network

virtual_networks = {
  virtualnetwork1 = {
    name                 = "eastus2-25279-preprod-vnet"
    address_space        = ["10.22.16.0/21"]
    dns_servers          = null
    ddos_protection_plan = null
  }
}

# Subnets
subnets = {
  subnet1 = {
    vnet_key          = "virtualnetwork1"
    nsg_key           = "nsg1" #NSG key to associate with vnet
    rt_key            = null
    name              = "eastus2-25279-preprod-vnet-jump-snet-001"
    address_prefixes  = ["10.22.16.0/25"]
    service_endpoints = [""]
    pe_enable         = true
    delegation        = []
  },
  subnet2 = {
    vnet_key          = "virtualnetwork1"
    nsg_key           = "nsg2"
    rt_key            = null
    name              = "eastus2-25279-preprod-vnet-web-snet-001"
    address_prefixes  = ["10.22.17.0/25"]
    pe_enable         = true
    service_endpoints = null
    delegation        = []
  },
  subnet3 = {
    vnet_key          = "virtualnetwork1"
    nsg_key           = null
    rt_key            = null
    name              = "eastus2-25279-preprod-vnet-pod-snet-001"
    address_prefixes  = ["10.22.18.0/25"]	
    pe_enable         = true
    service_endpoints = null
    delegation        = []
  },
  subnet4 = {
    vnet_key          = "virtualnetwork1"
    nsg_key           = null
    rt_key            = null
    name              = "eastus2-25279-preprod-vnet-pls-snet-001"
    address_prefixes    = ["10.22.19.0/25"]	
    pe_enable         = true
    service_endpoints = null
    delegation        = []
  },
  subnet5 = {
    vnet_key          = "virtualnetwork1"
    nsg_key           = null
    rt_key            = null
    name              = "eastus2-25279-preprod-vnet-pe-snet-001"
    address_prefixes    = ["10.22.20.0/25"]	
    pe_enable         = true
    service_endpoints = null
    delegation        = []
  }
}

route_tables = {}

# - Base Infrastructure Network Security Groups


network_security_groups = {
  nsg1 = {
    name = "eastus2-25279-preprod-nsg-jump-snet-001"
    security_rules = [
      {
        name                         = "Jump_Azure_Monitor"
        description                  = "Egress all traffic to Azure Monitor"
        priority                     = 200
        direction                    = "Outbound"
        access                       = "Allow"
        protocol                     = "*"
        source_port_range            = "*"
        source_port_ranges           = null
        destination_port_range       = ""
        destination_port_ranges      = [ "43","80" ]
        source_address_prefix        = "VirtualNetwork"
        source_address_prefixes      = null
        destination_address_prefix   = "AzureMonitor"
        destination_address_prefixes = null
        source_application_security_group_names      = []
        destination_application_security_group_names = []
      },
      {
        name                         = "Jump_Azure_Monitor_Log_Analytics"
        description                  = "Egress all traffic to Guest and Hybird Management"
        priority                     = 300
        direction                    = "Outbound"
        access                       = "Allow"
        protocol                     = "*"
        source_port_range            = "*"
        source_port_ranges           = null
        destination_port_range       = "443"
        destination_port_ranges      = null
        source_address_prefix        = "VirtualNetwork"
        source_address_prefixes      = null
        destination_address_prefix   = "GuestAndHybridManagement"
        destination_address_prefixes = null
        source_application_security_group_names      = []
        destination_application_security_group_names = []
      },
      {
        name                         = "Jump_Azure_Active_Directory"
        description                  = "Egress all traffic to Azure Active Directory"
        priority                     = 400
        direction                    = "Outbound"
        access                       = "Allow"
        protocol                     = "*"
        source_port_range            = "*"
        source_port_ranges           = null
        destination_port_range       = "*"
        destination_port_ranges      = null
        source_address_prefix        = "VirtualNetwork"
        source_address_prefixes      = null
        destination_address_prefix   = "AzureActiveDirectory"
        destination_address_prefixes = null
        source_application_security_group_names      = []
        destination_application_security_group_names = []
      },
      {
        name                         = "Jump_HTTPS_OB"
        description                  = "Egress from Jumpbox subnet to the Azure Key Vault Private Endpoint, Storage Private Endpoint(s), SQUID Proxy Private Endpoint"
        priority                     = 500
        direction                    = "Outbound"
        access                       = "Allow"
        protocol                     = "*"
        source_port_range            = "*"
        source_port_ranges           = null
        destination_port_range       = "443"
        destination_port_ranges      = null
        source_address_prefix        = "*"
        source_address_prefixes      = null
        destination_address_prefix   = "*"
        destination_address_prefixes = null
        source_application_security_group_names      = []
        destination_application_security_group_names = []
      },
      {
        name                         = "Jump_SSH_OB"
        description                  = "Egress SSH from Jumpbox subnet"
        priority                     = 600
        direction                    = "Outbound"
        access                       = "Allow"
        protocol                     = "*"
        source_port_range            = "*"
        source_port_ranges           = null
        destination_port_range       = "22"
        destination_port_ranges      = null
        source_address_prefix        = "*"
        source_address_prefixes      = null
        destination_address_prefix   = "*"
        destination_address_prefixes = null
        source_application_security_group_names      = []
        destination_application_security_group_names = []
      },
      {
        name                         = "Jump_OB"
        description                  = "Egress Traffic"
        priority                     = 700
        direction                    = "Outbound"
        access                       = "Allow"
        protocol                     = "*"
        source_port_range            = "*"
        source_port_ranges           = null
        destination_port_range       = "*"
        destination_port_ranges      = null
        source_address_prefix        = "*"
        source_address_prefixes      = null
        destination_address_prefix   = "*"
        destination_address_prefixes = null
        source_application_security_group_names      = []
        destination_application_security_group_names = []        
      },
      {
        name                         = "PLS_Subnet_to_SSH2"
        description                  = "Ingress ssh from PLS Subnet to Jumpbox Subnet"
        priority                     = 1000
        direction                    = "Inbound"
        access                       = "Allow"
        protocol                     = "Tcp"
        source_port_range            = "*"
        source_port_ranges           = null
        destination_port_range       = "22"
        destination_port_ranges      = []
        source_address_prefix        = "*"
        source_address_prefixes      = null
        destination_address_prefix   = "*"
        destination_address_prefixes = null
        source_application_security_group_names      = []
        destination_application_security_group_names = []        
      },
      {
        name                         = "Block_Internet"
        description                  = "Block all Internet Traffic"
        priority                     = 3000
        direction                    = "Outbound"
        access                       = "Deny"
        protocol                     = "*"
        source_port_range            = "*"
        source_port_ranges           = null
        destination_port_range       = "*"
        destination_port_ranges      = []
        source_address_prefix        = "*"
        source_address_prefixes      = null
        destination_address_prefix   = "Internet"
        destination_address_prefixes = null
        source_application_security_group_names      = []
        destination_application_security_group_names = []        
      },
      {
        name                         = "Allow_LB"
        description                  = "Allow inbound from Azure Load Balancer"
        priority                     = 3100
        direction                    = "Inbound"
        access                       = "Allow"
        protocol                     = "*"
        source_port_range            = "*"
        source_port_ranges           = null
        destination_port_range       = "*"
        destination_port_ranges      = []
        source_address_prefix        = "VirtualNetwork"
        source_address_prefixes      = null
        destination_address_prefix   = "*"
        destination_address_prefixes = null
        source_application_security_group_names      = []
        destination_application_security_group_names = []        
      },
      {
        name                         = "Block_All_Traffic"
        description                  = "Block all remaining inbound traffic that does not match any previous rule"
        priority                     = 3200
        direction                    = "Inbound"
        access                       = "Deny"
        protocol                     = "*"
        source_port_range            = "*"
        source_port_ranges           = null
        destination_port_range       = "*"
        destination_port_ranges      = []
        source_address_prefix        = "VirtualNetwork"
        source_address_prefixes      = null
        destination_address_prefix   = "*"
        destination_address_prefixes = null
        source_application_security_group_names      = []
        destination_application_security_group_names = []        
      },
      {
        name                         = "Block-outbound-traffic"
        description                  = "Block all remaining outbound traffic"
        priority                     = 3300
        direction                    = "Outbound"
        access                       = "Deny"
        protocol                     = "*"
        source_port_range            = "*"
        source_port_ranges           = null
        destination_port_range       = "*"
        destination_port_ranges      = null
        source_address_prefix        = "*"
        source_address_prefixes      = null
        destination_address_prefix   = "VirtualNetwork"
        destination_address_prefixes = null
        source_application_security_group_names      = []
        destination_application_security_group_names = []        
      }
    ]
  },
  nsg2 = {
    name = "eastus2-25279-preprod-nsg-aks-snet-001"
    security_rules = [
      {
        name                         = "Azure_Monitor_aks"
        description                  = "Egress all traffic to Azure Monitor"
        priority                     = 200
        direction                    = "Outbound"
        access                       = "Allow"
        protocol                     = "*"
        source_port_range            = "*"
        source_port_ranges           = null
        destination_port_range       = ""
        destination_port_ranges      = [ "43","80" ]
        source_address_prefix        = "VirtualNetwork"
        source_address_prefixes      = null
        destination_address_prefix   = "AzureMonitor"
        destination_address_prefixes = null
        source_application_security_group_names      = []
        destination_application_security_group_names = []        
      },
      {
        name                         = "Azure_Monitor_Log_Analytics_aks"
        description                  = "Egress all traffic to Guest and Hybird Management"
        priority                     = 300
        direction                    = "Outbound"
        access                       = "Allow"
        protocol                     = "*"
        source_port_range            = "*"
        source_port_ranges           = null
        destination_port_range       = "443"
        destination_port_ranges      = null
        source_address_prefix        = "VirtualNetwork"
        source_address_prefixes      = null
        destination_address_prefix   = "GuestAndHybridManagement"
        destination_address_prefixes = null
        source_application_security_group_names      = []
        destination_application_security_group_names = []        
      },
      {
        name                         = "Azure_Active_Directory_aks"
        description                  = "Egress all traffic to Azure Active Directory"
        priority                     = 400
        direction                    = "Outbound"
        access                       = "Allow"
        protocol                     = "*"
        source_port_range            = "*"
        source_port_ranges           = null
        destination_port_range       = "*"
        destination_port_ranges      = null
        source_address_prefix        = "VirtualNetwork"
        source_address_prefixes      = null
        destination_address_prefix   = "AzureActiveDirectory"
        destination_address_prefixes = null
        source_application_security_group_names      = []
        destination_application_security_group_names = []        
      },
      {
        name                         = "aks_to_Azure_PE"
        description                  = "Egress from aks subnet to the Azure Key Vault Private Endpoint, Storage Private Endpoint(s), SQUID Proxy Private Endpoint"
        priority                     = 500
        direction                    = "Outbound"
        access                       = "Allow"
        protocol                     = "*"
        source_port_range            = "*"
        source_port_ranges           = null
        destination_port_range       = "443"
        destination_port_ranges      = null
        source_address_prefix        = "*"
        source_address_prefixes      = null
        destination_address_prefix   = "*"
        destination_address_prefixes = null
        source_application_security_group_names      = []
        destination_application_security_group_names = []        
      },
      {
        name                         = "Https_aks_client"
        description                  = "Ingress https traffic from Conexus to aks subnet (users accessing application front end) "
        priority                     = 1000
        direction                    = "Inbound"
        access                       = "Allow"
        protocol                     = "Tcp"
        source_port_range            = "*"
        source_port_ranges           = null
        destination_port_range       = "443"
        destination_port_ranges      = []
        source_address_prefix        = "*"
        source_address_prefixes      = null
        destination_address_prefix   = "*"
        destination_address_prefixes = null
        source_application_security_group_names      = []
        destination_application_security_group_names = []        
      },
      {
        name                         = "SSH2_aks"
        description                  = "Ingress ssh from PLS Subnet to Jumpbox Subnet"
        priority                     = 1100
        direction                    = "Inbound"
        access                       = "Allow"
        protocol                     = "Tcp"
        source_port_range            = "*"
        source_port_ranges           = null
        destination_port_range       = "22"
        destination_port_ranges      = []
        source_address_prefix        = "*"
        source_address_prefixes      = null
        destination_address_prefix   = "*"
        destination_address_prefixes = null
        source_application_security_group_names      = []
        destination_application_security_group_names = []        
      },
      {
        name                         = "Block_Internet_aks"
        description                  = "Block all Internet Traffic"
        priority                     = 3000
        direction                    = "Outbound"
        access                       = "Deny"
        protocol                     = "*"
        source_port_range            = "*"
        source_port_ranges           = null
        destination_port_range       = "*"
        destination_port_ranges      = []
        source_address_prefix        = "*"
        source_address_prefixes      = null
        destination_address_prefix   = "Internet"
        destination_address_prefixes = null
        source_application_security_group_names      = []
        destination_application_security_group_names = []        
      },
      {
        name                         = "Allow_LB_aks"
        description                  = "Allow inbound from Azure Load Balancer"
        priority                     = 3100
        direction                    = "Inbound"
        access                       = "Allow"
        protocol                     = "*"
        source_port_range            = "*"
        source_port_ranges           = null
        destination_port_range       = "*"
        destination_port_ranges      = []
        source_address_prefix        = "VirtualNetwork"
        source_address_prefixes      = null
        destination_address_prefix   = "*"
        destination_address_prefixes = null
        source_application_security_group_names      = []
        destination_application_security_group_names = []        
      },
	  {
        name                         = "aks_to_DB_subnet"
        description                  = "Egress Oracle DB connection from aks subnet to DB subnet"
        priority                     = 3200
        direction                    = "Outbound"
        access                       = "Allow"
        protocol                     = "*"
        source_port_range            = "*"
        source_port_ranges           = null
        destination_port_range       = "1524"
        destination_port_ranges      = null
        source_address_prefix        = "*"
        source_address_prefixes      = null
        destination_address_prefix   = "*"
        destination_address_prefixes = null
        source_application_security_group_names      = []
        destination_application_security_group_names = []        
      },	
      {
        name                         = "Block_All_Traffic_aks"
        description                  = "Block all remaining inbound traffic that does not match any previous rule"
        priority                     = 3300
        direction                    = "Inbound"
        access                       = "Deny"
        protocol                     = "*"
        source_port_range            = "*"
        source_port_ranges           = null
        destination_port_range       = "*"
        destination_port_ranges      = []
        source_address_prefix        = "VirtualNetwork"
        source_address_prefixes      = null
        destination_address_prefix   = "*"
        destination_address_prefixes = null
        source_application_security_group_names      = []
        destination_application_security_group_names = []        
      },
      {
        name                         = "Block-outbound-traffic_aks"
        description                  = "Block all remaining outbound traffic"
        priority                     = 3400
        direction                    = "Outbound"
        access                       = "Deny"
        protocol                     = "*"
        source_port_range            = "*"
        source_port_ranges           = null
        destination_port_range       = "*"
        destination_port_ranges      = null
        source_address_prefix        = "*"
        source_address_prefixes      = null
        destination_address_prefix   = "VirtualNetwork"
        destination_address_prefixes = null
        source_application_security_group_names      = []
        destination_application_security_group_names = []
      }
    ]
  }
}

# - Base Infrastructure Log Analytics Workspace 

base_infra_log_analytics_name = "sanot-eastus2-preprod-law2"
sku                           = "PerGB2018"
retention_in_days             = 30
log_analytics_workspace       = null

# - Base Infrastructure Storage Account

base_infra_storage_accounts = {
  sa1 = {
    name                       = "sanotpreprodlog01"
    sku                        = "Standard_RAGRS"
    account_kind               = null
    access_tier                = null
    assign_identity            = true
    cmk_enable                 = true
    network_rules              = null
    enable_large_file_share    = false
  },
  sa2 = {
    name                       = "sanotpreprodtbkup01"
    sku                        = "Standard_RAGRS"
    account_kind               = null
    access_tier                = null
    assign_identity            = true
    cmk_enable                 = true
    network_rules              = null
    enable_large_file_share    = false
  }
}

# - Key Vault

base_infra_keyvault_name = "sanot-preprod-eus2-KV-01"

network_acls = {
  bypass                     = "AzureServices"
  default_action             = "Deny"
  ip_rules                   = ["0.0.0.0/0"]
  virtual_network_subnet_ids = []
}

# - Private LoadBalancer

zones = ["1"]

Lbs = {
  loadbalancer1 = {
    name = "sanot-jump-preprod-lb-001"
    frontend_ips = [
      {
        name        = "sanot-jump-preprod-frontendlb"
        subnet_name = "eastus2-25279-preprod-vnet-jump-snet-001" # Name of the Subnet
        static_ip   = "10.22.16.21"           # "10.0.1.4" #(Optional) Set null to get dynamic IP or delete this line
      }
    ]
    backend_pool_names = ["sanot-preprod-jump-lbp-001"]
    enable_public_ip      = false
    public_ip_name     = null
  },
  loadbalancer2 = {
    name = "sanot-aks-preprod-lb-001"
    frontend_ips = [
      {
        name        = "sanot-aks-preprod-frontendlb"
        subnet_name = "eastus2-25279-preprod-vnet-aks-snet-001"
        static_ip   = "10.22.16.150"
      }
    ]
    backend_pool_names = ["sanot-preprod-aks-lbp-001"]
    enable_public_ip   = false
    public_ip_name     = null
  }
}

LbRules = {
  loadbalancerrules1 = {
    name                      = "sanot-preprod-jump-lbr-001"
    lb_key                    = "loadbalancer1"        #Key of the Load Balancer
    frontend_ip_name          = "sanot-jump-preprod-frontendlb" #It must equals the Lbs front end
    backend_pool_name         = "sanot-preprod-jump-lbp-001"
    lb_protocol               = null
    lb_port                   = "22"
    probe_port                = "22"
    backend_port              = "22"
    enable_floating_ip        = null
    disable_outbound_snat     = null
    enable_tcp_reset          = null
    probe_protocol            = "Tcp"
    request_path              = "/"
    probe_interval            = 15
    probe_unhealthy_threshold = 2
    load_distribution         = "SourceIPProtocol"
    idle_timeout_in_minutes   = 5
  },
  loadbalancerrules2 = {
    name                      = "sanot-preprod-aks-lbr-001"
    lb_key                    = "loadbalancer2"         #Key of the Load Balancer
    frontend_ip_name          = "sanot-aks-preprod-frontendlb" #It must equals the Lbs front end
    backend_pool_name         = "sanot-preprod-aks-lbp-001"
    lb_protocol               = null
    lb_port                   = "443"
    probe_port                = "8080"
    backend_port              = "8080"
    enable_floating_ip        = null
    disable_outbound_snat     = null
    enable_tcp_reset          = null
    probe_protocol            = "Tcp"
    request_path              = "/"
    probe_interval            = 15
    probe_unhealthy_threshold = 2
    load_distribution         = "SourceIPProtocol"
    idle_timeout_in_minutes   = 5
  }
}

LbNatRules = {}


# - Linux VMs
linux_vms = {
  vm1 = {
    name                             = "sanot-eastus2-preprod-jump-vm-001"     #(Mandatory) name of the vm
    vm_size                          = "Standard_Ds2_v2"  #(Mandatory) 
    #source_image_reference_offer     = "sanot_rhel_7"       #(Mandatory) 
    #source_image_reference_publisher = "ATT"              #(Mandatory) 
    #source_image_reference_sku       = "1.0"              #(Mandatory) 
    #source_image_reference_version   = "1.0.11"           #(Mandatory)
    source_image_reference_offer     = null    #(Mandatory) 
    source_image_reference_publisher = null       #(Mandatory) 
    source_image_reference_sku       = null       #(Mandatory) 
    source_image_reference_version   = null   
    subnet_name                      = "eastus2-25279-preprod-vnet-jump-snet-001"    #(Mandatory) Id of the Subnet   
    managed_disk_type                = "Premium_LRS"     #(Mandatory) 
    storage_os_disk_caching          = "ReadWrite"
    zone                             = "1"
    lb_backend_pool_names            = ["sanot-preprod-jump-lbp-001"]
    app_security_group_names         = []
    assign_identity                  = true
    disable_password_authentication  = true
    disk_size_gb                     = null
    write_accelerator_enabled        = null
    disk_encryption_set_id           = null
    internal_dns_name_label          = null
    enable_ip_forwarding             = null
    enable_accelerated_networking    = null
    dns_servers                      = null
    static_ip                        = "10.22.16.20"
    enable_cmk_disk_encryption       = true
    recovery_services_vault_key      = null
    custom_data_path                 = "//Terraform//Scripts//CustomData.sh" #Optional
    custom_data_args                 = {name = "VMandVMSS", destination = "eastus2", version = "1.0"}
    diagnostics_storage_config_path  = null #Optional
    custom_script                    = null #Optional
  }
}

# managed data disks

  managed_data_disks = {
    disk1 = {
      disk_name = "sanot-preprod-jump-vm-001-datadisk01"
      vm_name   = "sanot-eastus2-preprod-jump-vm-001"
      lun       = 1
      storage_account_type = "Premium_LRS"
      disk_size     = "256"
      caching       = "None" 
      write_accelerator_enabled = false 
    }

}

windows_vms = {}



#- Private Link Services
private_link_services = {
  pls1 = {
    name                            = "25279-preprod-sanot-jump-eastus2-001-pls"
    frontend_ip_config_name         = "sanot-jump-preprod-frontendlb"
    subnet_name                     = "eastus2-25279-preprod-vnet-pls-snet-001"
    private_ip_address              = null
    private_ip_address_version      = null
    visibility_subscription_ids     = null
    auto_approval_subscription_ids  = null
  },
  pls2 = {
    name                            = "25279-preprod-sanot-aks-eastus2-001-pls"
    frontend_ip_config_name         = "sanot-aks-preprod-frontendlb"
    subnet_name                     = "eastus2-25279-preprod-vnet-pls-snet-001"
    private_ip_address              = null
    private_ip_address_version      = null
    visibility_subscription_ids     = null
    auto_approval_subscription_ids  = null
  }
}


# - Private Endpoint
private_endpoints = {
  pe1 = {
    resource_name            = "nva"
    name                     = "25279-preprod-sanot-nva-eastus2-001-pe"
    subnet_name              = "eastus2-25279-preprod-vnet-pe-snet-001"
    vnet_name                = "eastus2-25279-preprod-vnet"
    approval_required        = true
    approval_message         = "Please approve nva proxy for sanot portal"
    group_ids                = []
    dns_zone_name            = "svc.local"
    zone_exists              = false
    zone_to_vnet_link_exists = false
    registration_enabled     = false
    dns_a_records = [{
      name                  = "proxy.nva.conexus"
      ttl                   = 300
      ip_addresses          = null 
      private_endpoint_name = null
    }]
  },
  pe2 = {
    resource_name            = "keyvault"
    name                     = "25279-preprod-sanot-kv-eastus2-03-pe"
    subnet_name              = "eastus2-25279-preprod-vnet-pe-snet-001"
    vnet_name                = "eastus2-25279-preprod-vnet"
    approval_required        = false
    approval_message         = "Auto Approved"
    group_ids                = ["vault"]
    dns_zone_name            = "privatelink.vaultcore.azure.net"
    zone_exists              = false
    zone_to_vnet_link_exists = false
    registration_enabled     = false
    dns_a_records = [{
      name                  = "sanotvaultpreprod" 
      ttl                   = 300
      ip_addresses          = null 
      private_endpoint_name = null
    }]
  },
  pe3 = {
    resource_name            = "sa"
    name                     = "25279-preprod-sanot-bootdaig-pe"
    subnet_name              = "eastus2-25279-preprod-vnet-pe-snet-001"
    vnet_name                = "eastus2-25279-preprod-vnet"
    approval_required        = false
    approval_message         = null
    group_ids                = ["blob"]
    dns_zone_name            = "privatelink.blob.core.windows.net"
    zone_exists              = false
    zone_to_vnet_link_exists = false
    registration_enabled     = false
    dns_a_records = [{
      name                  = "sanotbootdiagpreprod" 
      ttl                   = 300
      ip_addresses          = null 
      private_endpoint_name = null
    }]
  },
  pe4 = {
    resource_name            = "sa"
    name                     = "25279-preprod-sanot-diag-pe"
    subnet_name              = "eastus2-25279-preprod-vnet-pe-snet-001"
    vnet_name                = "eastus2-25279-preprod-vnet"
    approval_required        = false
    approval_message         = "Auto Approved"
    group_ids                = ["table"]
    dns_zone_name            = "privatelink.table.core.windows.net"
    zone_exists              = false
    zone_to_vnet_link_exists = false
    registration_enabled     = false
    dns_a_records = [{
      name                  = "sanottablepreprod"
      ttl                   = 300
      ip_addresses          = null 
      private_endpoint_name = null
    }]
  },
  pe5 = {
    resource_name            = "sadbbkp"
    name                     = "25279-preprod-sanot-dbbackup-pe"
    subnet_name              = "eastus2-25279-preprod-vnet-pe-snet-001"
    vnet_name                = "eastus2-25279-preprod-vnet"
    approval_required        = false
    approval_message         = null
    group_ids                = ["blob"]
    dns_zone_name            = "privatelink.blob.core.windows.net"
    zone_exists              = false
    zone_to_vnet_link_exists = false
    registration_enabled     = false
    dns_a_records = [{
      name                  = "sanotdbbkppreprod"
	  ttl                   = 300
      ip_addresses          = null 
      private_endpoint_name = null
    }]
  },
   pe6 = {
    resource_name            = "squid"
    name                     = "25279-preprod-sanot-squid-pe"
    subnet_name              = "eastus2-25279-preprod-vnet-pe-snet-001"
    vnet_name                = "eastus2-25279-preprod-vnet"
    approval_required        = true
    approval_message         = "Please approve squid proxy for comet portal"
    group_ids                = []
    dns_zone_name            = "svc.local"
    zone_exists              = false
    zone_to_vnet_link_exists = false
    registration_enabled     = false
    dns_a_records = [{
      name                  = "proxy.conexus"			   
	  ttl                   = 300
      ip_addresses          = null 
      private_endpoint_name = null
    }]
  },
    pe7 = {
    resource_name            = "smtp"
    name                     = "25279-preprd-sanot-smtp-eastus2-pe"
    subnet_name              = "eastus2-25279-preprod-vnet-pe-snet-01"
    vnet_name                = "eastus2-25279-preprd-vnet"
    approval_required        = true
    approval_message         = "Please approve smtp proxy for sanot portal"
    group_ids                = []
    dns_zone_name            = "az.3pc.att.com"
    zone_exists              = false
    zone_to_vnet_link_exists = false
    registration_enabled     = false
    dns_a_records = [{
      name                  = "smtp"
      ttl                   = 300
      ip_addresses          = null 
      private_endpoint_name = null
    }]
}

## DNS Zones ##

private_dns_zones = { 
  zone1 = {
    dns_zone_name            = "vci.att.com" # <"dns_zone_name">
    vnet_name                = "eastus2-25279-preprod-vnet"          # <"virtual_network_linked_to_dns_zone">
    zone_exists              = false                              # <true | false>
    zone_to_vnet_link_exists = false                              # <true | false>
    registration_enabled     = true
  }
}

dns_a_records = {
 /* arecord1 = {
    a_record_name         = "sanot-eastus2-preprod-jump-vm-001" # <"dns+a_record_name">
    dns_zone_name         = "vci.att.com" # <"dns_zone_name">
    ttl                   = 300                                # <time_to_live_of_the_dns_record_in_seconds>
    ip_addresses          = ["10.200.20.20"]                    # <list_of_ipv4_addresses>
    private_endpoint_name = null                               # <"name of private endpoint for which DNSARecord to be created"
  },
  arecord2 = {
    a_record_name         = "sanot-eastus2-preprod-aks-vm-001" # <"dns+a_record_name">
    dns_zone_name         = "vci.att.com" # <"dns_zone_name">
    ttl                   = 300                                # <time_to_live_of_the_dns_record_in_seconds>
    ip_addresses          = ["10.200.21.20"]                    # <list_of_ipv4_addresses>
    private_endpoint_name = null                               # <"name of private endpoint for which DNSARecord to be created"
  }*/
}

#- Recovery Services Vaults
/*recovery_services_vaults = {
  rsv1 = {
    name                = "sanot-westus-vault-02"
    policy_name         = "sanot-westus-vault-001-policy"
    sku                 = "Standard"
    soft_delete_enabled = false
    backup_settings = {
      frequency = "Daily"
      time      = "23:00"
      weekdays  = null
    }
    retention_settings = {
      daily   = 10
      weekly  = null #"42:Sunday,Wednesday"
      monthly = null #"7:Sunday,Wednesday:First,Last"
      yearly  = null #"77:Sunday:Last:January"
    }
  }
}*/

# - AKS
k8s_cluster = {
  name                  = "sanot-eastus2-preprod-aks-001"
  dns_prefix            = "sanot-eastus2-preprod-aks-001"
  kubernetes_version    = "1.17.7"
 service_address_range = "10.22.16.0/25  #old: "10.0.16.0/24"
  dns_ip                = "10.22.16.7"
  node_subnet_name      = "eastus2-25279-preprod-vnet-aks-snet-001"
}

k8s_default_pool = {
  name                = "aksdefpool01"
  count               = 1
  vm_size             = "Standard_B4ms"
  os_type             = "Linux"
  os_disk_size_gb     = 30
  max_pods            = 30
  availability_zones  = [1, 2, 3]
  enable_auto_scaling = true
  min_count           = 1
  max_count           = 10
}

k8s_extra_node_pools = {
  nodepool1 = {
    name                = "akspool01"
    count               = 1
    vm_size             = "Standard_B4ms"
    os_type             = "Linux"
    os_disk_size_gb     = 30
    max_pods            = 30
    availability_zones  = [1, 2, 3]
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 10
  }
}

#mysql
server_name                         = "sanot-eastus2-preprod-mysql-02"
database_names                      = ["sanot-preprod-mysql"]
mysql_administrator_login_name      = "sanot_admin"
mysql_administrator_login_password  = "3rLmJpk8vSAgG!"
allowed_subnet_names                = ["eastus2-25279-preprod-vnet-pe-snet-001"]
mysql_sku_name                            = "GP_Gen5_2"
mysql_version                       = 5.7
storage_mb                          = 5120
backup_retention_days               = 7
geo_redundant_backup                = "Disabled"
auto_grow                           = "Disabled"
private_endpoint_connection_enabled = true

firewall_rules = {
  "default" = {
    name             = "mysql-firewall-rule-default"
    start_ip_address = "0.0.0.0"
    end_ip_address   = "0.0.0.0"
  }
}

mysql_configurations = {
  interactive_timeout = "600"
}

## app gateway

ruletype = "Basic"
resourcetags = {
  iac = "Terraform"
Application_Name = "sanot"
Automated_By = "ACC-preprod-25279-sanot"
Contact_DL = "pa979h@att.com"
Mots_ID = "25279"
Auto_Fix = "No"
}


app_gw = {
  appgw1 = {
    name = "sanot-eastus2-preprod-web-appgw-001"
    gateway_ips = [
      {
        subnet_name = "eastus2-25279-preprod-vnet-pls-snet-001"
        name        = "sanot-eastus2-preprod-web-pls-gwip"
      }
    ]

    frontend_ip = [
      {
        name = "sanot-eastus2-preprod-web-appgw-feip"
      }
    ]

    frontend_port = [
      {
        name = "http"
        port = "80"
      }
    ]
    probe = [
      {
        name                = "sanot-eastus2-preprod-web-httpprobe"
        path                = "/"
        host                = "attnew.com"
        protocol            = "Http"
        host                = "10.30.26.8"
        interval            = 30
        timeout             = 5
        unhealthy_threshold = 2
      }
    ]
    backend_address_pool = [
      {
        name = "sanot-eastus2-preprod-web-bepool1"
      }
    ]
    backend_http_settings = [
      {
        name                  = "sanot-eastus2-preprod-web-httpsetting"
        cookie_based_affinity = "Enabled"
        path                  = "/"
        port                  = 80
        protocol              = "Http"
        request_timeout       = 1
      }
    ]
    http_listener = [
      {
        name                           = "sanot-eastus2-preprod-web-http_listener"
        require_sni                    = false
        frontend_port_name             = "http"
        host_name                      = "null" #define hostname only for multi-site listener for basic listener define it with  null
        ssl_certificate_name           = null
        protocol                       = "Http"
        frontend_ip_configuration_name = "sanot-eastus2-preprod-web-appgw-feip"
      },
    ]
    request_routing_rule = [
      {
        name                       = "sanot-eastus2-preprod-web-path"
        ruletype                   = "Basic"
        backend_address_pool_name  = "sanot-eastus2-preprod-web-bepool1"
        http_listener_name         = "sanot-eastus2-preprod-web-http_listener"
        backend_http_settings_name = "sanot-eastus2-preprod-web-httpsetting"
        url_path_map_name          = "urlpath1"
      }
    ]
    url_path_map = [
      {
        name                               = "urlpath1"
        default_backend_http_settings_name = "sanot-eastus2-preprod-web-httpsetting"
        default_backend_address_pool_name  = "sanot-eastus2-preprod-web-bepool1"
      }
    ]
    path_rule = [
      {
        name                       = "sanot-eastus2-preprod-web-path"
        paths                      = "/new:" # use format "path1:path2:path3"
        backend_http_settings_name = "sanot-eastus2-preprod-web-httpsetting"
        backend_address_pool_name  = "sanot-eastus2-preprod-web-bepool1"
      }
    ]
    // ssl_certificate = [
    //   {
    //     name                       = null
    //     password = null
    //   }
    //]

  }
}

