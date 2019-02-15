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

To set the variables, you can alternatively add a `terraform.tfvars` file in the template directory, with the following contents:

```
access_key = "<your access key>"

secret_key = "<your access key secret>"

region = "<preferred region>"
```

This will save you from setting the environment variables every time you open a new shell.

To agree with the changes Terraform proposes when running `terraform apply`, type `yes` and press Enter.
