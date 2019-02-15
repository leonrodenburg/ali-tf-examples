# Alibaba Cloud Terraform examples

Collection of Terraform templates to get up and running in Alibaba Cloud in just a few minutes.

To use any of the examples, `cd` into the directory and run the following:

```sh
export ALICLOUD_ACCESS_KEY="<your access key>"
export ALICLOUD_SECRET_KEY="<your access key secret>"
export ALICLOUD_REGION="<preferred region>"

terraform init
terraform apply
```

This will set the variables, initialize any plugins needed and calculate the changes Terraform will make in your account.
To agree with the changes, type `yes` and press Enter.
