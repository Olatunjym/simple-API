
---

### **README.md**

```markdown
# AWS ECS Deployment with Terraform

This project provisions infrastructure on AWS to deploy a simple API using **Elastic Container Service (ECS)** with **Terraform**. The setup is fully modularized, making it reusable and easy to maintain.

## **Project Structure**

```
terraform/
├── modules/
│   ├── networking/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── alb/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── ecs/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
└── README.md
```

## **Modules**

### **1. Networking**
- **Resources Created**:
  - VPC
  - Public Subnets
  - Internet Gateway
  - Route Table
  - Security Group for ALB
- **Inputs**:
  - `vpc_cidr`: CIDR block for the VPC.
  - `vpc_name`: Name of the VPC.
  - `public_subnet_cidrs`: CIDR blocks for the public subnets.
  - `availability_zones`: Availability zones for the subnets.

### **2. Application Load Balancer (ALB)**
- **Resources Created**:
  - Application Load Balancer.
  - Target Group for ECS service.
  - Listener for port 80.
- **Inputs**:
  - `lb_name`: Name of the load balancer.
  - `security_groups`: Security group for the ALB (referenced dynamically from networking).
  - `subnet_ids`: Subnets where the ALB will be deployed.
  - `target_group_name`: Name of the target group.
  - `target_port`: Port for the target group.
  - `health_check_path`: Health check path for the ALB.

### **3. ECS**
- **Resources Created**:
  - ECS Cluster.
  - ECS Task Definition.
  - ECS Service.
- **Inputs**:
  - `cluster_name`: Name of the ECS cluster.
  - `task_family`: Task family name.
  - `container_definitions`: JSON configuration for containers.
  - `task_cpu` and `task_memory`: Resources for the task.
  - `execution_role_arn`: IAM role for ECS tasks.
  - `service_name`: Name of the ECS service.
  - `desired_count`: Number of ECS task instances.
  - `target_group_arn`: ALB target group ARN.
  - `container_name` and `container_port`: Container configuration.

## **How to Deploy**

### **1. Prerequisites**
- Install [Terraform](https://developer.hashicorp.com/terraform/downloads) (v1.0 or later).
- AWS credentials configured in your environment (e.g., `~/.aws/credentials`).
- An existing IAM role for ECS task execution with required policies:
  - **AmazonECSTaskExecutionRolePolicy**

### **2. Steps to Deploy**
1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd terraform
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Validate the configuration:
   ```bash
   terraform validate
   ```

4. Plan the deployment:
   ```bash
   terraform plan -var-file="terraform.tfvars"
   ```

5. Apply the configuration:
   ```bash
   terraform apply -var-file="terraform.tfvars" -auto-approve
   ```

### **3. Access the API**
1. Copy the ALB DNS name from the Terraform output:
   ```plaintext
   alb_dns_name = "<your-alb-dns-name>"
   ```

2. Access the API in your browser or with `curl`:
   ```bash
   curl http://<your-alb-dns-name>
   ```

## **How to Customize**
To customize the infrastructure:
1. Update the variables in `terraform.tfvars`.
2. Add your Docker image URL to the `container_definitions` in `terraform.tfvars`.

## **Cleaning Up**
To destroy all resources:
```bash
terraform destroy -var-file="terraform.tfvars" -auto-approve
```

## **Notes**
- All Terraform modules are modularized for reusability.
- No hardcoded values; everything is configurable through variables.
- IAM role for ECS tasks must be created beforehand.

## **Limitations**
This setup assumes:
1. The IAM role (`execution_role_arn`) for ECS tasks is pre-created.
2. The Docker image is publicly available or accessible via proper IAM permissions.

```