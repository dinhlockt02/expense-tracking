variable "function_name" {
}
variable "handler" {
  default = "main"
}

variable "filename" {
}

variable "timeout" {
  default = 3
}
variable "memory_size" {
  default = 128
}

variable "code_signing_config_arn" {
  description = "ARN of the Code Signing Config for the Lambda function"
  type        = string
  default     = null
}
