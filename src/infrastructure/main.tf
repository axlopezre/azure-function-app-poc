resource "random_id" "rg_suffix" {
  byte_length = 4 # Generates 8 hexadecimal characters

  keepers = {
    project_name = var.project_name
    environment  = var.environment
  }
}

locals {
  project_name_clean = lower(trimspace(var.project_name))
  environment_clean  = lower(trimspace(var.environment))
  env_suffix_full    = "-${local.environment_clean}"
  # Recursos por ambiente
  rg_name                    = "${local.project_name_clean}${local.env_suffix_full}-rg"
  storage_name               = replace("${local.project_name_clean}${local.env_suffix_full}stg", "-", "")
  backend_plan_name          = "${local.project_name_clean}${local.env_suffix_full}-backend-plan"
  function_app_name          = "${local.project_name_clean}-func${local.env_suffix_full}"
  frontend_app_name          = "${local.project_name_clean}-frontend${local.env_suffix_full}"
  servicebus_name            = "${local.project_name_clean}-sb${local.env_suffix_full}-${random_id.rg_suffix.hex}"
  servicebus_queue_name      = "invoice-processing-queue-${local.environment_clean}"
  communication_service_name = "extractor-communication-resource-${local.environment_clean}-${random_id.rg_suffix.hex}"
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
}

# ─────────────────────────────
# Módulo BACKEND (Function App)
# ─────────────────────────────
module "Backend" {
  source = "./modules/Backend"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  storage_account_name = local.storage_name
  service_plan_name    = local.backend_plan_name
  function_app_name    = local.function_app_name

  app_insights_name = var.function_service_plan_name

  runtime_stack  = var.runtime_stack
  python_version = var.python_version
}

# ─────────────────────────────
# Módulo FRONTEND (Web App)
# ─────────────────────────────
module "Frontend" {
  source = "./modules/Frontend"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  web_app_name      = local.frontend_app_name
  service_plan_name = lower("sp-${local.project_name_clean}-Front-${local.environment_clean}")
}

module "Core" {
  source = "./modules/Core"

  environment               = local.env_suffix_full
  location                  = azurerm_resource_group.rg.location
  resource_group_name       = azurerm_resource_group.rg.name
  servicebus_namespace_name = local.servicebus_name
  servicebus_queue_name     = local.servicebus_queue_name

  communication_service_name          = "extractor-communication-resource"
  communication_service_data_location = "United States"

  # opcional: tags extra
  tags = {
    project = "Nextract"
  }
}