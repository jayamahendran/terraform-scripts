provider "azurerm" {
    version = 1.38
    }

resource "azurerm_resource_group" "example" {
  name     = "1-ab23f2-playground-sandbox"
  location = "East US"
}

resource "azurerm_logic_app_workflow" "example" {
  name                = "jayalogicapp"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}