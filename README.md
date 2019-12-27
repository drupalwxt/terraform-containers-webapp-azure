# Terraform for Azure Web App for Containers

See the Terraform docs for the AzureRM App Service:

https://www.terraform.io/docs/providers/azurerm/r/app_service.html

## Security Controls

The following security controls can be met through configuration of this template:

* TBD

## Dependencies

* None

## Optional (depending on options configured):

* None

## Pre-requisites

* None

## Workflow

1. Create terraform.tfvars based on example template provider.

2. Ensure you have exported the `ARM_ACCESS_KEY` for the Terraform backend storage account.

```sh
export ARM_ACCESS_KEY=<secret>
```

3. Initialize and set the Terraform backend configuration parameters for the AzureRM provider.

```sh
terraform init\
    -backend-config="storage_account_name=<storage_account_name>" \
    -backend-config="container_name=azwebapp-tfstate" \
    -backend-config="key=drupalwxt-azwebapp.terraform.tfstate"
```

> Note: You will have to specify your own storage account name for where to store the Terraform state. Also don't forget to create your container name which in this instance is azwebapp-tfstate.

4. Create an execution plan and save the generated plan to a file.

```sh
terraform plan -out plan
```

5. Apply the remainder of changes required to reach desired state.

```sh
terraform plan -out plan
terraform apply plan
```

> Note: Take note of the generated link displayed at the end.

6. Enable Web Server Logging

```sh
az webapp log config  --resource-group ${prefix}-resources --name ${prefix}-appservice --web-server-logging filesystem
```

7. Proceed to the generated link and wait till the Drupal installation comes up.

> Note: This unfortunately may take a while 10+ mins and you may need to refresh a few times.

## SSH

At the moment we won't be adding SSH to the main container images provided by DrupalWxT as this is theoretically a security risk.

Instead we will create container images that extend of the official images and that have this behaviour.

Azure Web Apps for Containers requires this behavior as discussed here:

https://docs.microsoft.com/en-us/azure/app-service/containers/configure-custom-container#enable-ssh

## TODO

* Switch to Managed DB Instance instead of MySQL / PostgreSQL container
* Learn to run drush commands from Web App Container
* Integrate with Azure Active Directory
* Integrate with Azure CDN for Custom Domain
* Add SSL Certificates automated process
* Document the Azure Web Apps for Containers workflow + Visio Diagram
* Add in other integrations as referenced by: https://github.com/Azure-App-Service/php

## History

| Date     | Release    | Change                                                     |
| -------- | ---------- | ---------------------------------------------------------- |
| 20190729 | 20190729.1 | Improvements to documentation and formatting               |
| 20190909 | 20190909.1 | 1st release                                                |

## Maintainers/Sponsors

This project has been sponsored by:

* [OpenPlus](https://openplus.ca)