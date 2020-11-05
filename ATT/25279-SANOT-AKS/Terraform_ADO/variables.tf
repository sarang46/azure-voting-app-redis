variable "tenant_id" {
  description = "Azure tenant Id."
  default = "e741d71c-c6b6-47b0-803c-0f3b32b07556"
}
variable "subscription_id" {
  description = "Azure subscription Id."
  default = "474edc39-4b93-4b70-8436-6c5b890eebae"
}
variable "client_id" {
  description = "Azure service principal application Id"
  default = "3a3fbc6e-88a9-408a-b10d-8d07325af837"
}
variable "client_secret" {
  description = "Azure service principal application Secret"
  default = "87CDU81xl35Eu-S60sKKg_mT~6E.H2q6G5"
}

variable "location" {
  type        = string
  description = "The Azure region where your resources will be created"
}

variable "aks_resource_id" {
  type = any
}


variable "ado_k8s_private_endpoint_name" {
  type = string
}

variable "ado_subnet_name" {
  type = string
}

variable "ado_k8s_private_connection_name" {
  type = string
}

variable "ado_private_dns_vnet_link_name" {
  type = string
}

variable "ado_resource_group_name" {
  type = string
}

variable "ado_vnet_name" {
  type = string
}

variable "ado_aks_zone" {
  type = string
}

variable "ado_aks_arecord" {
  type = string
}


# ACR variables 

variable "acr_name" {
  type = string
  description ="name of azure container regsitry"
}

variable "acr_pe_name" {
  type = string
  description = "private endpoint name of azure container registry"
}
variable "pe_acr_record_name" {
  type = string
  description = "a record name of private end point connection"
}

variable "pe_acr_vnetlink_name" {
  type = string
  description = "zone to vnet link name of acr private end point"
}

variable "acr_private_connection_name" {
  type = string 
  description = "private connection name of acr private endpoint "  
}