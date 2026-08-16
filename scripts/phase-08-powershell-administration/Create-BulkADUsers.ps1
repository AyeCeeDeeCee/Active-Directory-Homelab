<#
.SYNOPSIS
Creates Active Directory users from a CSV file.

.DESCRIPTION
This script imports user information from a CSV file, validates the supplied
user data, creates Active Directory user accounts in the specified
organizational unit, and verifies successful account creation.

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

    if (-not $Username) {
        Write-Warning "Username is missing. Skipping this CSV entry."
        continue
    }

    $ExistingUser = Get-ADUser -Filter "SamAccountName -eq '$Username'" -ErrorAction SilentlyContinue

    if ($ExistingUser) {
        Write-Warning "User '$Username' already exists. Skipping."
        continue
    }

    if (-not $FirstName -or
        -not $LastName -or
        -not $Department -or
        -not $Password -or
        -not $OU) {

        Write-Warning "Required user information is missing for '$Username'. Skipping."
        continue
    }

    $TargetOU = Get-ADOrganizationalUnit -Identity $OU -ErrorAction SilentlyContinue

    if (-not $TargetOU) {
        Write-Warning "Target OU '$OU' does not exist for '$Username'. Skipping."
        continue
    }

    $DisplayName = "$FirstName $LastName"
    $SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force

    try {
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
            -ChangePasswordAtLogon $true `
            -ErrorAction Stop

        Write-Host "User '$Username' created successfully."

        $CreatedUser = Get-ADUser -Identity $Username -Properties Department, Enabled, DistinguishedName

        if ($CreatedUser) {
            Write-Host "Verified '$Username' in Active Directory."
        }
        else {
            Write-Warning "User '$Username' could not be verified after creation."
        }
    }
    catch {
        Write-Warning "Failed to create user '$Username': $($_.Exception.Message)"
    }
} 
