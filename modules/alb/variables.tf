variable "lb_name" {
  description = "Name of the ALB"
  type        = string
}

variable "security_groups" {
  description = "List of security groups for the ALB"
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ALB"
  type        = list(string)
}

variable "target_group_name" {
  description = "Name of the target group"
  type        = string
}

variable "target_port" {
  description = "Port for the target group"
  type        = number
}

variable "vpc_id" {
  description = "ID of the VPC where the ALB is deployed"
  type        = string
}

variable "health_check_path" {
  description = "Path for health checks"
  type        = string
}
