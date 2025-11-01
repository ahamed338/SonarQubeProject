# Terraform Local Demo
# Terraform is an Infrastructure as Code (IaC) tool
# It lets you define infrastructure in code and manage it declaratively
#
# In this demo, we'll use:
# - Local provider: to create local files/resources
# - Docker provider: to simulate containerized infrastructure
#
# In real scenarios, you'd use providers like:
# - AWS (aws provider)
# - Google Cloud (google provider)
# - Azure (azurerm provider)
# - Kubernetes (kubernetes provider)

terraform {
  required_version = ">= 1.0"
  
  required_providers {
    # Local provider - creates local files (good for learning)
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
    
    # Docker provider - manages Docker containers
    # This simulates managing infrastructure with Terraform
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# Configure Docker provider
# Terraform needs to know how to connect to Docker
provider "docker" {
  host = "unix:///var/run/docker.sock"  # Docker socket (default on Mac/Linux)
}

# Example 1: Create a local file with Terraform
# This demonstrates Terraform's ability to manage resources
resource "local_file" "terraform_demo" {
  filename = "${path.module}/output.txt"
  content  = <<-EOT
    This file was created by Terraform!
    
    Terraform can manage:
    - Cloud infrastructure (AWS, GCP, Azure)
    - Kubernetes resources
    - Docker containers
    - Local files and scripts
    
    Created at: ${timestamp()}
    
    Learning Path:
    1. Define infrastructure in .tf files (like this one)
    2. Run: terraform init  (downloads providers)
    3. Run: terraform plan  (shows what will be created)
    4. Run: terraform apply (creates the infrastructure)
    5. Run: terraform destroy (removes everything)
  EOT
}

# Example 2: Pull a Docker image
# This simulates managing container images as infrastructure
resource "docker_image" "sonarqube" {
  name = "sonarqube:community"
  
  # This image would be used in a real deployment
  # In cloud scenarios, you'd manage:
  # - EC2 instances, ECS tasks, or Kubernetes nodes
  # - Load balancers
  # - Databases (RDS, Cloud SQL, etc.)
  # - Network configurations (VPCs, subnets, security groups)
}

# Example 3: Create a Docker container
# This demonstrates managing containers as infrastructure
resource "docker_container" "sonar_demo" {
  image = docker_image.sonarqube.image_id
  name  = "sonar-terraform-demo"
  
  # In real cloud infrastructure, you'd configure:
  # - Instance types and sizes
  # - Networking (public/private IPs)
  # - Security groups (firewall rules)
  # - Auto-scaling policies
  # - Backup and monitoring
  
  # For learning purposes, we'll keep this simple
  # In production, you'd use the Kubernetes provider to deploy to K8s
  # Or use ECS/Fargate providers for containerized workloads
  
  # Note: This is just for demonstration
  # In practice, you might not create containers directly
  # Instead, use Terraform to provision the infrastructure that runs containers
}

# Example 4: Output values
# Terraform outputs are useful for passing information between modules
# or displaying results after apply
output "docker_image_id" {
  description = "ID of the Docker image"
  value       = docker_image.sonarqube.image_id
}

output "local_file_path" {
  description = "Path to the created local file"
  value       = local_file.terraform_demo.filename
}

# Real-world Terraform examples:
#
# AWS Example (commented out - needs AWS credentials):
# resource "aws_instance" "web" {
#   ami           = "ami-0c55b159cbfafe1f0"
#   instance_type = "t2.micro"
#   
#   tags = {
#     Name = "DevOpsLearning"
#   }
# }
#
# Kubernetes Example (commented out - needs K8s cluster):
# resource "kubernetes_deployment" "app" {
#   metadata {
#     name = "my-app"
#   }
#   spec {
#     replicas = 2
#     selector {
#       match_labels = {
#         app = "my-app"
#       }
#     }
#     template {
#       metadata {
#         labels = {
#           app = "my-app"
#         }
#       }
#       spec {
#         container {
#           image = "nginx:latest"
#           name  = "nginx"
#         }
#       }
#     }
#   }
# }

