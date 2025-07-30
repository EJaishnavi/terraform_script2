terraform {
  backend "s3" {
    bucket = "terraformcode2025"
    key    = "terraform/statefile"
    region = "us-east-1"
  }
}
