output "sam" {
  value = [ for count in local.nsg_rules : count.description]
}

output "sam1" {
  value = local.nsg_rules[*]
}

output "sam2" {
  value = join("-", [for port in var.port : "port-${port}"])
}

output "sam3" {
  value = local.vm_sze
}