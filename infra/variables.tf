variable "subscription_id" {
  type      = string
  sensitive = true
}
variable "location" {
  type    = string
  default = "mexicocentral"
}
variable "ambiente" {
  type = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.ambiente)
    error_message = "Ambiente debe ser dev, staging o prod."
  }
}
variable "proyecto" {
  type = string
}
variable "architect_object_id" {
  type      = string
  sensitive = true
}
variable "ti_admin_object_id" {
  type      = string
  sensitive = true
}
variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}
variable "subnets" {
  type = map(object({
    prefijo   = string
    proposito = string
  }))
  default = {
    management = { prefijo = "10.0.1.0/24", proposito = "administracion" }
    workloads  = { prefijo = "10.0.2.0/24", proposito = "cargas-de-trabajo" }
    dmz        = { prefijo = "10.0.3.0/24", proposito = "zona-desmilitarizada" }
  }
}
variable "node_count" {
  type    = number
  default = 1
}
variable "vm_size" {
  type    = string
  default = "Standard_DC2s_v3"
}