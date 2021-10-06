variable public_key_location {}
variable "custom_input" {
    type = number
    description = "Choose 1-AWS \n 2-AZURE \n 3-GCP \n 4- AWS + AZURE \n 5- AWS + GCP \n 6- AZURE + GCP \n 7- AWS + AZURE +"
}
variable private_key_location {}
variable user{}
variable prefix {
    description = "The prefix which should be used for all resources in this example"
    default = "narahari"
}
variable project {
    description = "Specify Project Name"
}
variable region {
    description =" Specify Region"
}