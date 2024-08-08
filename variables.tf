variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "clickclaims-rgp-test-01"
}

variable "location" {
  description = "The Azure location where resources will be created."
  type        = string
  default     = "West Europe"
}

variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
  default     = "sql-vnet"
}

variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
  default     = "sql-subnet"
}

variable "admin_login" {
  description = "The administrator login for the SQL Managed Instance."
  type        = string
  default     = "claimsadmin"
}

variable "admin_password" {
  description = "The administrator password for the SQL Managed Instance."
  type        = string
  sensitive   = true
}

variable "sql_instance_name" {
  description = "The name of the SQL Managed Instance."
  type        = string
  default     = "win-a-sql-a"
}

variable "sku_name" {
  description = "The SKU name of the SQL Managed Instance."
  type        = string
  default     = "GP_Gen5_8"
}

variable "vcores" {
  description = "The number of vCores for the SQL Managed Instance."
  type        = number
  default     = 8
}

variable "storage_size_in_gb" {
  description = "The storage size in GB for the SQL Managed Instance."
  type        = number
  default     = 480
}