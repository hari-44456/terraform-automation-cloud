variable public_key_location {}
variable "custom_input" {
    type = number
    description = "Choose 1 for AWS 2 for AZURE 3 for Both(AWS,AZURE)"
}
variable private_key_location {}
variable user{}
variable prefix {
    description = "The prefix which should be used for all resources in this example"
    default = "dev"
}