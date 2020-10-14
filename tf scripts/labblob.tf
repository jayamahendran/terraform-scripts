provider "azurerm" {
    version = 1.38
    }

resource "azurerm_storage_account" "Test" {
  name                     = "jayateststorageaccount"
  resource_group_name      = "156-4986cc-deploy-an-azure-storage-account-with-te"
  location                 = "East US"
  account_tier            = "Standard"
  account_replication_type = "LRS"

   tags = {
    environment = "Terraform Storage"
    CreatedBy = "Admin"
    User = "Swatee"
      }
  }

resource "azurerm_storage_container" "lab" {
  name                  = "blobcontainer4lab"
  storage_account_name  = azurerm_storage_account.Test.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "lab" {
  name                   = "TerraformBlob"
  storage_account_name   = azurerm_storage_account.Test.name
  storage_container_name = azurerm_storage_container.Test.name
  type                   = "Block"
}
resource "azurerm_storage_share" "lab" {
  name                 = "terraformshare"  
  storage_account_name = azurerm_storage_account.Test.name
  quota                = 50
}