terraform {
  backend "s3" {
    bucket = "sctp-ce9-tfstate"        # This is an existing bucket to store terraform tfstate file
    key    = "ws-ecr-ecs.tfstate"      # Replace the value of key to <your suggested name>.tfstate 
    region = "us-east-1"
  }
}