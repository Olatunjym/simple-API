variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "task_family" {
  description = "Family name of the ECS task"
  type        = string
}

variable "container_definitions" {
  description = "JSON definition of ECS containers"
  type        = string
}

variable "task_cpu" {
  description = "CPU allocation for the ECS task"
  type        = string
}

variable "task_memory" {
  description = "Memory allocation for the ECS task"
  type        = string
}

variable "execution_role_arn" {
  description = "ARN of the IAM role for ECS task execution"
  type        = string
}

variable "service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "desired_count" {
  description = "Number of desired ECS service instances"
  type        = number
}

variable "subnet_ids" {
  description = "List of subnet IDs for ECS tasks"
  type        = list(string)
}

variable "service_security_group_id" {
  description = "Security group ID for ECS tasks"
  type        = string
}

variable "target_group_arn" {
  description = "Target group ARN for the ECS service"
  type        = string
}

variable "container_name" {
  description = "Name of the container in the ECS task"
  type        = string
}

variable "container_port" {
  description = "Port of the container in the ECS task"
  type        = number
}
