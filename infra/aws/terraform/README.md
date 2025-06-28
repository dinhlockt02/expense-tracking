# Terraform Project

This Terraform project manages infrastructure for the expense-tracking project.

## Usage

You can use the provided `Makefile` to simplify common Terraform commands:

### Initialize Terraform

```
make init
```

### Plan changes for the dev environment

```
make plan-dev
```

### Apply changes to the dev environment

```
make apply-dev
```

### Destroy resources in the dev environment

```
make destroy-dev
```

## Structure

- `main.tf` - Main resource definitions
- `variables.tf` - Input variable declarations
- `outputs.tf` - Output declarations
- `terraform.tfvars` - Variable values
- `providers.tf` - Provider configurations
- `/environments` - Environment-specific configurations
- `/modules` - Reusable Terraform modules
- `Makefile` - Common Terraform commands for convenience
