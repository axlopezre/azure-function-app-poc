locals {
  rg_name           = "${var.project_name}-rg"
  storage_name      = replace(lower("${var.project_name}stg"), "-", "")
  env_suffix_full   = "-${lower(var.environment)}"
  backend_plan_name = "${var.project_name}-backend-plan"
  function_app_name = regexreplace(
    lower(trim("${var.project_name}-func${local.env_suffix_full}", " ")),
    "[^0-9a-z-]",
    "-"
  )
  frontend_app_name = regexreplace(
    lower(trim("${var.project_name}-frontend${local.env_suffix_full}", " ")),
    "[^0-9a-z-]",
    "-"
  )
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
  name                = local.backend_plan_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku_name = "B1" # Plan de consumo
  os_type  = "Linux"
}

# Function App (Linux)
resource "azurerm_linux_function_app" "functions" {
  name                = local.function_app_name
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

# Web App Linux para Next.js
resource "azurerm_linux_web_app" "frontend" {
  name                = local.frontend_app_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id

  https_only = true

  site_config {
    application_stack {
      node_version = "20-lts" # o 18-lts, según lo que uses
    }
  }

  app_settings = {
    # Puerto interno donde corre Next (por si sirve para integraciones)
    WEBSITES_PORT                  = "3000"
    SCM_DO_BUILD_DURING_DEPLOYMENT = "true"
    NEXT_TELEMETRY_DISABLED        = "1"
  }
}

output "debug_frontend_app_name" {
  value = local.frontend_app_name
}