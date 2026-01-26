# Autoscale Settings for Virtual Machine 
resource "azurerm_monitor_autoscale_setting" "vmss_autoscale" {
    name                = "vmss-autoscale"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    target_resource_id  = azurerm_orchestrated_virtual_machine_scale_set.Virtualmachine.id
    enabled = true
    profile {
        name = "autoscale"

        capacity {
            default = 3
            minimum = 1
            maximum = 3
        }

#         rule {
#             metric_trigger {
#                 metric_name        = "CpuPercentage"
#                 metric_resource_id = azurerm_app_service_plan.example.id
#                 time_grain         = "PT1M"
#                 statistic          = "Average"
#                 time_window        = "PT5M"
#                 operator           = "GreaterThan"
#                 threshold          = 70
#             }

#             scale_action {
#                 direction = "Increase"
#                 type      = "ChangeCount"
#                 value     = 1
#                 cooldown  = "PT5M"
#             }
#         }

#         rule {
#             metric_trigger {
#                 metric_name        = "CpuPercentage"
#                 metric_resource_id = azurerm_app_service_plan.example.id
#                 time_grain         = "PT1M"
#                 statistic          = "Average"
#                 time_window        = "PT5M"
#                 operator           = "LessThan"
#                 threshold          = 30
#             }

#             scale_action {
#                 direction = "Decrease"
#                 type      = "ChangeCount"
#                 value     = 1
#                 cooldown  = "PT5M"
#             }
#         }
#     }

#     notification {
#         email {
#             send_to_subscription_administrator    = true
#             send_to_subscription_co_administrator = false
#             custom_emails                         = ["admin@example.com"]
#         }
#     }
# }

# # Action Group for Alerts
# resource "azurerm_monitor_action_group" "autoscale_alerts" {
#     name                = "autoscale-action-group"
#     resource_group_name = azurerm_resource_group.example.name
#     short_name          = "autoscale"

#     email_receiver {
#         name           = "admin-email"
#         email_address  = "admin@example.com"
    }
}