terraform {
  backend "s3" {
    key = "environments/air-prod/vpn.tf"
  }
}

locals {
  tags = {
    Environment = "air-prod"
    Terraform   = "true"
  }

  vpc_id          = data.terraform_remote_state.network.outputs.vpc_id
  private_subnets = data.terraform_remote_state.network.outputs.private_subnets
  default_route_table_id = data.terraform_remote_state.network.outputs.default_route_table_id
}

resource "aws_customer_gateway" "customer_gateway" {
  bgp_asn    = var.customer_asn
  ip_address = var.customer_ip
  type       = "ipsec.1"

  tags = local.tags
}

resource "aws_vpn_connection" "vpn_connection" {
  customer_gateway_id      = aws_customer_gateway.customer_gateway.id
  transit_gateway_id       = aws_ec2_transit_gateway.transit_gateway.id
  type                     = "ipsec.1"
  tunnel_inside_ip_version = var.ip_version

  tags = local.tags
}
