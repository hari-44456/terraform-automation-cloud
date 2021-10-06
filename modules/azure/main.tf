resource "azurerm_resource_group" "main" {
  count = var.number_of_instances
  name     = "${var.prefix}-resources"
  location = var.location
}

resource "azurerm_virtual_network" "main" {

  count = var.number_of_instances

  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main[0].location
  resource_group_name = azurerm_resource_group.main[0].name
}

resource "azurerm_subnet" "internal" {

  count = var.number_of_instances

  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main[0].name
  virtual_network_name = azurerm_virtual_network.main[0].name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "main" {

  count = var.number_of_instances

  name                = "${var.prefix}-pip"
  resource_group_name = azurerm_resource_group.main[0].name
  location            = azurerm_resource_group.main[0].location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "main" {

  count = var.number_of_instances

  name                = "${var.prefix}-nic"
  resource_group_name = azurerm_resource_group.main[0].name
  location            = azurerm_resource_group.main[0].location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main[0].id
  }
}

resource "azurerm_linux_virtual_machine" "main" {

  count = var.number_of_instances

  name                            = "${var.prefix}-vm"
  resource_group_name             = azurerm_resource_group.main[0].name
  location                        = azurerm_resource_group.main[0].location
  size                            = "Standard_F2"
  admin_username                  = var.user

  network_interface_ids = [
    azurerm_network_interface.main[0].id,
  ]

  admin_ssh_key {
    username   = var.user
    public_key = file(var.public_key_location)
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  provisioner "remote-exec" {
    inline = [
      "ls -la /tmp",
    ]

    connection {
      host     = self.public_ip_address
      user     = self.admin_username
      private_key = file(var.private_key_location)
    }
  }

  provisioner "local-exec" {
      command = "echo ${self.public_ip_address} >> public_ip.txt"
  }
}