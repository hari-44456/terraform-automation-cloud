provider "aws" {
    region = "us-east-2"
    // if not specified here then we have to set it via ennvironment variable or run aws configure
    # access_key = ""
    # secret_key = ""
}

provider "azurerm" {
  // run az login 
  features {}
}

provider "google" {
  // run gcloud auth application-default login
  project = var.project
  region  = var.region
  zone =  "${var.region}-a"
}