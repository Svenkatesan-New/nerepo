# main.tf

provider "azurerm" {
  features {}
  subscription_id =  "5dfb4d57-e8e3-4bb5-8cec-d6857c3f385b" 
  

}

# Create Resource Group
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}

# Create Storage Account for Function App
resource "azurerm_storage_account" "example" {
  name                     = "examplestorageacct"
  resource_group_name       = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier              = "Standard"
  account_replication_type = "LRS"
}

# Create App Service Plan (for Function App)
resource "azurerm_app_service_plan" "example" {
  name                = "example-appservice-plan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "FunctionApp"
  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

# Create Function App
resource "azurerm_function_app" "example" {
  name                      = "examplefunctionapp"
  location                  = azurerm_resource_group.example.location
  resource_group_name       = azurerm_resource_group.example.name
  app_service_plan_id       = azurerm_app_service_plan.example.id
  storage_account_name     = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  version                   = "~3"
  os_type                   = "linux"

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "python"
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}




