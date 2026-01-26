terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 4.8.0"
    }
  }
  required_version = ">=1.9.0"

}

provider "azurerm" {
    subscription_id = "e85d2a4f-b968-4dbf-8631-bdc6fd9fe118"
    features {
      resource_group {
        prevent_deletion_if_contains_resources = false
      }
    }
  
}
