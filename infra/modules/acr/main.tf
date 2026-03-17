# ── Azure Container Registry ──────────────────────────
resource "azurerm_container_registry" "acr" {
  name                = "acr${replace(var.prefijo, "-", "")}mx"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"  # Basic para lab, Standard/Premium para producción

  # SECURITY — Sin acceso anónimo
  admin_enabled = false

  tags = var.tags
}

# ── RBAC — AKS puede hacer pull de imágenes ───────────
# Sin esto AKS no puede descargar imágenes del ACR
resource "azurerm_role_assignment" "aks_acr_pull" {
  count                = 1
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = var.aks_principal_id
}