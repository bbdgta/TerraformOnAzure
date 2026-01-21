terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 4.8.0"
    }
  }
  required_version = ">=1.9.0"

  backend "azurerm" {
    resource_group_name  = "bbdgt-learntf"  # Can also be set via `ARM_ACCESS_KEY` environment variable.
    storage_account_name = "bbdgt27714"                                 # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "tfstate"                                  # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "dev.terraform.tfstate"                   # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

provider "azurerm" {
    subscription_id = var.subscription_id
    features {
      
    }
  
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

variable "environment" {
    type = string
    description = "Default env type"
    default = "dev"
}
resource "azurerm_storage_account" "example" {
 
  name                     = "bbdgt0110"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location # implicit dependency
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = var.environment
  }
}