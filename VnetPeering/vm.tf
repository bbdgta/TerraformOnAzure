resource "azurerm_network_interface" "main" {
    name                = "learntf-nic1"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
        name                          = "internal"
        subnet_id                     = azurerm_subnet.subnet1.id
        private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_virtual_machine" "vm1" {
    name                  = "peer1-vm1"
    location              = azurerm_resource_group.rg.location
    resource_group_name   = azurerm_resource_group.rg.name
    network_interface_ids = [azurerm_network_interface.main.id]
    vm_size               = "Standard_D2s_v3"

    delete_data_disks_on_termination = true
    
    storage_os_disk {
        name              = "peer1-vm1-osdisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    os_profile {
        computer_name  = "learntf-vm1"
        admin_username = "azureuser"
        admin_password = "P@ssword1234!"
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }
}


resource "azurerm_network_interface" "main2" {
    name                = "peer2-nic2"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
        name                          = "internal"
        subnet_id                     = azurerm_subnet.subnet2.id
        private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_virtual_machine" "vm2" {
    name                  = "peer2-vm2"
    location              = azurerm_resource_group.rg.location
    resource_group_name   = azurerm_resource_group.rg.name
    network_interface_ids = [azurerm_network_interface.main2.id]
    vm_size               = "Standard_D2s_v3"

    storage_os_disk {
        name              = "peer2-vm2-osdisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    os_profile {
        computer_name  = "learntf-vm2"
        admin_username = "azureuser"
        admin_password = "P@ssword1234!"
    }

    os_profile_linux_config {
        disable_password_authentication = false
    
    }
}