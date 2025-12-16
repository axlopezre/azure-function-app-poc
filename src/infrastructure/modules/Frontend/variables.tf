variable "resource_group_name" {
  type        = string
  description = "Nombre del Resource Group donde se creará el frontend."
}

variable "location" {
  type        = string
  description = "Región de Azure."
}

variable "service_plan_name" {
  type        = string
  description = "Nombre del App Service Plan del backend."
}

variable "web_app_name" {
  type        = string
  description = "Nombre de la Web App (Next.js)."
}