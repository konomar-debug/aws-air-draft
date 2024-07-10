terraform {
  backend "s3" {
    key = "environments/air-prod/alb.tf"
  }
}

locals {
  tags = {
    Environment = "air-prod"
    Terraform   = "true"
  }

  vpc_id         = data.terraform_remote_state.network.outputs.vpc_id
  public_subnets = data.terraform_remote_state.network.outputs.public_subnets
}


resource "aws_alb" "application_load_balancer" {
  name               = "air-prod"
  internal           = false
  load_balancer_type = "application"
  subnets            = local.public_subnets
  security_groups    = [aws_security_group.alb_sg.id]
}


resource "aws_lb_target_group" "target_group" {
  name        = "air-prod"
  port        = var.container_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = local.vpc_id
  health_check {
    path                = "/health"
    protocol            = "HTTP"
    matcher             = "200"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 10
    interval            = 30
  }
}


resource "aws_security_group" "alb_sg" {
  vpc_id                 = local.vpc_id
  name                   = "air-prod-sg-alb"
  description            = "Security group for alb"
  revoke_rules_on_delete = true
}


resource "aws_security_group_rule" "alb_http_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  description       = "Allow http inbound traffic from internet"
  security_group_id = aws_security_group.alb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "alb_https_ingress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "TCP"
  description       = "Allow https inbound traffic from internet"
  security_group_id = aws_security_group.alb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  description       = "Allow outbound traffic from alb"
  security_group_id = aws_security_group.alb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}


resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}
