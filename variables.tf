variable "common" {
  type = object({
    project     = string
    region      = string
    prefix      = string
    zone        = string
    environment = string
    domain      = string
  })
  description = "Common variables for all environments"
}


variable "cloud_run" {
  type = object({
    cpu    = string
    memory = string
    name   = string
  })
  default = {
    cpu    = "1"
    memory = "512Mi"
    name   = "cloud-run-service"
  }
}


variable "storage" {
  type = object({
    location = string
  })
}

variable "sql" {
  type = object({
    database = string
    password = string
    user     = string
  })
}

variable "github_repositories" {
  description = "List of GitHub repositories in the format owner/repo"
  type        = list(string)
}

