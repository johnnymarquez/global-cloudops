terraform {
  backend "s3" {
    bucket         = "my-tf-state-johnny"
    key            = "multi-region/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
