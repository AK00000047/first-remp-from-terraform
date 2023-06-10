module "vpc_module" {
  source     = "./vpc"
  for_each   = var.vpc_config
  cidr_block = each.value.cidr_block
  tags       = each.value.tags
}
module "subnet_module" {
  source            = "./subnet"
  vpc_id            = module.vpc_module["vpc1"].vpc_id
  for_each          = var.subnet_config
  cidr_block        = each.value.cidr_block
  tags              = each.value.tags
  availability_zone = each.value.availability_zone
}
module "internet_gateway" {
  source = "./ingw"
  for_each=var.internet_gateway_config
  vpc_id = module.vpc_module["vpc1"].vpc_id

}
module "eip_module" {
  source   = "./eip"
  for_each = var.eip_config
  tags     = each.value.tags

}
module "nat_gateway" {
  source    = "./natgw"
  for_each  = var.nat_gateway_config
  eip_id    = module.eip_module[each.value.eip_name].eip_id
  subnet_id = module.subnet_module[each.value.subnet_name].subnet_id
  tags      = each.value.tags
}
module "route_table_module" {

  source = "./route_table"

  for_each = var.route_table_config

  vpc_id = module.vpc_module["vpc1"].vpc_id

  gateway_id = each.value.private == 0 ? module.internet_gateway[each.value.gateway_name].internet_gateway_id : module.nat_gateway[each.value.gateway_name].nat_gateway_id

  tags = each.value.tags

}

module "route_table_asso" {
  source         = "./route_table_asso"
  for_each       = var.route_table_association
  subnet_id      = module.subnet_module[each.value.subnet_name].subnet_id
  route_table_id = module.route_table_module[each.value.route_table_name].route_id
}
  
  module "security_group_module" {

  source = "./aws_security"

  for_each = var.security_group_config

  sg_name = each.value.sg_name

  sg_description = each.value.sg_description

  vpc_id = module.vpc_module["vpc1"].vpc_id

  from_port = each.value.from_port

  to_port = each.value.to_port

  protocol = each.value.protocol

  cidr_blocks = each.value.cidr_blocks

  tags = each.value.tags

}


  module "aws_instance"{
    source="./ec2instance"
    key="KEYWEB"
    ami="ami-04980462b81b515f6"
    for_each = var.instance_config
    instance_type = each.value.instance_type
    subnet_id = module.subnet_module[each.value.subnet_name].subnet_id
    security_group_id = module.security_group_module[each.value.security_group_name].security_group_id
    tags = each.value.tags
    
  }
