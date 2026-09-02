terraform{
    backend "s3"{
        bucket = "ashu-terraform-state-bucket-backend"
        key = "terraform.tfstate"
        region = "us-east-1"
        use_lockfile = "true"
    }
}