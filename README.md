
# terraform-demos

Learn DevOps: Infrastructure Automation With Terraform.

## Requirements

- Terraform >= v0.12.9
- aws-cli >= 1.16.245

## Version

1.0.0

## Installation

Download zip file and extract it [latest pre-built release](https://github.com/reysmerwvr/terraform-demos). Or clone the repository and cd into it.

This project uses a number of open source projects to work properly:

- [Terraform] - Use Infrastructure as Code to provision and manage any cloud, infrastructure, or service

## Setup

Install terraform and aws-cli for your OS. [Terraform](https://www.terraform.io/downloads.html) [aws-cli](https://docs.aws.amazon.com/en_en/cli/latest/userguide/cli-chap-install.html) 

## Configuration
```sh
$ aws configure
AWS Access Key ID [None]: YOURAWSACCESSKEY
AWS Secret Access Key [None]: YOURAWSSECRETKEY
Default region name [None]: us-west-2
Default output format [None]: json
```

```sh
$ cd terraform-demos 
You should select the demo that you want to test for instance:
$ cd demo-1
$ touch terraform.tfvars
Add your AWS Credentials in this file (terraform.tfvars)
$ terraform init
$ terraform plan
$ terraform plan
$ terraform apply
$ terraform destroy
```

### Todos

- Add code comments

[//]: # "These are reference links used in the body of this note and get stripped out when the markdown processor does 
its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax"
[Terraform]: https://www.terraform.io/