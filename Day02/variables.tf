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