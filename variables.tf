variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability zones for the subnets"
  type        = list(string)
}

variable "lb_name" {
  description = "Name of the load balancer"
  type        = string
}

variable "target_group_name" {
  description = "Name of the target group for the ALB"
  type        = string
}

variable "target_port" {
  description = "Port for the target group"
  type        = number
}

variable "health_check_path" {
  description = "Path for health checks on the target group"
  type        = string
}

variable "execution_role_arn" {
  description = "IAM execution role for ECS tasks"
  type        = string
}
