terraform {
  required_version = ">= 1.16.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.69.1" # latest on 18/Oct/2026
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 3.3.0" # latest on 18/Oct/2026
    }
  }
}

provider "aws" {
  region = var.region
}

# Not used because we're running commands with `lstk terraform <command>`
# Left here just as reference if we were using `terraform <command>`  directly
# provider "aws" {
#   region                      = "us-east-1"
#   access_key                  = "mock_access_key"
#   secret_key                  = "mock_secret_key"
#   skip_credentials_validation = true
#   skip_metadata_api_check     = true
#   skip_requesting_account_id  = true

#   endpoints {
#     eks     = "http://localhost:4566"
#     iam     = "http://localhost:4566"
#     sts     = "http://localhost:4566"
#     ec2     = "http://localhost:4566"
#     vpc     = "http://localhost:4566"
#   }
# }

module "eks_cluster" {
  source = "./modules/eks-cluster"

  account_id   = var.account_id
  region       = var.region
  cluster_name = var.cluster_name
  namespaces   = var.namespaces
}
