# Alibaba Cloud Terraform examples

Collection of Terraform templates to get up and running in Alibaba Cloud in just a few minutes.

## Prerequisites

You need to have Terraform installed to deploy the examples. See the [Terraform documentation](https://learn.hashicorp.com/terraform/getting-started/install.html) for
guidance on how to get it on your machine. If you are on macOS and use Homebrew, you can install Terraform using `brew install terraform`.

## Deploy an example

To use any of the examples, `cd` into the directory and run the following:

```sh
terraform init
terraform apply
```

This will install the necessary providers and plugins, ask you for your Alibaba Cloud access key, secret access key and region, and finally show you the deployment plan.
The necessary keys can be created in the Alibaba Cloud console under [AccessKey](https://usercenter.console.aliyun.com/#/manage/ak) in the dropdown menu under your avatar. For a list of regions, [click here](https://www.alibabacloud.com/help/doc-detail/40654.htm).

When Terraform shows you the plan, type `yes` and press Enter to create the new resources.

## Persisting configuration

To set your access keys in a more permanent manner, you can add a `terraform.tfvars` file in the template directory, with the following contents:

```
access_key = "<your access key>"

secret_key = "<your access key secret>"

region = "<preferred region>"
```

This will save you from specifying the values every time you open a new shell. Alternatively, you could set these parameters using environment variables. More info can be found [here](https://www.terraform.io/docs/providers/alicloud/index.html#environment-variables).
