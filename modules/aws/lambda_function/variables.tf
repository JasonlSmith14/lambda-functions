variable "source_file" {
  type = string
}

variable "output_path" {
  type = string
}

variable "function_name" {
  type = string
}

variable "role" {
  type = string
}

variable "handler" {
  type = string
}

variable "runtime" {
  type = string
}

variable "function_version" {
  type = string
  default = null
}

variable "lambda_alias_name" {
  type = string
}