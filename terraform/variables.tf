# ==========================================
# AWS Configuration
# ==========================================

variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "aws-3tier-terraform"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}


# ==========================================
# VPC
# ==========================================

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}


# ==========================================
# Public Subnets - Web Tier
# ==========================================

variable "public_subnet_1_cidr" {
  description = "CIDR block for public subnet 1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for public subnet 2"
  type        = string
  default     = "10.0.2.0/24"
}


# ==========================================
# Private Subnets - Application Tier
# ==========================================

variable "private_app_subnet_1_cidr" {
  description = "CIDR block for private application subnet 1"
  type        = string
  default     = "10.0.11.0/24"
}

variable "private_app_subnet_2_cidr" {
  description = "CIDR block for private application subnet 2"
  type        = string
  default     = "10.0.12.0/24"
}


# ==========================================
# Private Subnets - Database Tier
# ==========================================

variable "private_db_subnet_1_cidr" {
  description = "CIDR block for private database subnet 1"
  type        = string
  default     = "10.0.21.0/24"
}

variable "private_db_subnet_2_cidr" {
  description = "CIDR block for private database subnet 2"
  type        = string
  default     = "10.0.22.0/24"
}


# ==========================================
# Availability Zones
# ==========================================

variable "availability_zone_1" {
  description = "Availability Zone 1"
  type        = string
  default     = "ap-south-1a"
}

variable "availability_zone_2" {
  description = "Availability Zone 2"
  type        = string
  default     = "ap-south-1b"
}
