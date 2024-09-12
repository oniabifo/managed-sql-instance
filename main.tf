resource "azurerm_resource_group" "az-rg-details" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_network_security_group" "sql-nsg" {
  name                = "sql-nsg-dev"
  location            = azurerm_resource_group.az-rg-details.location
  resource_group_name = azurerm_resource_group.az-rg-details.name
}


resource "azurerm_network_security_rule" "allow_misubnet_inbound" {
  name                        = "allow_misubnet_inbound"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "10.0.0.0/24"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.az-rg-details.name
  network_security_group_name = azurerm_network_security_group.sql-nsg.name
}

resource "azurerm_network_security_rule" "allow_health_probe_inbound" {
  name                        = "allow_health_probe_inbound"
  priority                    = 300
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "AzureLoadBalancer"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.az-rg-details.name
  network_security_group_name = azurerm_network_security_group.sql-nsg.name
}

resource "azurerm_network_security_rule" "allow_tds_inbound" {
  name                        = "allow_tds_inbound"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "1433"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.az-rg-details.name
  network_security_group_name = azurerm_network_security_group.sql-nsg.name
}

resource "azurerm_network_security_rule" "allow_on_premises_inbound" {
  name                        = "allow_on_premises_inbound"
  priority                    = 105
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["1433"]
  source_address_prefix       = "104.184.163.80"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.az-rg-details.name
  network_security_group_name = azurerm_network_security_group.sql-nsg.name
}

resource "azurerm_network_security_rule" "allow_management_inbound" {
  name                        = "allow_management_inbound"
  priority                    = 106
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["9000", "9003", "1438", "1440", "1452"]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.az-rg-details.name
  network_security_group_name = azurerm_network_security_group.sql-nsg.name
}

resource "azurerm_network_security_rule" "allow_data_center_inbound" {
  name                        = "allow_data_center_inbound"
  priority                    = 107
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["3342"]
  source_address_prefix       = "104.184.163.80"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.az-rg-details.name
  network_security_group_name = azurerm_network_security_group.sql-nsg.name
}

resource "azurerm_network_security_rule" "deny_all_inbound" {
  name                        = "deny_all_inbound"
  priority                    = 4096
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.az-rg-details.name
  network_security_group_name = azurerm_network_security_group.sql-nsg.name
}

resource "azurerm_network_security_rule" "allow_misubnet_outbound" {
  name                        = "allow_misubnet_outbound"
  priority                    = 200
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "10.0.0.0/24"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.az-rg-details.name
  network_security_group_name = azurerm_network_security_group.sql-nsg.name
}

resource "azurerm_network_security_rule" "allow_management_outbound" {
  name                        = "allow_management_outbound"
  priority                    = 102
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["80", "443", "12000"]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.az-rg-details.name
  network_security_group_name = azurerm_network_security_group.sql-nsg.name
}


resource "azurerm_network_security_rule" "deny_all_outbound" {
  name                        = "deny_all_outbound"
  priority                    = 4096
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.az-rg-details.name
  network_security_group_name = azurerm_network_security_group.sql-nsg.name
}

resource "azurerm_virtual_network" "sql-vnet" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.az-rg-details.name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.az-rg-details.location
}

resource "azurerm_subnet" "sql-subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.az-rg-details.name
  virtual_network_name = azurerm_virtual_network.sql-vnet.name
  address_prefixes     = ["10.0.0.0/24"]

  delegation {
    name = "managedinstancedelegation"

    service_delegation {
      name    = "Microsoft.Sql/managedInstances"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
      ]
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "sql-subnet-nsg-association" {
  subnet_id                 = azurerm_subnet.sql-subnet.id
  network_security_group_id = azurerm_network_security_group.sql-nsg.id
}

resource "azurerm_route_table" "sql-route-table" {
  name                          = "sql-route-table"
  location                      = azurerm_resource_group.az-rg-details.location
  resource_group_name           = azurerm_resource_group.az-rg-details.name
}

resource "azurerm_subnet_route_table_association" "sql-subnet-route-table-association" {
  subnet_id      = azurerm_subnet.sql-subnet.id
  route_table_id = azurerm_route_table.sql-route-table.id
}

resource "azurerm_mssql_managed_instance" "claims-admin" {
  name                         = var.sql_instance_name
  resource_group_name          = azurerm_resource_group.az-rg-details.name
  location                     = azurerm_resource_group.az-rg-details.location
  administrator_login          = var.admin_login
  administrator_login_password = var.admin_password
  license_type                 = "BasePrice"
  subnet_id                    = azurerm_subnet.sql-subnet.id
  sku_name                     = var.sku_name
  vcores                       = var.vcores
  storage_size_in_gb           = var.storage_size_in_gb
  timezone_id = "America/Indianapolis"
  depends_on = [
    azurerm_subnet_network_security_group_association.sql-subnet-nsg-association,
    azurerm_subnet_route_table_association.sql-subnet-route-table-association,
  ]
}
