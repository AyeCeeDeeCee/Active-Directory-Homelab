# ============================================================
# Project Metadata
# ============================================================
# Project:      Active Directory Homelab
# Repository:   Active-Directory-Homelab
# Phase:        08C – PowerShell Automation
# Objective:    08C-06 – Administrative Toolkit
# Script:       Import-EnterpriseADToolkit.ps1
# Platform:     Windows Server 2022
# Domain:       coachtorres.local
# Author:       Coach Torres
# Status:       Verified
# Last Updated: 2026-08-09
# ============================================================

Import-Module ActiveDirectory

$ToolkitRoot = $PSScriptRoot

. "$ToolkitRoot\Get-EnterpriseADUserReport.ps1"
. "$ToolkitRoot\Manage-EnterpriseUser.ps1"
. "$ToolkitRoot\Manage-EnterpriseGroup.ps1"
. "$ToolkitRoot\Manage-EnterpriseOU.ps1"