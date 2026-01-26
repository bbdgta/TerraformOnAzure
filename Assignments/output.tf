# output "sam" {
#   value = [ for count in local.nsg_rules : count.description]
# }

# output "sam1" {
#   value = local.nsg_rules[*]
# }

# output "sam2" {
#   value = join("-", [for port in var.port : "port-${port}"])
# }

# output "sam3" {
#   value = local.vm_sze
# }

# output "sam4" {
#   value = endswith(var.backup_name, "_backup") ? "uat-backup" : "stage-backup"
# }

# output "sam5" {
#   value = var.credential
#   sensitive = true
# }

# output "mainfile_check" {
#   value = var.mainfileexists
# }

output "contatenated_list" {
  value = concat(var.user_locations, var.default_locations)
}

output "printlocation" {
  value = local.combined_locations
}

output "Check" {
  value = local.total_cost
}

output "MAxcost" {
  value = local.max_cost
}