provider "azurerm" {
    version = 1.38
    }

resource "azurerm_app_service_plan" "svcplan" {
  name                = "jaya_app_svcplan"
  location            = "eastus"
  resource_group_name = "191-ebc9cf-deploy-a-web-application-with-terraform"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "appsvc" {
  name                = "jayawebapp"
  location            = "eastus"
  resource_group_name = azurerm_app_service_plan.svcplan.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.svcplan.id


  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}