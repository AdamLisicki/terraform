terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "7.7.0"
    }
  }

  backend "remote" {
    organization = "OCI-infra"
    hostname     = "app.terraform.io"

    workspaces {
      name = "terraform"
    }
  }
}


provider "oci" {
  tenancy_ocid = var.tenancy_ocid
  user_ocid    = var.user_ocid
  fingerprint  = var.fingerprint
  private_key = replace(var.private_key, "\\n", "\n")
  region       = var.region
}