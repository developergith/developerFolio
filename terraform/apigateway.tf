resource "aws_apigatewayv2_api" "visitor_api" {
  name          = var.api_name
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = ["*"]
    allow_methods = ["GET"]
    allow_headers = ["*"]
  }
}

resource "aws_apigatewayv2_integration" "lambda" {
  api_id = aws_apigatewayv2_api.visitor_api.id

  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.visitor_counter.invoke_arn
  integration_method     = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "visitor" {
  api_id = aws_apigatewayv2_api.visitor_api.id

  route_key = "GET /visitor"

  target = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id = aws_apigatewayv2_api.visitor_api.id

  name = "$default"

  auto_deploy = true
}

resource "aws_lambda_permission" "api" {
  statement_id = "AllowExecutionFromAPIGateway"

  action = "lambda:InvokeFunction"

  function_name = aws_lambda_function.visitor_counter.function_name

  principal = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.visitor_api.execution_arn}/*/*"
}