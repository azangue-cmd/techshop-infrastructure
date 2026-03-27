terraform {
  backend "s3" {
    bucket = "techshop-terraform-state-angelo"
    key    = "global/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    # dynamodb_table = "terraform-locks"   <-- comment this
  }
}
