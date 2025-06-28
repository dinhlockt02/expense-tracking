# Terraform Project

This Terraform project manages infras of expense-tracking project.

## Usage

```bash
# Initialize
terraform init

# Plan changes
terraform plan

# Apply changes
make apply-dev

# Destroy resources
terraform destroy
```

## Structure

- `main.tf` - Main resource definitions
- `variables.tf` - Input variable declarations
- `outputs.tf` - Output declarations
- `terraform.tfvars` - Variable values
- `providers.tf` - Provider configurations
- `/environments` - Environment-specific configurations
- `/modules` - Reusable Terraform modules
