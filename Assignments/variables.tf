variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  default    = "e85d2a4f-b968-4dbf-8631-bdc6fd9fe118"
}

variable "environment" {
    type = string
    description = "Default env type"
    default = "prod"
    validation {
      condition = contains(["dev","prod","test"],var.environment)
      error_message = "Enter correct value for environment. Allowed values are dev, prod, test."
    }
}

variable "vmsizes" {
    type = map(string)
    description = "Default environment type"
    default = {
        dev  = "standard_D2s_v3",
        prod = "standard_D4s_v3",
        test = "standard_D8s_v3"
    }
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

variable "port" {
  description = "all ports"
  type        = list(number)
  default     = [22, 80, 443, 3389]
}
