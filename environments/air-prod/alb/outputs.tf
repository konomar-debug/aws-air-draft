output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
  description = "The ID of the ALB security group"
}

output "alb_sg_name" {
  value = aws_security_group.alb_sg.name
  description = "The name of the ALB security group"
}

output "alb_sg_vpc_id" {
  value = aws_security_group.alb_sg.vpc_id
  description = "The VPC ID of the ALB security group"
}


output "listener_arn" {
  value       = aws_lb_listener.listener.arn
  description = "The ARN of the load balancer listener"
}

output "listener_load_balancer_arn" {
  value       = aws_lb_listener.listener.load_balancer_arn
  description = "The ARN of the load balancer associated with the listener"
}

output "listener_port" {
  value       = aws_lb_listener.listener.port
  description = "The port on which the load balancer listener is listening"
}

output "listener_protocol" {
  value       = aws_lb_listener.listener.protocol
  description = "The protocol used by the load balancer listener"
}

output "listener_default_action_type" {
  value       = aws_lb_listener.listener.default_action[0].type
  description = "The default action type of the load balancer listener"
}

output "listener_default_action_target_group_arn" {
  value       = aws_lb_listener.listener.default_action[0].target_group_arn
  description = "The ARN of the target group for the default action of the load balancer listener"
}

output "alb_dns_name" {
  value       = aws_alb.application_load_balancer.dns_name
  description = "The DNS name of the Application Load Balancer"
}
