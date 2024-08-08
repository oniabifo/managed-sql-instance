variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "clickclaims-rgp-prod-01"
}

variable "location" {
  description = "The Azure location where resources will be created."
  type        = string
  default     = "Canada Central"
}

variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
  default     = "sql-vnet-prod-uscentral-001"
}

variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
  default     = "sql-subnet-prod-uscentral-001"
}

variable "admin_login" {
  description = "The administrator login for the SQL Managed Instance."
  type        = string
  default     = "sqladmin"
}

variable "admin_password" {
  description = "The administrator password for the SQL Managed Instance."
  type        = string
  sensitive   = true
}

variable "sql_instance_name" {
  description = "The name of the SQL Managed Instance."
  type        = string
  default     = "sql-instance"
}

variable "sku_name" {
  description = "The SKU name of the SQL Managed Instance."
  type        = string
  default     = "GP_Gen8IM"
}

variable "vcores" {
  description = "The number of vCores for the SQL Managed Instance."
  type        = number
  default     = 8
}

variable "storage_size_in_gb" {
  description = "The storage size in GB for the SQL Managed Instance."
  type        = number
  default     = 448
}
