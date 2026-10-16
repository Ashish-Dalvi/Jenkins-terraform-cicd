terraform{
    backend "s3"{
        bucket          = "ashu-terraform-state-bucket-backend"
        key             = "terraform.tfstate"
        region          = "var.aws_region"
        use_lockfile    = true
        encrypt         = "true"
        //"ashu-terraform-state-lock"
    }
}