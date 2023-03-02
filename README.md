# Dependencies:

* Mysql
* Git
* Terraform
* AzureCLI


# Deployment process:

## Confidential setup

cd confidential/infrastructure
terraform init -backend-config="Conf.tfbackend"
terraform plan -out main.tfplan
terraform apply "main.tfplan"

**Wait until resources are created in azure as well as visible to azures CLI before running the next commands**

cd confidential/deployment
terraform init -backend-config="Conf.tfbackend"
terraform plan -out main.tfplan
terraform apply "main.tfplan"

## Non-Confidential setup

cd non-confidential/infrastructure
terraform init -backend-config="nonConf.tfbackend"
terraform plan -out main.tfplan
terraform apply "main.tfplan"

**Wait until resources are created in azure as well as visible to azures CLI before running the next commands**

cd non-confidential/deployment
terraform init -backend-config="nonConf.tfbackend"
terraform plan -out main.tfplan
terraform apply "main.tfplan"


## Cleanup infrastructure:

**To clean up your infrastructure just run the following command in the same path as where you initialized terraform**
terraform destroy -auto-approve