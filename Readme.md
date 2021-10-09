# Terraform-Ansible Automation


## Tech
- [Terraform](https://www.terraform.io/downloads.html){:target="_blank"}
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [AWS CLI](https://aws.amazon.com/cli/)
- [AZURE CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [GCP SDK](https://cloud.google.com/sdk/docs/install#linux)

## Installation
For AWS run following command and set ACCESS_KEY and  SECRET_ACCESS_KEY
```
aws configure
```

For AZURE run following command for login
 ```
az login
```

For GCP run following command 
```
gcloud init
gcloud auth application-default login
```

> Note: While selecting project make sure that billing is enabled and compute API ( API name- compute.googleapis.com) is enabled 

##  Run Application
```
Terraform init
Terraform apply
```



**Free Software, Hell Yeah!**

  