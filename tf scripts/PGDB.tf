provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = ">=2.7"
  skip_provider_registration = true
  features {}
}

resource "azurerm_postgresql_server" "example" {
  name                = "jaya-postgresql-server"
  location            = "East US"
  resource_group_name = "1-6d88b8-playground-sandbox"

  sku_name = "B_Gen5_2"

  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  administrator_login          = "jayapgadmin"
  administrator_login_password = "XXXXXXX"
  version                      = "9.5"
  ssl_enforcement_enabled      = false
}

resource "azurerm_postgresql_database" "example" {
  name                = "jayadb"
  resource_group_name = azurerm_postgresql_server.example.resource_group_name
  server_name         = azurerm_postgresql_server.example.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}