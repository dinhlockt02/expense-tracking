.PHONY: apply

apply:
	terraform apply -auto-approve

apply-dev:
	# destroy existing resources in dev environment
	terraform destroy -var-file=env/dev/terraform.tfvars -auto-approve || true
	terraform apply -var-file=env/dev/terraform.tfvars -auto-approve
