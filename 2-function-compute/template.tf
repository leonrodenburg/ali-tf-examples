resource "alicloud_fc_service" "fc_service" {
  name = "test-service"
}

resource "random_id" "postfix" {
  byte_length = 4
}

data "archive_file" "source" {
  type        = "zip"
  source_file = "${path.module}/src/index.js"
  output_path = "${path.module}/dist/alicloud-test-${random_id.postfix.b64_url}.zip"
}

resource "alicloud_fc_function" "fc_function" {
  service  = alicloud_fc_service.fc_service.name
  name     = "test-function"
  filename = "./dist/alicloud-test-${random_id.postfix.b64_url}.zip"
  runtime  = "nodejs8"
  handler  = "index.handler"
}

resource "alicloud_fc_trigger" "fc_trigger" {
  service  = alicloud_fc_service.fc_service.name
  function = alicloud_fc_function.fc_function.name
  name     = "test-http-trigger"
  type     = "http"
  config   = "{ \"methods\": [\"GET\"], \"authType\": \"anonymous\" }"
}
