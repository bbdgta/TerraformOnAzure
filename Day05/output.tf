output "sam" {
  value = [ for count in local.nsg_rules : count.description]
}

output "sam1" {
  value = local.nsg_rules[*]
}
