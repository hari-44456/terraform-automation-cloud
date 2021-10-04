
module "aws_cust" {
    source = "./modules/aws"
    public_key_location = var.public_key_location
    number_of_instances = var.custom_input == 1 ? 1 : 0
}

module "azure_cust" {
    source = "./modules/azure"
    public_key_location = var.public_key_location
    number_of_instances = var.custom_input == 2 ? 1 : 0
}