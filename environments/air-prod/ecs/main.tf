locals {
  private_subnets  = data.terraform_remote_state.network.outputs.private_subnets
  target_group_arn = data.terraform_remote_state.alb.outputs.listener_default_action_target_group_arn
  repository_url   = data.terraform_remote_state.ecr.outputs.ecr_repositories[0]
  aws_lb_listener  = data.terraform_remote_state.alb.outputs.listener_arn
  alb_sg_id        = data.terraform_remote_state.alb.outputs.alb_sg_id
}


resource "aws_ecs_cluster" "ecs_cluster" {
  name = "ecs-cluster-air-prod"
}


resource "aws_ecs_task_definition" "task_definition" {
  family                   = "nginx-family"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([{
    name        = var.container_name
    image       = "nginx:latest"
    cpu         = 256
    memory      = 512
    execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
    task_role_arn            = aws_iam_role.ecsTaskRole.arn
    essential   = true
    portMappings = [{
      containerPort = var.container_port
      hostPort      = var.container_port
    }]
    healthCheck = {
      command     = ["CMD-SHELL", "curl -f http://localhost/ || exit 1"]
      interval    = 30
      timeout     = 5
      retries     = 3
      startPeriod = 0
    }
  }])
}

resource "aws_ecs_service" "ecs_service" {
  name                = "air-prod-ecs-service"
  cluster             = aws_ecs_cluster.ecs_cluster.arn
  task_definition     = aws_ecs_task_definition.task_definition.arn
  launch_type         = "FARGATE"
  scheduling_strategy = "REPLICA"
  desired_count       = 2

  network_configuration {
    subnets          = local.private_subnets
    assign_public_ip = false
    security_groups  = [aws_security_group.ecs_sg.id, local.alb_sg_id]
  }


  load_balancer {
    target_group_arn = local.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
  depends_on = [local.aws_lb_listener]
}

