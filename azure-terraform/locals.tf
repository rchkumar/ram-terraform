
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
