.PHONY: init plan-dev apply-dev destroy-dev

init: 
	terraform init

plan-dev: init
	terraform plan -var-file=env/dev/terraform.tfvars

apply-dev: init
	terraform apply -var-file=env/dev/terraform.tfvars -auto-approve

destroy-dev: init
	terraform destroy -var-file=env/dev/terraform.tfvars -auto-approve
