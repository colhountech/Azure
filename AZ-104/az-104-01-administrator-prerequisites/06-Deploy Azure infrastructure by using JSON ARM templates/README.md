# Deploy Azure infrastructure by using JSON ARM templates

- problem with script is that storage account is hardcoded and so is sku

- arm templtes use parametrs and outputs in templates

- we define parameters and output at the start of arm templates
and use them in resouurces as key values by replacing
value = parameters('name') and adding constrains to the new parameter properties.

e.g


# Exercise - Add parameters and outputs to your Azure Resource Manager template

In `azuredeploy.json` add to parmaters block:

```json

 "parameter1": {
    "type": "string",
    "metadata": {
        "description": "description"
    }
  }
```

Change name to storageName to match following:

```json
  "storageName": {
    "type": "string",
    "minLength", 3,
    "maxLength", 24,
    "metadata": {
        "description": "the name of the Azure storage resource"
    }
  }
```

Reference this in the resource block:

```jsom

"name" : "parameters('storageName')"

```

# Deploy ARM template using Azure CLI

```bash

t = "azuredeploy.json"
today=$(date +"%d-%b-%Y")
name="addnameparameter-"$today

az deployment group create \
  --name $name \
  --template-file $t
  --parameters storageName="my-demo-name"
```

# Deploy ARM template using Powershell

```pwsh

$t="azuredeploy.json"
$today=Get-Date -Format "MM-dd-yyyy"
$n="addnameparameter-"+"$today"
New-AzResourceGroupDeployment `
  -Name $n `
  -TemplateFile $t `
  -storageName my-demo-name
  
```

  