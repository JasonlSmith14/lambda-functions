locals {
  root = read_terragrunt_config(find_in_parent_folders("root.hcl"))
  }

dependency "role" {
  config_path = "../../roles/hello_world"
}
terraform {
    source = "../../../../modules/aws/lambda_function"
}

# You can also specify the function_version. Defaults to the latest
inputs = {
    source_file = "/home/jason-leighsmith/Projects/lambda-functions/base/lambda-functions/python/hello_world/app.py"
    output_path = "hello_world.zip"
    function_name = "${local.root.locals.base_component_name}-hello-world"
    role = dependency.role.outputs.role_arn
    handler = "app.lambda_handler"
    runtime = "python3.8"
    lambda_alias_name = local.root.locals.environment
}