provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

module "IAM" {
  source   = "./modules/IAM"

  name_prefix = var.name-prefix
}






