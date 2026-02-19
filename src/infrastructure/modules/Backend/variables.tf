variable "resource_group_name" {
  type        = string
  description = "Nombre del Resource Group donde se creará el backend."
}

variable "location" {
  type        = string
  description = "Región de Azure."
}

variable "storage_account_name" {
  type        = string
  description = "Nombre del Storage Account para la Function."
}

variable "service_plan_name" {
  type        = string
  description = "Nombre del App Service Plan del backend."
}

variable "function_app_name" {
  type        = string
  description = "Nombre de la Azure Function App."
}

variable "app_insights_name" {
  type        = string
  description = "Nombre de la instancia de Application Insights."
}

variable "runtime_stack" {
  type        = string
  description = "Runtime de la Function (python / node / dotnet)."
}

variable "python_version" {
  type        = string
  description = "Versión de Python para la Function."
}

variable "enable_durable" {
  type    = bool
  default = false
}

variable "cosmos_connection_string" {
  type    = string
  default = null
}