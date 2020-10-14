provider "azurerm" {
    version = 1.38
    }

# Create virtual network
resource "azurerm_virtual_network" "TFNet" {
    name                = "JayaVnet"
    address_space       = ["10.0.0.0/16"]
    location            = "eastus"
    resource_group_name = "155-dac7ae-deploy-azure-vlans-and-subnets-with-ter"

    tags = {
        environment = "Terraform Networking"
    }
}

# Create subnet
resource "azurerm_subnet" "tfsubnet" {
    name                 = "JayaSubnet"
    resource_group_name = azurerm_virtual_network.TFNet.resource_group_name
    virtual_network_name = azurerm_virtual_network.TFNet.name
    address_prefix       = "10.0.1.0/24"
}
resource "azurerm_subnet" "tfsubnet2" {
    name                 = "JayaSubnet2"
    resource_group_name = azurerm_virtual_network.TFNet.resource_group_name
    virtual_network_name = azurerm_virtual_network.TFNet.name
    address_prefix       = "10.0.2.0/24"
}