module "networking" {
  source = "./modules/networking"

  vpc_cidr           = var.vpc_cidr
  vpc_name           = var.vpc_name
  public_subnet_cidrs = var.public_subnet_cidrs
  availability_zones = var.availability_zones
}

module "alb" {
  source = "./modules/alb"

  lb_name            = var.lb_name
  security_groups    = [module.networking.alb_security_group_id] # Reference the security group from networking
  subnet_ids         = module.networking.public_subnets
  target_group_name  = var.target_group_name
  target_port        = var.target_port
  vpc_id             = module.networking.vpc_id
  health_check_path  = var.health_check_path
}

module "ecs" {
  source = "./modules/ecs"

  cluster_name           = "assessment-cluster"
  task_family            = "assessment-task"
  container_definitions  = <<DEFINITION
  [
    {
      "name": "server-time-api",
      "image": "your-docker-image-url",
      "cpu": 256,
      "memory": 512,
      "essential": true,
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ]
    }
  ]
  DEFINITION
  task_cpu               = "256"
  task_memory            = "512"
  execution_role_arn     = "arn:aws:iam::your-account-id:role/ecsTaskExecutionRole"
  service_name           = "server-time-service"
  desired_count          = 1
  subnet_ids             = module.networking.public_subnets
  service_security_group_id = module.networking.alb_security_group_id
  target_group_arn       = module.alb.target_group_arn
  container_name         = "server-time-api"
  container_port         = 80
}

