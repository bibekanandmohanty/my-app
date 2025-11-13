terraform {
  backend "gcs" {
    bucket = "tfstate-gitops-testing-478006"  # replace with your bucket
    prefix = "state/dev"                  # isolates dev environment
  }
}

