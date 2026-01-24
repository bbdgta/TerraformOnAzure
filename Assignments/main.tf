resource "azurerm_resource_group" "example" {
  name     = "${var.environment}-rg"
  location = "East US 2"

}

locals {
  nsg = join("-", [for port in var.port : "port-${port}"])
  vm_sze = lookup(var.vmsizes, var.environment, "standard_D2s_v3")
  backup_name = endswith(var.backup_name, "_backup") ? "uat-backup" : "stage-backup"
  combined_locations = toset(concat(var.user_locations, var.default_locations))
  total_cost = toset([for cost in var.costs : abs(cost)])
  max_cost = max(local.total_cost...)
}

resource "azurerm_network_security_group" "example" {
  name                = var.environment == "uat" ? "uat-nsg" : "stage-nsg"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  dynamic "security_rule" {
    for_each = local.nsg_rules
    content {
      name                       = security_rule.key
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description = local.nsg
    }
  }

  tags = merge(var.tags_default, var.tags_environment)
  
}
