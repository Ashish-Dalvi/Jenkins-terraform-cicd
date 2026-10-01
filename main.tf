provider "aws" {
    region = "us-east-1"  
}

resource "aws_vpc" "dev_vpc" {
    cidr_block = "10.0.0.0/16"
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