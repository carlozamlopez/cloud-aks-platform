locals {
  prefijo = "${var.proyecto}-${var.ambiente}"

  nombres = {
    resource_group = "rg-${local.prefijo}"
    vnet           = "vnet-${local.prefijo}"
    log_analytics  = "log-${local.prefijo}"
    keyvault       = "kv-${local.prefijo}"
  }

  tags_globales = {
    proyecto   = var.proyecto
    ambiente   = var.ambiente
    gestionado = "terraform"
    waf        = "aplicado"
    creado_por = "arch-carlos-amador"
    fecha      = "2026-03"
  }
}