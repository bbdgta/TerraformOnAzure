output "sam" {
  value = [ for count in local.nsg_rules : count.description]
}