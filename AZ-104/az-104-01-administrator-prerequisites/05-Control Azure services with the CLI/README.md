#
az vm restart -g MyResourceGroup -n MyVm

# How to install az
- Linux - apt-get
- MacOS - homebrew
- Win - MSI

# CLI vs Powershell 

# cli

variable="value"
variable=integer

# powershell
$variable="value"
$variable=integer


# Azure CLI - finding help with find

az find blob
az find "az vm"
az find "az vm create"

# also --help
az storage blob --help

# Quick commands
az login
az account list
az account set  --subscription 000000-0000-0000-0000-000000000000
az account show --output table

az group create --name <name> --location <location>
az group list
az group list --output table

# Exercise 
# assume we have already done the following 2 commands
# az login
# az group create --name ms-learn --location northeurope
# First setup env variable for later

export RESOURCE_GROUP=learn-a64e8964-c9fa-42bd-9239-7110b87249de
export AZURE_REGION=centralus
export AZURE_APP_PLAN=popupappplan-$RANDOM
export AZURE_WEB_APP=popupwebapp-$RANDOM

# tip - shift-insert == paste

# pricing tiers
az appservice plan create --help
az appservice plan create --name $AZURE_APP_PLAN --resource-group $RESOURCE_GROUP --location $AZURE_REGION --sku FREE
# list the active app service plan
az appservice plan list --output table
az webapp create --name $AZURE_WEB_APP --resource-group $RESOURCE_GROUP --plan $AZURE_APP_PLAN
az webapp list --output table
# note default hostname popupwebapp-19884.azurewebsites.net

curl popupwebapp-19884.azurewebsites.net

# manual deploy from git
az webapp deployment source config --name $AZURE_WEB_APP --resource-group $RESOURCE_GROUP --repo-url "https://github.com/Azure-Samples/php-docs-hello-world" --branch master --manual-integration

This exercise demonstrated a typical pattern for an interactive Azure CLI session. You first used a standard command to create a new resource group. You then used a set of commands to deploy a resource (in this example, a web app) into this resource group. This set of commands could easily be combined into a shell script, and executed every time you need to create the same resource.


curl $AZURE_WEB_APP.azurewebsites.net


# end of exercise



