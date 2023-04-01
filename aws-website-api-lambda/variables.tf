
# -----------------
# REQUIRED
# -----------------

variable "prefix" {
    description = "Tag all resource names with this prefix. This helps easy identification of the stack"
    type    = string
}

# -----------------
# OPTIONAL
# -----------------

variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
  default     = {
    Environment = "production"
  }
}
