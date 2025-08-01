resource "aws_lambda_function" "lambda_function" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = var.function_name
  role          = var.role
  handler       = var.handler
  source_code_hash = filebase64sha256(data.archive_file.lambda_zip.output_path)
  runtime = var.runtime
  publish = true
}

resource "aws_lambda_alias" "lambda_alias" {
  name = var.lambda_alias_name
  function_name = aws_lambda_function.lambda_function.function_name
  function_version = var.function_version != null ? var.function_version : aws_lambda_function.lambda_function.version
  }