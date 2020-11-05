provider "azurerm" {
  version         = "~> 2.10.0"
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  partner_id      = "a79fe048-6869-45ac-8683-7fd2446fc73c"
  features {}
}

provider random {
  version = "~> 2.2"
}

# Azure AD Provider
provider "azuread" {
  version         = "0.8.0"
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

# # Set the terraform backend
terraform {
  required_version = "~> 0.12.20"
  backend "azurerm" {} #Backend variables are initialized through the secret and variable folders
}
