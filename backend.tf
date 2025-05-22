terraform {
  backend "s3" {
    bucket = "weather-app-backend-state-bucket"
    key    = "weatherapp_backend_state.tfstate"
    region = "us-east-2"
    dynamodb_table = "weather-app-dynamoDB-table"
  }
}