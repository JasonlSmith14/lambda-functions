include "base" {
  path = find_in_parent_folders("base/lambda-functions/roles/hello_world/terragrunt.hcl")
  merge_strategy = "deep"
}