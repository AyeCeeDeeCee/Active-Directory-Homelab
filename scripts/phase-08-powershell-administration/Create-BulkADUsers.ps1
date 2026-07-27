<#
.SYNOPSIS
Creates Active Directory users from a CSV file.

.DESCRIPTION
This script imports user information from a CSV file, creates user accounts
in the Employees organizational unit, and adds each user to the appropriate
security group.

.AUTHOR
Ed Torres

.PROJECT
Active Directory Homelab

.PHASE
08 - PowerShell Administration
#>
Import-Module ActiveDirectory
$CsvPath = ".\users.csv"
if (-not (Test-Path $CsvPath)) {
        Write-Error "CSV file not found: $CsvPath"
        return
}
$Users = Import-Csv -Path $CsvPath
foreach ($User in $Users) { 
    $FirstName = $User.FirstName
    $LastName = $User.LastName
    $Username = $User.Username
    $Department = $User.Department
    $Password = $User.Password
    $OU = $User.OU
    $DisplayName = "$FirstName $LastName"
    $SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
    New-ADUser `
        -GivenName $FirstName `
            -Surname $LastName `
                -Name $DisplayName `
                    -SamAccountName $Username `
                        -UserPrincipalName "$Username@coachtorres.local" `
                            -DisplayName $DisplayName `
                                -Department $Department `
                                    -AccountPassword $SecurePassword `
                                        -Path $OU `
                                            -Enabled $true `
                                                -ChangePasswordAtLogon $true
}
