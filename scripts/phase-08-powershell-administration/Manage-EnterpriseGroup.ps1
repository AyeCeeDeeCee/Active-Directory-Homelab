#
# ============================================================
# Project Metadata
# ============================================================
# Project:      Active Directory Homelab
# Repository:   Active-Directory-Homelab
# Phase:        08C – PowerShell Automation
# Objective:    08C-04 – Security Group Administration
# Script:       Manage-EnterpriseGroup.ps1
# Platform:     Windows Server 2022
# Domain:       coachtorres.local
# Author:       Coach Torres
# Status:       Verified
# Last Updated: 2026-08-09
# ============================================================

Import-Module ActiveDirectory

function Get-EnterpriseGroupMember {

    param (
        [Parameter(Mandatory)]
        [string]$GroupName
    )

    Get-ADGroupMember -Identity $GroupName |
        Select-Object Name, SamAccountName, ObjectClass |
        Sort-Object Name
}

function Test-EnterpriseGroupMember {

    param (
        [Parameter(Mandatory)]
        [string]$GroupName,

        [Parameter(Mandatory)]
        [string]$SamAccountName
    )

    $Members = Get-ADGroupMember -Identity $GroupName

    $Members.SamAccountName -contains $SamAccountName
}

function Add-EnterpriseGroupMember {

    param (
        [Parameter(Mandatory)]
        [string]$GroupName,

        [Parameter(Mandatory)]
        [string]$SamAccountName
    )

    Add-ADGroupMember -Identity $GroupName -Members $SamAccountName

    Test-EnterpriseGroupMember `
        -GroupName $GroupName `
        -SamAccountName $SamAccountName
}

function Remove-EnterpriseGroupMember {

    param (
        [Parameter(Mandatory)]
        [string]$GroupName,

        [Parameter(Mandatory)]
        [string]$SamAccountName
    )

    Remove-ADGroupMember `
        -Identity $GroupName `
        -Members $SamAccountName `
        -Confirm:$false

    -not (
        Test-EnterpriseGroupMember `
            -GroupName $GroupName `
            -SamAccountName $SamAccountName
    )
}

function Get-EnterpriseGroupReport {

    $Groups = @(
        "Accounting"
        "HR"
        "IT"
        "Managers"
    )

    foreach ($GroupName in $Groups) {

        Get-ADGroupMember -Identity $GroupName |
            Select-Object `
                @{Name='Group';Expression={$GroupName}},
                Name,
                SamAccountName,
                ObjectClass
    }
}