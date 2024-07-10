resource "aws_ec2_transit_gateway" "transit_gateway" {
  amazon_side_asn                 = var.aws_asn
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"

  tags = local.tags
}

resource "aws_ec2_transit_gateway_route" "tgw_default_route" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw_attach_edge.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway.transit_gateway.association_default_route_table_id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_attach_edge" {
  subnet_ids         = local.private_subnets
  transit_gateway_id = aws_ec2_transit_gateway.transit_gateway.id
  vpc_id             = local.vpc_id
  tags               = local.tags
}

resource "aws_route" "route_transit_gateway" {
  route_table_id         = local.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = aws_ec2_transit_gateway.transit_gateway.id
  depends_on = [
    aws_ec2_transit_gateway.transit_gateway
  ]
}
