output "rggrp" {
    value = azurerm_resource_group.example[*].name
}

output "stacc" {
    value = [for sa in azurerm_storage_account.example : sa.name]
}