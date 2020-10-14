provider "azurerm" {
    version = 1.38
    }
resource "azurerm_storage_account" "Test" {
  name                     = "swateeteststorageaccount"
  resource_group_name      = "156-8a377e-deploy-an-azure-storage-account-with-te"
  location                 = "East US"
  account_tier            = "Standard"
  account_replication_type = "LRS"

   tags = {
    environment = "Terraform Storage"
    CreatedBy = "Admin"
    User = "Swatee"
      }
  }