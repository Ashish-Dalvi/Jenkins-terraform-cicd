terraform{
    backend "s3"{
        bucket          = "ashu-terraform-state-bucket-backend"
        key             = "terraform.tfstate"
        region          = var.aws_region
        dynamodb_table  = "ashu-terraform-state-lock"
        encrypt         = "true"
    }
}