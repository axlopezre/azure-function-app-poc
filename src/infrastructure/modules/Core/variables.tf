variable "environment" {
  description = "Environment tag/value (e.g., dev, qa, prod)."
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure region where resources will be created."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name where the Service Bus Namespace will be created."
  type        = string
}

variable "servicebus_namespace_name" {
  description = "Service Bus Namespace name (must be globally unique in Azure)."
  type        = string
}

variable "tags" {
  description = "Additional tags to merge with defaults."
  type        = map(string)
  default     = {}
}

variable "servicebus_queue_name" {
  description = "Name of the Service Bus Queue"
  type        = string
}

variable "communication_service_name" {
  description = "Name for Azure Communication Service resource."
  type        = string
}

variable "communication_service_data_location" {
  description = "Data location (e.g., UnitedStates, Europe, etc.)."
  type        = string
  default     = "UnitedStates"
}