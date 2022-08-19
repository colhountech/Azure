# Infrastructure as Code gives

- consistent config
- scalability
- faster deployemtn
- more tracability

arm template are delcarative description of infrastructure as code

Real Power comes from brings infrastructure as code in our CI-CD.

ARM template files are made up of the following elements:

* schema - defines schela location
* contentVersion - version
* apiProfile - optional, to avoid using api versions
* parameters - optional, can be defined or passed in
* variables - optional to simplify repeating patterns
* functions - user defined functions, for repeated 
* resources - actual items
* output - returned and used by next step


ARM tempaltes Can be deployed via:

* local template
* linked template
* in a CI deployment pipeline

# deploy local ARM template


az login
az group create \
  --name ms-learn
  --location  "northeurope"

!! Note: `az deployment group create` superseends the obsolete `az group deployment create`

```bash
templateFile="azuredeploy.json"
az deployment group create \
  --name this-example
  --resource-group ms-learn \
  --template-file $t
  
```

Using templates in 
[Azure DevOps
Pipelines](https://docs.microsoft.com/en-us/learn/paths/deploy-applications-with-azure-devops/)
or [GitHub
Actions](https://docs.microsoft.com/en-us/learn/paths/automate-workflow-github-actions/)

# Add Resources to template

1. Get resource provider
2. get types

e.g.

{resource-provider}/{resource-type}
Microsoft.Storage/storageAccounts

[Docs to Arm Templates and Bicep here](https://docs.microsoft.com/en-us/azure/templates/)


