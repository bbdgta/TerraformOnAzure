variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  default    = "e85d2a4f-b968-4dbf-8631-bdc6fd9fe118"
}

variable "environment" {
    type = string
    description = "Default env type"
    default = "uat"
}

variable "storage_os" {
    type = number
    description = "OS type for the storage account"
    default = 30

}

variable "is_delete" {
    type = bool
    description = "Flag to delete OS disk"
    default = true
  
}

variable "allowed_locations" {
  type = list(string)
  description = "List of allowed locations"
  default = ["eastus", "westus", "centralus"]
}

variable "storage_account_name" {
  type = set(string)
  default = ["bbdgt221", "bbdgt222", "bbdgt223"]
}

variable "tags_default" {
  type = map(string)
  description = "Default tags to apply to resources"
  default = {
    company    = "TechCorp"
    managed_by = "terraform"
  }
}
variable "tags_environment" {
  type = map(string)
  description = "Environment specific tags"
  default = {
    environment = "development"
    project     = "project-x"
  }
}

# variable "stoacc_name" {
#   type = string
#   description = "Storage account name"
#   default = substr("bbdgtisgoodandwillbeapartoftheexam",0,24)
# }

variable "port" {
  description = "all ports"
  type        = string
  default     = "22, 80, 443, 3389"
}