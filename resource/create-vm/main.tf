# Configure the Microsoft Azure Provider
provider "azurerm" {
    features {}
}

resource "azurerm_network_interface" "main" {
  name                = "test-nic"
  location            = "Demark East"
  resource_group_name = "Denmark_East"

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = "/subscriptions/3c3ac820-a526-4fd5-841f-cbb2d7ffa483/resourceGroups/Denmark_East/providers/Microsoft.Network/virtualNetworks/Image-vnet/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_virtual_machine" "main" {
  name                  = "test-vm"
  location              = "Denmark East"
  resource_group_name   = "Denmark_East"
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_D2s_v3"

  
 delete_os_disk_on_termination = true

 

  storage_image_reference {
    publisher = "RedHat"
    offer     = "RHEL "
    sku       = "101-gen2"
    version   = "latest"
  }
  storage_os_disk {
    name              = "test-vm"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "test-vm"
    admin_username = "devops"
    admin_password = "Devopsuser1234"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  
}

