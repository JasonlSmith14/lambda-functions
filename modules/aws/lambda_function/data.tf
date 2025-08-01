data "archive_file" "lambda_zip" {
    type = "zip"
    source_file = var.source_file
    output_path = var.output_path
}