variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "bucket_name" {
  description = "S3 bucket name for resume website"
  type        = string
}

variable "lambda_function_name" {
  description = "Lambda Function Name"
  type        = string
}

variable "api_name" {
  description = "HTTP API Name"
  type        = string
}