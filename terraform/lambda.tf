data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda/index.mjs"
  output_path = "${path.module}/lambda/visitor-counter.zip"
}

resource "aws_lambda_function" "visitor_counter" {

  function_name = var.lambda_function_name

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  role    = aws_iam_role.lambda_role.arn
  handler = "index.handler"

  runtime = "nodejs22.x"

  timeout = 10

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.visitor_count.name
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_basic,
    aws_iam_role_policy_attachment.dynamodb_access
  ]
}