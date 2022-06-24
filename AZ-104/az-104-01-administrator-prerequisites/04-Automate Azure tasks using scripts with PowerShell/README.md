$PSVersionTable.PSVersion
Get-Help -Name Get-ChildItem -Detailed
Get-Module
Install-Module -Name Az -Scope CurrentUser -Repository PSGallery

# If it didn't install try this
Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -AllowClobber

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Update-Module -Name Az

# Connect Azure Account
Connect-AzAccount

# Get current subscription
Get-AzContext

# Get All Subscriptions
Get-AzSubscription


# Set subscription (user id, not tenant-id)
Set-AzContext -Subscription '00000000-0000-0000-0000-000000000000'

# Get List of all Resource Groups
Get-AzResourceGroup
Get-AzResourceGroup | Format-Table

# Create rg
New-AzResourceGroup -Name  Ms-Learn -Location NorthEurope

# List all resource in Resource Group
Get-AzResource -ResourceGroupName Ms-Learn

# Create VM
New-AzVm -ResourceGroupName MS-Learn -Name  vm-ms-learn -Credential (Get-Credential) -Location NorthEurope -Image UbuntuLTS

No Size value has been provided. The VM will be created with the default size Standard_D2s_v3.

$vm = Get-AzVM  -Name vm-ms-learn  -ResourceGroupName MS-Learn

# Update VM Size
$vm.HardwareProfile.vmSize = "Standard_B1ls"
$rg = "MS-Learn"
Update-AzVM -ResourceGroupName $rg  -VM $vm

#  get-help stop-azvm
#   Stop-AzVM [-ResourceGroupName] <System.String> [-Name] <System.String>
Stop-AzVM  -ResourceGroups $rg -Name "vm-ms-learn"

# Restart VM
# Get-Help Restart-AzVm
# Restart-AzVM [-Id] <System.String> 
# Restart-AzVM [-ResourceGroupName] <System.String> [-Name] <System.String>

# list all VMs
Get-AzVM 

# get info of specific vm
Get-AzVM -name vm-ms-learn

# Start a VM (requires rg)
Start-AzVM -name vm-ms-learn -ResourceGroup $rg

# Restart a VM 
reStart-AzVM -name vm-ms-learn -ResourceGroup $rg

# Finally. remove the VM
Remove-AzVM  -name vm-ms-learn -ResourceGroup $rg  

# Create VM (more complex)
New-AzVm -ResourceGroupName learn-ecb0c1ec-b73e-4286-bf0f-6367d80a9c34 
    -Name "testvm-eus-01" 
    -Credential (Get-Credential) 
    -Location "East US" 
    -Image UbuntuLTS 
    -OpenPorts 22 
    -PublicIpAddressName "testvm-01"
    
$vm = (Get-AzVM -Name "testvm-eus-01" -ResourceGroupName [sandbox resource group name])

$vm

$vm.HardwareProfile
$vm.StorageProfile.OsDisk

# Get VM Size
$vm | Get-AzVMSize

# Get IP Address

Get-AzPublicIpAddress -ResourceGroupName learn-ecb0c1ec-b73e-4286-bf0f-6367d80a9c34 -Name "testvm-01"
ssh user@20.127.8.186

# Delete
Stop-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName
Remove-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName
Get-AzResource -ResourceGroupName $vm.ResourceGroupName | Format-Table

$vm | Remove-AzNetworkInterface –Force
Get-AzDisk -ResourceGroupName $vm.ResourceGroupName -DiskName $vm.StorageProfile.OSDisk.Name | Remove-AzDisk -Force
Get-AzVirtualNetwork -ResourceGroupName $vm.ResourceGroupName | Remove-AzVirtualNetwork -Force
Get-AzNetworkSecurityGroup -ResourceGroupName $vm.ResourceGroupName | Remove-AzNetworkSecurityGroup -Force
Get-AzPublicIpAddress -ResourceGroupName $vm.ResourceGroupName | Remove-AzPublicIpAddress -Force


# Scripts

# run script as ./myScript.ps1
# run script as ./setupEnv.ps1 -size 5 -location "North Europe"
# captured with ...
# param([string]$location, [int]$size)

# Exercise - Create and save scripts in Azure PowerShell
# Crate a powershell script to automate the creation of 3 vm 

cd $HOME\clouddrive
echo @'
# this is just like unix where everything between the 2 @ signs with be redirected to the file.
param ( [string]$rg )

$adminCredential = Get-Credential -Message "Enter a username and password for the VM administrator."
For ($i = 1; $i -le 3; $i++) 
{
    $vm = "confdemovm" + $i
    Write-Host "Creating VM: " $vm
    New-AzVm -ResourceGroupName $rg -Name $vm -Credential $adminCredential -Image UbuntuLTS -Size "Standard_B1ls"
}
 Write-Host "All Done. Let's see if it worked"
Get-AzResource -ResourceType Microsoft.Compute/virtualMachines

'@ > ConferenceDailyReset.ps1


# cleanup

Remove-AzVM  -name confdemovm1 -ResourceGroup learn-f73aa497-b86f-47f3-88b4-1a2bbd434ac9
Remove-AzVM  -name confdemovm2 -ResourceGroup learn-f73aa497-b86f-47f3-88b4-1a2bbd434ac9
Remove-AzVM  -name confdemovm3 -ResourceGroup learn-f73aa497-b86f-47f3-88b4-1a2bbd434ac9


# Remove everything in a resource group

Remove-AzResourceGroup -Name learn-f73aa497-b86f-47f3-88b4-1a2bbd434ac9 -Force

# end of exercise
