<#
.SYNOPSIS
Performs enterprise Active Directory user administration tasks.

.DESCRIPTION
Provides reusable PowerShell workflows for common
Active Directory account lifecycle administration,
including account management, password management,
and user attribute updates.

.AUTHOR
Coach Torres

.PROJECT
Active Directory Homelab

.PHASE
08C – PowerShell Automation

.OBJECTIVE
08C-03 Account Lifecycle Automation
#>

Import-Module ActiveDirectory

# ==========================================================
# User Account Lifecycle Functions
# ==========================================================
function Disable-EnterpriseUser {

    param (
        [Parameter(Mandatory)]
        [string]$Username
    )

    Disable-ADAccount -Identity $Username

    Get-ADUser -Identity $Username -Properties Enabled |
        Select-Object Name, SamAccountName, Enabled
}

function Enable-EnterpriseUser {

    param (
        [Parameter(Mandatory)]
        [string]$Username
    )

    Enable-ADAccount -Identity $Username

    Get-ADUser -Identity $Username -Properties Enabled |
        Select-Object Name, SamAccountName, Enabled
}

function Unlock-EnterpriseUser {

    param (
        [Parameter(Mandatory)]
        [string]$Username
    )

    Unlock-ADAccount -Identity $Username

    Get-ADUser -Identity $Username -Properties LockedOut |
        Select-Object Name, SamAccountName, LockedOut
}

function Reset-EnterpriseUserPassword {

    param (
        [Parameter(Mandatory)]
        [string]$Username,

        [Parameter(Mandatory)]
        [SecureString]$NewPassword
    )

    Set-ADAccountPassword `
        -Identity $Username `
        -NewPassword $NewPassword `
        -Reset

    Get-ADUser -Identity $Username |
        Select-Object Name, SamAccountName, Enabled
}

function Set-EnterpriseUserPasswordChange {

    param (
        [Parameter(Mandatory)]
        [string]$Username
    )

    Set-ADUser `
        -Identity $Username `
        -ChangePasswordAtLogon $true

    Get-ADUser -Identity $Username -Properties PasswordLastSet |
        Select-Object Name, SamAccountName, PasswordLastSet
}
