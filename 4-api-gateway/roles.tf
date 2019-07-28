# ---------------
# RAM role for API Gateway to get access to Function Compute
# ---------------
resource "alicloud_ram_role" "apigw-fc-access-role" {
  name = "apigw-fc-access-role"
  document = <<EOF
    {
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Effect": "Allow",
          "Principal": {
            "Service": [
              "apigateway.aliyuncs.com"
            ]
          }
        }
      ],
      "Version": "1"
    }
  EOF
  description = "Role that allows API Gateway to access FC"
  force = true
}

resource "alicloud_ram_role_policy_attachment" "apigw-fc-access-role-attachment" {
  role_name = alicloud_ram_role.apigw-fc-access-role.name
  policy_name = "AliyunApiGatewayAccessingFCRolePolicy"
  policy_type = "System"
}

# ---------------
# RAM role for Function Compute to access Log Service
# ---------------
resource "alicloud_ram_role" "apigw-fc-logs-role" {
  name = "apigw-fc-logs-role"
  document = <<EOF
    {
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Effect": "Allow",
          "Principal": {
            "Service": [
              "fc.aliyuncs.com"
            ]
          }
        }
      ],
      "Version": "1"
    }
    EOF
  description = "Role that allows Function Compute to access Log Service"
  force = true
}

resource "alicloud_ram_role_policy_attachment" "apigw-fc-logs-role-attachment" {
  role_name = alicloud_ram_role.apigw-fc-logs-role.name
  policy_name = "AliyunLogFullAccess"
  policy_type = "System"
}