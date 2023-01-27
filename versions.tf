terraform {
  required_version = ">= 0.13.0"
  
  backend "remote" {
    # The name of your Terraform Cloud organization.    
    organization = "ganesha87"
    
    # The name of the Terraform Cloud workspace to store Terraform state files in.
    workspaces {
      name = "Demo-AWSSSO-IdentityCenter"
    }
  }
}
