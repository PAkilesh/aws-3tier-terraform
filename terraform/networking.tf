# ==========================================
# VPC
# ==========================================

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.project_name}-vpc"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}


# ==========================================
# Internet Gateway
# ==========================================

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.project_name}-igw"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}


# ==========================================
# PUBLIC SUBNET 1 - AZ 1
# ==========================================

resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_1_cidr
  availability_zone       = var.availability_zone_1
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project_name}-public-subnet-1"
    Environment = var.environment
    Tier        = "Public"
    ManagedBy   = "Terraform"
  }
}


# ==========================================
# PUBLIC SUBNET 2 - AZ 2
# ==========================================

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_2_cidr
  availability_zone       = var.availability_zone_2
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project_name}-public-subnet-2"
    Environment = var.environment
    Tier        = "Public"
    ManagedBy   = "Terraform"
  }
}


# ==========================================
# PRIVATE APPLICATION SUBNET 1 - AZ 1
# ==========================================

resource "aws_subnet" "private_app_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_app_subnet_1_cidr
  availability_zone = var.availability_zone_1

  tags = {
    Name        = "${var.project_name}-private-app-subnet-1"
    Environment = var.environment
    Tier        = "Application"
    ManagedBy   = "Terraform"
  }
}


# ==========================================
# PRIVATE APPLICATION SUBNET 2 - AZ 2
# ==========================================

resource "aws_subnet" "private_app_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_app_subnet_2_cidr
  availability_zone = var.availability_zone_2

  tags = {
    Name        = "${var.project_name}-private-app-subnet-2"
    Environment = var.environment
    Tier        = "Application"
    ManagedBy   = "Terraform"
  }
}


# ==========================================
# PRIVATE DATABASE SUBNET 1 - AZ 1
# ==========================================

resource "aws_subnet" "private_db_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_db_subnet_1_cidr
  availability_zone = var.availability_zone_1

  tags = {
    Name        = "${var.project_name}-private-db-subnet-1"
    Environment = var.environment
    Tier        = "Database"
    ManagedBy   = "Terraform"
  }
}


# ==========================================
# PRIVATE DATABASE SUBNET 2 - AZ 2
# ==========================================

resource "aws_subnet" "private_db_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_db_subnet_2_cidr
  availability_zone = var.availability_zone_2

  tags = {
    Name        = "${var.project_name}-private-db-subnet-2"
    Environment = var.environment
    Tier        = "Database"
    ManagedBy   = "Terraform"
  }
}


# ==========================================
# PUBLIC ROUTE TABLE
# ==========================================

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "${var.project_name}-public-route-table"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}


# ==========================================
# PUBLIC ROUTE TABLE ASSOCIATION - SUBNET 1
# ==========================================

resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}


# ==========================================
# PUBLIC ROUTE TABLE ASSOCIATION - SUBNET 2
# ==========================================

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}


# ==========================================
# PRIVATE APPLICATION ROUTE TABLE - AZ 1
# ==========================================

resource "aws_route_table" "private_app_1" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.project_name}-private-app-route-table-1"
    Environment = var.environment
    Tier        = "Application"
    ManagedBy   = "Terraform"
  }
}


# ==========================================
# PRIVATE APPLICATION ROUTE TABLE - AZ 2
# ==========================================

resource "aws_route_table" "private_app_2" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.project_name}-private-app-route-table-2"
    Environment = var.environment
    Tier        = "Application"
    ManagedBy   = "Terraform"
  }
}


# ==========================================
# PRIVATE APPLICATION ROUTE TABLE ASSOCIATION - AZ 1
# ==========================================

resource "aws_route_table_association" "private_app_1" {
  subnet_id      = aws_subnet.private_app_1.id
  route_table_id = aws_route_table.private_app_1.id
}


resource "aws_route_table_association" "private_app_2" {
  subnet_id      = aws_subnet.private_app_2.id
  route_table_id = aws_route_table.private_app_2.id
}



resource "aws_route_table" "private_db_1" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.project_name}-private-db-route-table-1"
    Environment = var.environment
    Tier        = "Database"
    ManagedBy   = "Terraform"
  }
}


# ==========================================
# PRIVATE DATABASE ROUTE TABLE - AZ 2
# ==========================================

resource "aws_route_table" "private_db_2" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.project_name}-private-db-route-table-2"
    Environment = var.environment
    Tier        = "Database"
    ManagedBy   = "Terraform"
  }
}


# ==========================================
# PRIVATE DATABASE ROUTE TABLE ASSOCIATION - AZ 1
# ==========================================

resource "aws_route_table_association" "private_db_1" {
  subnet_id      = aws_subnet.private_db_1.id
  route_table_id = aws_route_table.private_db_1.id
}


# ==========================================
# PRIVATE DATABASE ROUTE TABLE ASSOCIATION - AZ 2
# ==========================================

resource "aws_route_table_association" "private_db_2" {
  subnet_id      = aws_subnet.private_db_2.id
  route_table_id = aws_route_table.private_db_2.id
} # ==========================================
# PRIVATE DATABASE ROUTE TABLE - AZ 1
# ==========================================
# ==========================================
# PRIVATE APPLICATION ROUTE TABLE ASSOCIATION - AZ 2
# ==========================================

# ==========================================
# Private Application Route - AZ 1
# ==========================================

resource "aws_route" "private_app_1_nat" {
  route_table_id         = aws_route_table.private_app_1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}


# ==========================================
# Private Application Route - AZ 2
# ==========================================

resource "aws_route" "private_app_2_nat" {
  route_table_id         = aws_route_table.private_app_2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}
