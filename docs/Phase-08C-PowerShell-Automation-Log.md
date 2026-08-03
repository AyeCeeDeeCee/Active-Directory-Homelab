
# Phase 08C – PowerShell Automation Log

## Project Metadata

| Field | Value |
|--------|-------|
| **Project** | Active Directory Homelab |
| **Repository** | Active-Directory-Homelab |
| **Phase** | 08 – PowerShell Administration |
| **Stage** | 08C – Automate |
| **Document** | Phase-08C-PowerShell-Automation-Log.md |
| **Platform** | Windows Server 2022 |
| **Domain** | coachtorres.local |
| **Author** | Coach Torres |
| **Status** | In Progress |
| **Last Updated** | 2026-08-03 |

---

## Purpose

Record the verified engineering work completed during
Phase 08C – Automate.

This document preserves the implementation,
verification, observations, and supporting evidence for
PowerShell automation developed against the canonical
Active Directory environment.

---

## Table of Contents

1. Repository Information
2. 08C-02 – Enterprise Reporting
3. 08C-03 – Account Lifecycle Automation
4. 08C-04 – Security Group Administration
5. 08C-05 – Organizational Unit Administration
6. 08C-06 – Administrative Toolkit
7. 08C-07 – Bulk User Provisioning
8. 08C-08 – Baseline Recreation
9. Lessons Learned
10. Evidence

## Repository Information

| Field | Value |
|--------|-------|
| **Current Branch** | master |
| **Repository Location** | docs/ |
| **Primary Script Location** | scripts/phase-08-powershell-administration/ |
| **Document Type** | Implementation Log |
| **Current Engineering Focus** | Develop reusable PowerShell automation against the canonical Active Directory environment |

## 08C-02 – Enterprise Reporting

### Objective

Develop a reusable enterprise reporting script.

### Implemented

- Get-EnterpriseADUserReport.ps1

### Engineering

- Imported the ActiveDirectory module.
- Retrieved enterprise users from the Employees OU.
- Built structured PowerShell report objects.
- Sorted the report by Department and User.
- Exported the report to CSV.
- Displayed the report in the console.

### Verification

- Successfully executed on AD-DC-01.
- Verified console output.
- Verified CSV creation.
- Verified CSV contents.

### Evidence

- VS Code implementation screenshot
- PowerShell execution screenshot
- CSV verification screenshot

### Result

Enterprise Reporting Version 1 completed successfully.

The script retrieves enterprise users from the Employees
Organizational Unit, constructs structured PowerShell
objects, displays a sorted administrative report, and
exports the verified dataset to CSV for reuse.

### Engineering Notes

Development occurred on the Windows host using VS Code.
Verification occurred on AD-DC-01 against the canonical
Active Directory environment.

This objective establishes the first reusable reporting
workflow in the transition from manual Active Directory
administration to PowerShell automation.


