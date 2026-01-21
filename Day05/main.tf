resource "azurerm_resource_group" "example" {
  name     = "${var.environment}-rg"
  location = "East US 2"

  tags = merge(var.tags_default, var.tags_environment)
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
    }
  }

  tags = merge(var.tags_default, var.tags_environment)
  
}