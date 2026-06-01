# Configure the Microsoft Azure Provider
provider "azurerm" {
    features {}
}

resource "azurerm_public_ip" "main" {
  name                = "test-public-ip"
  location            = "Denmark East"
  resource_group_name = "Denmark_East"
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "main" {
  name                = "test-nic"
  location            = "Denmark East"
  resource_group_name = "Denmark_East"

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = "/subscriptions/3c3ac820-a526-4fd5-841f-cbb2d7ffa483/resourceGroups/Denmark_East/providers/Microsoft.Network/virtualNetworks/Image-vnet/subnets/default"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}


resource "azurerm_linux_virtual_machine" "main" {
  name                  = "test-vm"
  location              = "Denmark East"
  resource_group_name   = "Denmark_East"
  network_interface_ids = [azurerm_network_interface.main.id]
  size               = "Standard_D2s_v3"

 

  source_image_id ="/subscriptions/3c3ac820-a526-4fd5-841f-cbb2d7ffa483/resourceGroups/Denmark_East/providers/Microsoft.Compute/galleries/image_vm/images/image"


  os_disk {
    caching           = "ReadWrite"
   storage_account_type = "Standard_LRS"
  }


 
    admin_username = "devops"
    admin_password = "Devopsuser1234"


    disable_password_authentication = false

  secure_boot_enabled = true
  vtpm_enabled        = true

  
}

