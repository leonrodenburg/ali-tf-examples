# ---------------
# Logging & RAM role for log access
# ---------------
resource "alicloud_log_project" "apigw-logs-project" {
  name = "apigw-logs"
  description = "Logs for Lambda triggered by API Gateway"
}

resource "alicloud_log_store" "apigw-logs-store" {
  project = alicloud_log_project.apigw-logs-project.name
  name = "apigw-logs-store"
  shard_count = 1
}

# ---------------
# Function Compute service & function
# ---------------
resource "alicloud_fc_service" "apigw-fc-service" {
  name = "apigw-fc-service"
  role = alicloud_ram_role.apigw-fc-logs-role.arn

  log_config {
    project = alicloud_log_project.apigw-logs-project.name
    logstore = alicloud_log_store.apigw-logs-store.name
  }

  depends_on = [
    alicloud_ram_role_policy_attachment.apigw-fc-logs-role-attachment,
  ]
}

resource "alicloud_fc_function" "apigw-fc-test" {
  name = "apigw-fc-test"
  handler = "index.handler"
  runtime = "nodejs8"
  service = alicloud_fc_service.apigw-fc-service.name
  description = "Test function that is called by API Gateway"
  oss_bucket = alicloud_oss_bucket.apigw-fc-code.id
  oss_key = alicloud_oss_bucket_object.apigw-fc-code-test.key
}

# ---------------
# Function source code
# ---------------
resource "alicloud_oss_bucket" "apigw-fc-code" {
  bucket = "apigw-fc-code"
}

resource "alicloud_oss_bucket_object" "apigw-fc-code-test" {
  bucket = alicloud_oss_bucket.apigw-fc-code.id
  key = "apigw-fc-test.zip"
  source = "./dist/apigw-fc-test.zip"
}