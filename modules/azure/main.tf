data "azurerm_resource_group" "example-group" {
  name = "test123"
}

data  "azurerm_virtual_network" "example-virtual-network" {
  name = "test123-vnet"
  resource_group_name = data.azurerm_resource_group.example-group.name
}

data "azurerm_subnet" "example-subnet" {
  name                 = "default"
  virtual_network_name =data.azurerm_virtual_network.example-virtual-network.name
  resource_group_name  = data.azurerm_resource_group.example-group.name
}

data "azurerm_network_interface" "example" {
  name                = "first-vm409"
  resource_group_name = data.azurerm_resource_group.example-group.name
}

resource "azurerm_linux_virtual_machine" "example" {
  
  count = var.number_of_instances == 1 ? 1 : 0
  
  name                = "VM-Narahari"
  resource_group_name = data.azurerm_resource_group.example-group.name
  location            = data.azurerm_resource_group.example-group.location

  size                = "Standard_F2"

  admin_username      = "adminuser"  
  
  network_interface_ids = [
    data.azurerm_network_interface.example.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file(var.public_key_location)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

