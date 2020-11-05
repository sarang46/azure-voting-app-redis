[[_TOC_]]

# Introduction 

This repository is one in a series of [JumpStart Kits](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_wiki/wikis/Cloud%20Foundation%20Patterns/68/JumpStart-Kits). This kit will highlight a particular combination of patterns at the [Compute and Persistence layer](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_wiki/wikis/Cloud%20Foundation%20Patterns/68/JumpStart-Kits?anchor=purpose). The Compute layer of this kit will use [Azure Kubernetes Service](https://docs.microsoft.com/en-us/azure/aks/)) (AKS).

> Note: Please ensure you read through the major [JumpStart Kits](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_wiki/wikis/Cloud%20Foundation%20Patterns/68/JumpStart-Kits) documentation before continuing with this doc.


# Example Use Case 1
Azure Kubernetes Service With Platform-as-a-Service (PaaS) database.
This kit includes the following architecture example:

1. Compute Layer

A. The Front-end Tier provisions an AKS cluster and a user specified number of node pools for deployment of microservices

2. Persistence Layer

B. The Back-end Tier can utilize an approved PaaS Database Pattern

## Architecture Diagram

# Example Use Case 2
Azure Kubernetes Service with Managed Disks for persistent storage
This kit includes the following architecture example:

1. Compute Layer

A. The Front-end Tier provisions an AKS cluster and a user specified number of node pools for deployment of microservices

2. Persistence Layer

B. Managed Disks for persistent storage acccessible to the node pools

# Getting Started
If you find that this JumpStart Kit will be useful for accelerating your migration strategy, please follow the steps found at the wiki, [Getting Started on a kit](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_wiki/wikis/Cloud%20Foundation%20Patterns/115/Getting-Started-on-a-kit).

## High-level steps for consuming kit
1. Create a new repo in the VP tower for the application
2. Copy this kit repo to the new repo in the VP tower into a new branch
3. Modify /Pipelines/pipeline.yaml to reference desired common-library version
4. Modify /Pipelines/variables.yaml to suit your needs
5. Create an Azure Pipeline pointing to pipelines/pipeline.yaml
6. Modify /Terraform/Backends/backend.<environment>.tfvars for each environment
7. Modify /Terraform/Config/config.<environment>.tfvars to declare the Azure resource properties (names, vnet info, etc...)

## Detailed steps for consuming kit
### Pipeline Preparation
#### Create a new repo in the VP tower for the application
An existing VP tower and the ability to create a new repo should already be in place

#### Copy this kit repo to the new repo in the VP tower
Within the new repo, create a branch while code is being adjusted to a working state. After confirming that this kit is appropriate for the application, either clone or copy it from this location to the new repo. This will become your working copy.

#### Modify pipeline.yaml
The provided /Pipelines/pipeline.yaml file contains three pre-defined stages with dependencies. Each stage is considered an environment which must have its own corresponding ./terraform/config/config.<environment>.tfvars file.If a new environment is needed, copy and paste a stage and modify the name. This also supports same environment multi-region. For example a multi-region deployment of DEV would have two stages. One named DEV-EASTUS and the other as DEV-EASTUS2. There would be two TFVARS files named config.dev-eastus.tfvar and config.dev-eastus2.tfvar. See "Terraform Prep".

#### Set Common Library version
The common library includes Terraform modules that are common across projects and towers. It also includes Pipeline YAML sequences that are common across all pipelines, which are the Terraform setup, init, plan, and apply stages. These are referenced and versioned in the "resources" section of the pipeline.yaml file. Ensure the version tag is used as there is ongoing development being merged regularly with master.

resources:
  repositories:
  - repository: common-library
    type: git
    name: ATT Cloud/common-library
    ref: refs/tags/v0.1 # can also be a branch reference if required
    endpoint: 

#### Modify variables.yaml
Edit the example /Pipelines/variables.yaml file, and identify:

1. Review Variables.yaml for variables that are marked for modification 
2. Review Variables.<ENVIRONMENT>.yaml for variables that are marked for modification

Create an Azure Pipeline
In Azure DevOps Pipelines, navigate to Pipelines -> New -> Existing YAML -> point to /Pipelines/pipeline.yaml

### Terraform Preparation
#### Modify Terraform Backends Files
Create or edit a /Backends/backend.<ENVIRONMENT>.tfvars file for each environment. This contains the Terraform state configuration for the backend

### Setup Terraform Variables Per Environment
Create or edit a /Terraform/Config/config.<ENVIRONMENT>.tfvars file for all variable definitions per environment. Three sample environments have been provided by default (DEV, QA, PROD)

### Test the deployment
At this point you should be able to commit your changes to the new repo and branch and the pipeline will automatically run.
___

# Contribute
To contribute, please follow the steps in the meta JumpStart Kit document's section, [How to contribute](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_wiki/wikis/Cloud%20Foundation%20Patterns/68/JumpStart-Kits?anchor=how-to-contribute).