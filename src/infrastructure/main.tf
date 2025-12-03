locals {
  rg_name          = "${var.project_name}-rg"
  storage_name     = replace(lower("${var.project_name}stg"), "-", "")
  plan_name        = "${var.project_name}-plan"
  functionapp_name = "${var.project_name}-func"
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
}

resource "azurerm_application_insights" "functions" {
  name                = var.function_service_plan_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
}

# Storage Account (requerido por Function App)
resource "azurerm_storage_account" "functions" {
  name                     = local.storage_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  lifecycle {
    prevent_destroy = false
  }
}

# Consumption plan para Functions
resource "azurerm_service_plan" "plan" {
  name                = local.plan_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku_name = "Y1"      # Plan de consumo
  os_type  = "Linux"
}

# Function App (Linux)
resource "azurerm_linux_function_app" "functions" {
  name                = local.functionapp_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id

  storage_account_name       = azurerm_storage_account.functions.name
  storage_account_access_key = azurerm_storage_account.functions.primary_access_key

  https_only = true

  site_config {
    application_stack {
        python_version = var.python_version
    }
  }

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME = var.runtime_stack
    WEBSITE_RUN_FROM_PACKAGE = "1"
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_storage_account" "storage" {
  name                     = var.storage_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_role_assignment" "storage" {
  scope                = azurerm_storage_account.storage.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_linux_function_app.functions.identity[0].principal_id
  depends_on = [
    azurerm_linux_function_app.functions
  ]
}

output "function_app_name" {
  description = "Nombre de la Azure Function App creada"
  value       = azurerm_linux_function_app.functions.name
}