
locals {

  rg_name = "rg1-ram"
  rg_location = "southindia"

  virtual_network = {

    name = "ram-vnet"
    address_space = ["10.0.0.0/16"]

  }

 subnets = [

   {
     name = "SubnetA"
     address_prefixes     = ["10.0.1.0/24"]

   },

   {
     name = "SubnetB"
     address_prefixes     = ["10.0.2.0/24"]

   }

 ]


}

resource "azurerm_resource_group" "rgname" {
  name     = local.rg_name
  location = local.rg_location
}
/*
resource "azurerm_virtual_network" "example" {
  name                = local.virtual_network.name
  location            = local.rg_location
  resource_group_name = local.rg_name
  address_space       = local.virtual_network.address_space

  depends_on = [

    azurerm_resource_group.rgname
  ]

}



resource "azurerm_subnet" "subnetA" {
  name                 = local.subnets[0].name
  resource_group_name  = local.rg_name
  virtual_network_name = local.virtual_network.name
  address_prefixes     = local.subnets[0].address_prefixes
   depends_on = [

    azurerm_resource_group.rgname

  ]

  }


resource "azurerm_subnet" "subnetB" {

  name                 = local.subnets[1].name
  resource_group_name  = local.rg_name
  virtual_network_name = local.virtual_network.name
  address_prefixes     = local.subnets[1].address_prefixes
    depends_on = [

    azurerm_resource_group.rgname

  ]



  }

resource "azurerm_network_interface" "ramnic" {
  name                = "ram-nic"
  location            = local.rg_location
  resource_group_name = local.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnetA.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.apppublicip.id
  }

  depends_on = [

     azurerm_resource_group.rgname

  ]
}

resource "azurerm_network_interface" "ramnic2" {
  name                = "ram-nic2"
  location            = local.rg_location
  resource_group_name = local.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnetA.id
    private_ip_address_allocation = "Dynamic"

  }

  depends_on = [

     azurerm_resource_group.rgname

  ]
}
resource "azurerm_public_ip" "apppublicip" {
  name                = "app-publicip"
  resource_group_name = local.rg_name
  location            = local.rg_location
  allocation_method   = "Static"

   depends_on = [

     azurerm_resource_group.rgname
  ]

}

resource "azurerm_network_security_group" "nsgram" {
  name                = "nsg-ram"
  resource_group_name = local.rg_name
  location            = local.rg_location

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

     depends_on = [

     azurerm_resource_group.rgname
  ]
}



resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.subnetA.id
  network_security_group_id = azurerm_network_security_group.nsgram.id

}


resource "azurerm_linux_virtual_machine" "vm1test" {
  name                = "vm1-test"
  resource_group_name = local.rg_name
  location            = local.rg_location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.ramnic.id,
    azurerm_network_interface.ramnic2.id
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
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

resource "azurerm_managed_disk" "extradisk" {
  name                 = "extra-disk"
  resource_group_name = local.rg_name
  location            = local.rg_location
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "1"


}

resource "azurerm_virtual_machine_data_disk_attachment" "example" {
  managed_disk_id    = azurerm_managed_disk.extradisk.id
  virtual_machine_id = azurerm_linux_virtual_machine.vm1test.id
  lun                = "10"
  caching            = "ReadWrite"
}

*/

resource "azurerm_storage_account" "23232312121212' {
  name                     = "${count.index}-ramcheekoti-storage"
  resource_group_name      = local.rg_name
  location                 = local.rg_location
  account_tier             = "Standard"
  account_replication_type = "GRS"


}