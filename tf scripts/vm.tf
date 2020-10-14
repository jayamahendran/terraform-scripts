provider "azurerm" {
    version = 1.38
    }

# Create virtual network
resource "azurerm_virtual_network" "TFNet" {
    name                = "TFVnet"
    address_space       = ["10.0.0.0/16"]
    location            = "East US"
    resource_group_name = "1-32228a-playground-sandbox"

    tags = {
        environment = "Terraform VNET"
    }
}
# Create subnet
resource "azurerm_subnet" "tfsubnet" {
    name                 = "jayasubnet"
    resource_group_name = azurerm_virtual_network.TFNet.resource_group_name
    virtual_network_name = azurerm_virtual_network.TFNet.name
    address_prefix       = "10.0.1.0/24"
}

#Deploy Public IP
resource "azurerm_public_ip" "example" {
  name                = "jayapubip"
  location            = "East US"
  resource_group_name = azurerm_virtual_network.TFNet.resource_group_name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

#Create NIC
resource "azurerm_network_interface" "example" {
  name                = "jayanic"  
  location            = "East US"
  resource_group_name = azurerm_virtual_network.TFNet.resource_group_name

    ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.tfsubnet.id 
    private_ip_address_allocation  = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example.id
  }
}

#Create Boot Diagnostic Account
resource "azurerm_storage_account" "sa" {
  name                     = "jayaaiagnosticaccount" 
  resource_group_name      = azurerm_virtual_network.TFNet.resource_group_name
  location                 = "East US"
   account_tier            = "Standard"
   account_replication_type = "LRS"

   tags = {
    environment = "Boot Diagnostic Storage"
    CreatedBy = "Admin"
   }
  }

#Create Virtual Machine
resource "azurerm_virtual_machine" "example" {
  name                  = "JayaVM"  
  location              = "East US"
  resource_group_name   = azurerm_virtual_network.TFNet.resource_group_name
  network_interface_ids = [azurerm_network_interface.example.id]
  vm_size               = "Standard_B1s"
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk1"
    disk_size_gb      = "128"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "JayaServer"
    admin_username = "admin"
    admin_password = "Test@1234"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

boot_diagnostics {
        enabled     = "true"
        storage_uri = azurerm_storage_account.sa.primary_blob_endpoint
    }
}