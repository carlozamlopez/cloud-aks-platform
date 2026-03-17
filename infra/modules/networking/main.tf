# ── Resource Group ────────────────────────────────────
resource "azurerm_resource_group" "rg" {
  name     = var.nombres["resource_group"]
  location = var.location
  tags     = var.tags
}

# ── Log Analytics Workspace ───────────────────────────
# Base para Azure Monitor y Sentinel — WAF Operational Excellence
resource "azurerm_log_analytics_workspace" "log" {
  name                = var.nombres["log_analytics"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}

# ── VNet Principal ────────────────────────────────────
resource "azurerm_virtual_network" "vnet" {
  name                = var.nombres["vnet"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.address_space

  # DNS interno de Azure
  dns_servers = []
  tags        = var.tags
}

# ── Subnets dinámicas ─────────────────────────────────
# Se crean todas las subnets definidas en variables
resource "azurerm_subnet" "subnets" {
  for_each = var.subnets

  name                 = "snet-${each.key}-${var.prefijo}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [each.value.prefijo]
}

# ── NSG por subnet ────────────────────────────────────
# Cada subnet tiene su propio NSG — microsegmentación
resource "azurerm_network_security_group" "nsgs" {
  for_each = var.subnets

  name                = "nsg-${each.key}-${var.prefijo}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}

# ── Reglas NSG — Management ───────────────────────────
resource "azurerm_network_security_rule" "allow_bastion_management" {
  name                        = "Allow-Bastion-Inbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = ["22", "3389"]
  source_address_prefix       = var.bastion_subnet_prefix  # ← IP real, no Service Tag
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsgs["management"].name
}

resource "azurerm_network_security_rule" "deny_rdp_internet" {
  name                        = "Deny-RDP-Internet"
  priority                    = 4000
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsgs["management"].name
}

# ── Asociar NSGs a Subnets ────────────────────────────
resource "azurerm_subnet_network_security_group_association" "nsg_asociaciones" {
  for_each = var.subnets

  subnet_id                 = azurerm_subnet.subnets[each.key].id
  network_security_group_id = azurerm_network_security_group.nsgs[each.key].id
}

# ── Diagnósticos de VNet → Log Analytics ─────────────
# WAF — Operational Excellence: toda la red es observable
resource "azurerm_monitor_diagnostic_setting" "vnet_diag" {
  name                       = "diag-vnet-${var.prefijo}"
  target_resource_id         = azurerm_virtual_network.vnet.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log.id

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}