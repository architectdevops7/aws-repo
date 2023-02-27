# Required variables
variable "app_name" {
  type        = string
  description = "Name of the CodeDeploy application"
}

variable "deployment_group_name" {
  type        = string
  description = "Name of the CodeDeploy deployment group"
}

variable "lambda_function_name" {
  type        = string
  description = "Name of the Lambda function"
}

variable "s3_bucket_name" {
  type        = string
  description = "Name of the S3 bucket containing the Lambda function source code"
}

variable "s3_object_key" {
  type        = string
  description = "Key of the S3 object containing the Lambda function source code"
}

# Optional variables
variable "deployment_config_name" {
  type        = string
  default     = "CodeDeployDefault.LambdaAllAtOnce"
  description = "Name of the CodeDeploy deployment configuration to use"
}

variable "auto_rollback_enabled" {
  type        = bool
  default     = true
  description = "Whether to enable auto rollback on deployment failure"
}

variable "iam_role_name" {
  type        = string
  default     = "codedeploy-lambda-role"
  description = "Name of the IAM role to create for CodeDeploy to use with the Lambda function"
}

variable "iam_role_assume_policy" {
  type        = string
  default     = jsonencode({
    Version: "2012-10-17",
    Statement: [{
      Effect: "Allow",
      Principal: {
        Service: "codedeploy.amazonaws.com"
      },
      Action: "sts:AssumeRole"
    }]
  })
  description = "JSON policy document defining who can assume the IAM role for CodeDeploy to use with the Lambda function"
}

variable "iam_role_inline_policies" {
  type        = map(any)
  default     = {}
  description = "Map of JSON policy documents to attach as inline policies to the IAM role for CodeDeploy to use with the Lambda function"
}
