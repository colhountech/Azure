# Import the Azure Powershell module

Import-Module -Name Az

# Connect to an Azure Account
Connect-AzAccount

Get-AzSubscription | format-Table

Set-AzContext -Subscription  '00000000-0000-0000-0000-000000000000'
get-azContext | format-Table

# Define Azure variable for a virtual machine
$vmName = "wttvm"
$rg = "wtt-rg"
$loc = "North Europe"
$iterations = 3
# Create Azure Credentials
$adminCredential = Get-Credential -Message "Enter a username and password for the VM admin."



# Create a vm in azure
# New-AzVm -ResourceGroup $rg -Name $vmName -Credential $adminCredential -Location $loc -Image UbuntuLTS -Size "Standard_B1ls"

