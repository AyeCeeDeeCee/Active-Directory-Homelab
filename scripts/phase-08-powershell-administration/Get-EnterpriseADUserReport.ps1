<#
# ============================================================
# Project Metadata
# ============================================================
# Project:      Active Directory Homelab
# Repository:   Active-Directory-Homelab
# Phase:        08C – PowerShell Automation
# Objective:    08C-02 – Enterprise Reporting
# Script:       Get-EnterpriseADUserReport.ps1
# Platform:     Windows Server 2022
# Domain:       coachtorres.local
# Author:       Coach Torres
# Status:       Verified
# Last Updated: 2026-08-09
# ============================================================

<#
.SYNOPSIS
Generates an enterprise Active Directory user report.

.DESCRIPTION
Retrieves user information from the Employees
Organizational Unit and reports enterprise user
attributes, enabled status, security group memberships,
and Organizational Unit location.

.AUTHOR
Coach Torres

.PROJECT
Active Directory Homelab

.PHASE
08C – PowerShell Automation

.OBJECTIVE
08C-02 Enterprise Reporting
#>
Import-Module ActiveDirectory

function Get-EnterpriseADUserReport {

    $Users = Get-ADUser `
        -Filter * `
        -SearchBase "OU=Employees,DC=coachtorres,DC=local" `
        -Properties Department, Enabled, DistinguishedName

    $Report = foreach ($User in $Users) {

        $Groups = Get-ADPrincipalGroupMembership $User |
            Where-Object Name -ne "Domain Users" |
            Sort-Object Name |
            Select-Object -ExpandProperty Name

        $Department = if ([string]::IsNullOrWhiteSpace($User.Department)) {
            "Not Assigned"
        }
        else {
            $User.Department
        }

        [PSCustomObject]@{
            User                = $User.Name
            Username            = $User.SamAccountName
            Department          = $Department
            Enabled             = $User.Enabled
            "Group Memberships" = if ($Groups) { $Groups -join ", " } else { "None" }
            "OU Location"       = ($User.DistinguishedName -split ",",2)[1]
        }
    }

    $ReportPath = "C:\Scripts\EnterpriseADUserReport.csv"

    $SortedReport = $Report | Sort-Object Department, User

    $SortedReport | Export-Csv -Path $ReportPath -NoTypeInformation

    $SortedReport | Format-Table -AutoSize
}