# Application Insights
resource "azurerm_application_insights" "functions" {
  name                = var.app_insights_name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
}

# Storage Account (requerido por Function App)
resource "azurerm_storage_account" "functions" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  lifecycle {
    prevent_destroy = false
  }
}

# App Service Plan (compartido con frontend)
resource "azurerm_service_plan" "plan" {
  name                = var.service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name = "B1"
  os_type  = "Linux"
}

# Function App (Linux)
resource "azurerm_linux_function_app" "functions" {
  name                = var.function_app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.plan.id

  storage_account_name       = azurerm_storage_account.functions.name
  storage_account_access_key = azurerm_storage_account.functions.primary_access_key

  https_only = true

  site_config {
    application_stack {
      python_version = var.python_version
    }
  }

    app_settings = merge(
    {
      "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.functions.connection_string
      # VERSIÓN DE EXTENSIÓN (Muy importante)
      "FUNCTIONS_EXTENSION_VERSION" = "~4"

      # HABILITAR INDEXACIÓN V2 (Fundamental para que encuentre tus funciones)
      "AzureWebJobsFeatureFlags" = "EnableWorkerIndexing"

      # OPTIMIZACIÓN DE DEPENDENCIAS
      "PYTHON_ISOLATE_WORKER_DEPENDENCIES" = "1"
      "PYTHON_ENABLE_WORKER_EXTENSIONS"    = "1"
    },
    local.base_app_settings,
    local.durable_app_settings,
    local.cosmos_app_settings
  )

  identity {
    type = "SystemAssigned"
  }
} 