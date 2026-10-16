provider "aws" {
    region = var.aws_region
}
# ---------------------------------------------------------------------------
# VPC
# ---------------------------------------------------------------------------
resource "aws_vpc" "dev_vpc" {
    cidr_block          = "10.0.0.0/16"
    //instance_tenancy    = "default"
    tags = {
        Name = "dev_vpc"
    }
}
# ---------------------------------------------------------------------------
# Internet Gateway (public subnet)
# ---------------------------------------------------------------------------
resource "aws_internet_gateway" "dev_igw" {
    vpc_id = aws_vpc.dev_vpc.id
    tags = {
        Name = "dev_igw"
    }
}


# ---------------------------------------------------------------------------
# Public Subnets
# ---------------------------------------------------------------------------
resource "aws_subnet" "dev_public_subnet" {
    vpc_id       = aws_vpc.dev_vpc.id
    cidr_block = "10.1.1.0/24"
    tags = {
        Name = "dev_public_subnet"
    }
}

# ---------------------------------------------------------------------------
# Private Subnets
# ---------------------------------------------------------------------------
resource "aws_subnet" "dev_private_subnet" {
    vpc_id       = aws_vpc.dev_vpc.id
    cidr_block = "10.1.2.0/24"
    tags = {
        Name = "dev_private_subnet"
    }
}

//data "aws_ami" "myimage" {
//  most_recent = true
//  owners      = ["amazon"] # Canonical
//    filter {
//        name   = "name"
//        values = ["al2023-ami-2023.12.20260622.0-kernel*"]
//    }
//}

//resource "aws_instance" "web" {
//  ami           = data.aws_ami.myimage.id
//  instance_type = "t2.micro"
//  tags = {
//      Name = "TF-Instance"
//  }
//}