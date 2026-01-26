resource "azurerm_resource_group" "rg" {
    name     = "theprojectrg"
    location = "Central US"
    }

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-security-group"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "Allow-http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

    security_rule {
        name                       = "Allow-https"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "allow-ssh"
        priority                   = 120
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}

resource "azurerm_subnet_network_security_group_association" "myNSG" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.nsg.id
  depends_on = [
    azurerm_subnet.subnet1,
    azurerm_network_security_group.nsg
  ]
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-network"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "Test"
    }
}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet-1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/20"]
}

resource "azurerm_public_ip" "LoadBalancerPublicIP1" {
  name                = "LoadBalancerPublicIP"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = [ "1", "2", "3" ]
  domain_name_label   = "${azurerm_resource_group.rg.name}-lb-pip"
}

# Load balancer with frontend IP configuration
resource "azurerm_lb" "LoadBalancer1" {
  name                = "LoadBalancer"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
    frontend_ip_configuration {
        name                 = "LoadBalancerFrontEnd"
        public_ip_address_id = azurerm_public_ip.LoadBalancerPublicIP1.id
    }

}

resource "azurerm_lb_backend_address_pool" "bePool" {
    name                = "BackendAddressPool"
    loadbalancer_id    = azurerm_lb.LoadBalancer1.id
}

resource "azurerm_lb_rule" "name" {
    name                           = "HTTP"
    loadbalancer_id                = azurerm_lb.LoadBalancer1.id
    protocol                       = "Tcp"
    frontend_port                  = 80
    backend_port                   = 80
    frontend_ip_configuration_name = "LoadBalancerFrontEnd"
    backend_address_pool_ids        = [azurerm_lb_backend_address_pool.bePool.id]
    probe_id                       = azurerm_lb_probe.probe.id
}

resource "azurerm_lb_probe" "probe" {
    name                = "HTTP-probe"
    loadbalancer_id     = azurerm_lb.LoadBalancer1.id
    protocol            = "Http"
    port                = 80
    request_path        = "/"
}

resource "azurerm_lb_nat_rule" "ssh" {
    name                           = "SSH"
    resource_group_name = azurerm_resource_group.rg.name
    loadbalancer_id                = azurerm_lb.LoadBalancer1.id
    protocol                       = "Tcp"
    frontend_port                  = 4222
    backend_port                   = 22
    frontend_ip_configuration_name = "LoadBalancerFrontEnd"
    depends_on = [azurerm_lb.LoadBalancer1]
}

resource "azurerm_public_ip" "NatgwpubIP" {
    name                = "NatgwpubIP"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    allocation_method   = "Static"
    sku                 = "Standard"
    zones               = [ "1"]
}

resource "azurerm_nat_gateway" "Natgw" {
    name                = "Natgw"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    sku_name            = "Standard"
    idle_timeout_in_minutes = 10
    zones = ["1"]

}

resource "azurerm_subnet_nat_gateway_association" "Natgwassoc" {
    subnet_id      = azurerm_subnet.subnet1.id
    nat_gateway_id = azurerm_nat_gateway.Natgw.id
}

resource "azurerm_nat_gateway_public_ip_association" "NatgwpubIPAssoc" {
    nat_gateway_id      = azurerm_nat_gateway.Natgw.id
    public_ip_address_id = azurerm_public_ip.NatgwpubIP.id  
}
