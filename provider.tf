terraform {
  required_version = "~> 1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.38"
    }
  }
  cloud {
    organization = "xquare"
    workspaces {
      name = "dsm"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}