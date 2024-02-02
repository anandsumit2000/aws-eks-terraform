terraform {
  required_version = "~>1.4.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.35.0"
    }
  }
  backend "s3" {
    bucket         = "aws_terraform_state_bucket"
    key            = "service/sftp/terraform.tfstate"
    encrypt        = true
    kms_key_id     = "alias/state-bucket-key"
    region         = "us-east-1"
    dynamodb_table = "terraform-state"
  }
}