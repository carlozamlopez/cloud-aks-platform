variable "prefijo"       { type = string }
variable "location"      { type = string }
variable "nombres"       { type = map(string) }
variable "address_space" { type = list(string) }
variable "tags"          { type = map(string) }

variable "subnets" {
  type = map(object({
    prefijo   = string
    proposito = string
  }))
}

variable "bastion_subnet_prefix" {
  description = "Prefijo CIDR de la subnet de Azure Bastion"
  type        = string
  default     = "10.0.4.0/26"  # /26 es el mínimo requerido por Bastion
}