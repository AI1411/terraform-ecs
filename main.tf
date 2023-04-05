terraform {
  backend "s3" {
    bucket         = "ai1411-aws-ecs-tf-state"
    key            = "terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "aws-ecs-terraform-tfstate-locking"
    encrypt        = true
  }
}