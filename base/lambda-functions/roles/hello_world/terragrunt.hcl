locals {
  root = read_terragrunt_config(find_in_parent_folders("root.hcl"))
}

terraform {
  source = "../../../../modules/aws/iam_role"
}

inputs = {
  role_name        = "${local.root.locals.base_component_name}-hello-world-role"
  role_description = "The role for the 'Hello World' lambda function"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  policy_name        = "${local.root.locals.base_component_name}-hello-world-policy"
  policy_description = "The policy for the 'Hello World' lambda function"

  policy_content = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    }
  ]
}
EOF
}
