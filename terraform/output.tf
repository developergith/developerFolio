output "bucket_name" {
  value = aws_s3_bucket.resume_bucket.bucket
}

output "bucket_website_endpoint" {
  value = aws_s3_bucket_website_configuration.website.website_endpoint
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.visitor_count.name
}

output "lambda_role_name" {
  value = aws_iam_role.lambda_role.name
}

output "lambda_name" {
  value = aws_lambda_function.visitor_counter.function_name
}

output "lambda_arn" {
  value = aws_lambda_function.visitor_counter.arn
}

output "api_endpoint" {
  value = aws_apigatewayv2_stage.default.invoke_url
}