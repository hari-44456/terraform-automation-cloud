variable public_key_location {
    description = "Specify location for your public key generated via (ssh-keygen)"
}
variable "custom_input" {
    type = number
    description = "Choose \n 1-AWS \n 2-AZURE \n 3-GCP \n 4- AWS + AZURE \n 5- AWS + GCP \n 6- AZURE + GCP \n 7- AWS + AZURE + GCP"
}
variable private_key_location {
    description = "Specify location for your private key generated via (ssh-keygen)"
}
variable user {
    description = "Specify user's name that will be used for creating VM's"
}
variable prefix {
    description = "The prefix which should be used for all resources"
}
variable project {
    description = "Specify Project Id in GCP..This project should have active billing and should have enabled compute API"
}
variable region {
    description =" Specify Region"
}
variable vpc_cidr_block {
    description = "Specify vpc cidr block"
    default = "10.0.0.0/16"
}

variable subnet_cidr_block {
    description = "Specify subnet cidr block"
    default = "10.0.10.0/24"
}