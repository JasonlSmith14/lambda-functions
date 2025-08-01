locals {
  original_directory = get_original_terragrunt_dir()
  relative_path = trimprefix(local.original_directory, "${get_repo_root()}/")
  environment         = split("/", local.relative_path)[0]
  application_name    = split("/", local.relative_path)[1]
  base_component_name = "${local.environment}-${local.application_name}"
  profile             = "iac"
  region              = "af-south-1"
}

remote_state {
  backend = "s3"
  config = {
    bucket         = "terraform-state-${local.environment}"
    key            = "${local.relative_path}/terraform.tfstate"
    region         = local.region
    encrypt        = true
    dynamodb_table = "terraform-locks-${local.environment}"
  }
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
  terraform {
    backend "s3" {}
  }
EOF
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "aws" {
  region  = "${local.region}"
  profile = "${local.profile}"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.97.0"
    }
  }
}
EOF
}
