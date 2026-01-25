resource "azurerm_orchestrated_virtual_machine_scale_set" "Virtualmachine" {
  name                = "VMSS-tf"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "Standard_B2ts_v2"
  platform_fault_domain_count = 1
    instances = 3
  zones = ["1"]
  user_data_base64 = base64encode(file("user-data.ssh"))
  os_profile {
    linux_configuration {
      disable_password_authentication = true
      admin_username = "azureuser"
      admin_ssh_key {
        username = "azureuser"
        public_key = file(".ssh/id_rsa.pub.pub")
      }
    }
  }

  source_image_reference {
    publisher = "Canonical"
    offer = "0001-com-ubuntu-server-jammy"
    sku = "22_04-lts-gen2"
    version = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  network_interface {
    name = "nic"
    primary = true
    enable_accelerated_networking = false

    ip_configuration {
      name = "ipconfig"
      primary = true
      subnet_id = azurerm_subnet.subnet1.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bePool.id]
    }
    #   boot_diagnostics {
    #     storage_account_uri = ""
    #   }
  }

  lifecycle {
    ignore_changes = [
      instances
    ]
  }
  depends_on = [ azurerm_subnet.subnet1 ]
}

