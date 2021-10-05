
module "aws_cust" {
    source = "./modules/aws"
    public_key_location = var.public_key_location
    private_key_location = var.private_key_location
    user = var.user
    prefix = var.prefix
    number_of_instances = var.custom_input == 1 || var.custom_input == 3 ? 1 : 0
}

module "azure_cust" {
    source = "./modules/azure"
    public_key_location = var.public_key_location
    private_key_location = var.private_key_location
    user = var.user
    prefix = var.prefix
    number_of_instances = var.custom_input == 2 || var.custom_input == 3 ? 1 : 0
}