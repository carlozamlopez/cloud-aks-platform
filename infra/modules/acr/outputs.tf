output "acr_name" {
  value = azurerm_container_registry.acr.name
}

output "acr_login_server" {
  description = "URL del registry — ej: acrcloudaksdevmx.azurecr.io"
  value       = azurerm_container_registry.acr.login_server
}

output "acr_id" {
  value = azurerm_container_registry.acr.id
}