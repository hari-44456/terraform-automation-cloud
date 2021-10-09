
module "aws_cust" {
    source = "./modules/aws"
    public_key_location = var.public_key_location
    private_key_location = var.private_key_location
    user = var.user
    prefix = var.prefix
    vpc_cidr_block = var.vpc_cidr_block
    subnet_cidr_block = var.subnet_cidr_block
    avail_zone = "us-east-2a"
    number_of_instances = var.custom_input == 1 || var.custom_input == 4 || var.custom_input == 5 || var.custom_input == 7  ? 1 : 0
}

module "azure_cust" {
    source = "./modules/azure"
    public_key_location = var.public_key_location
    private_key_location = var.private_key_location
    user = var.user
    prefix = var.prefix
    number_of_instances = var.custom_input == 2 || var.custom_input == 4 || var.custom_input == 6 || var.custom_input == 7  ? 1 : 0
}

module "gcp_cust" {
    source = "./modules/gcp"
    project = var.project
    region = var.region
    public_key_location = var.public_key_location
    private_key_location = var.private_key_location
    user = var.user
    prefix = var.prefix
    number_of_instances = var.custom_input == 3 || var.custom_input == 5 || var.custom_input == 6 || var.custom_input == 7  ? 1 : 0

}