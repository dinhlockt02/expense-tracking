.PHONY: init plan-dev apply-dev destroy-dev

init: 
	terraform init

plan-dev:
	terraform plan -var-file=env/dev/terraform.tfvars

apply-dev:
	terraform apply -var-file=env/dev/terraform.tfvars -auto-approve

destroy-dev:
	terraform destroy -var-file=env/dev/terraform.tfvars -auto-approve
