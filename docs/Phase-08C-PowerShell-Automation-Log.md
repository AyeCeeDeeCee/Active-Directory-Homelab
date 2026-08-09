
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
| **Last Updated** | 2026-08-04 |

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

- `screenshots/Phase08C-03-VSC-Entr-Usr-Screenshot.png`
- `screenshots/Phase08C-03-Auto-Log-Screenshot.png`
- PowerShell command history captured.
- Console output verified.

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

## 08C-03 – Account Lifecycle Automation

### Objective

Develop reusable PowerShell workflows for common
Active Directory account lifecycle administration.

### Implemented

- Manage-EnterpriseUser.ps1

### Engineering

- Imported the ActiveDirectory module.
- Created a reusable enterprise user administration toolkit.
- Implemented Disable-EnterpriseUser.
- Implemented Enable-EnterpriseUser.
- Implemented Unlock-EnterpriseUser.
- Implemented Reset-EnterpriseUserPassword.
- Implemented Set-EnterpriseUserPasswordChange.

### Verification

- Successfully loaded the toolkit into the PowerShell session on AD-DC-01.
- Verified PowerShell function availability using Get-Command.
- Verified Disable-EnterpriseUser.
- Verified Enable-EnterpriseUser.
- Verified Reset-EnterpriseUserPassword.
- Verified Set-EnterpriseUserPasswordChange.
- Verified Active Directory password complexity enforcement.

### Evidence

- PowerShell command history captured.
- Console output verified.
- ⏳ Verification screenshots scheduled for capture during the next AD-DC-01 session.

### Result

Account Lifecycle Automation Version 1 completed
successfully.

The reusable toolkit provides standardized enterprise
PowerShell workflows for managing the lifecycle of
existing Active Directory user accounts.

### Engineering Notes

Development occurred on the Windows host using VS Code.

Verification occurred on AD-DC-01 against the canonical
Active Directory environment.

During implementation, PowerShell function scope was
investigated after the toolkit was initially executed
without making the functions available in the current
PowerShell session.

The toolkit was successfully loaded by dot-sourcing:

```powershell
. .\Manage-EnterpriseUser.ps1
```

This implementation introduced the distinction between
executing a PowerShell script and loading reusable
functions into an interactive PowerShell session.

Password reset verification also demonstrated Active
Directory password complexity enforcement by rejecting
a non-compliant password before successfully accepting
a compliant replacement password.

The toolkit consolidates common user lifecycle
administration into reusable PowerShell functions that
simplify enterprise account management while providing
consistent verification after administrative actions.

This objective establishes the project's first reusable
enterprise administrative toolkit and provides the
foundation for future security group, Organizational
Unit, and baseline automation workflows.

## 08C-04 – Security Group Administration

### Objective

Develop and verify reusable PowerShell workflows for
administering the existing enterprise security groups.

The implementation focused on the canonical IT, HR,
Accounting, and Managers groups within the
coachtorres.local Active Directory environment.

### Implementation

Created and verified:

`Manage-EnterpriseGroup.ps1`

The script provides reusable PowerShell functions for
security group administration within the canonical
Active Directory environment.

Implemented functions:

• Get-EnterpriseGroupMember

• Test-EnterpriseGroupMember

• Add-EnterpriseGroupMember

• Remove-EnterpriseGroupMember

• Get-EnterpriseGroupReport

### Testing and Verification

The toolkit was transferred to AD-DC-01 and loaded into
the current PowerShell session using dot-sourcing.

Function availability was verified using Get-Command.

Get-EnterpriseGroupMember was verified against the IT
security group.

The observed membership matched the previously verified
baseline:

• Alicia Simmons – asimmons

• Nathan Miller – nmiller

Test-EnterpriseGroupMember was verified against both
known-true and known-false membership states.

Known-true test:

• Alicia Simmons – IT → True

Known-false test:

• Alicia Simmons – HR → False

A controlled and reversible group-membership change was
then performed using Alicia Simmons and the HR security
group.

The workflow verified:

• Pre-change HR membership → False

• Add-EnterpriseGroupMember → True

• Independent HR membership verification confirmed
  Alicia Simmons and Nathan Miller as members.

• Remove-EnterpriseGroupMember → True

• Final independent HR membership verification confirmed
  only Nathan Miller remained.

The temporary membership change was therefore reversed
successfully and the original verified HR group state
was restored.

### Enterprise Group Report Verification

Get-EnterpriseGroupReport was executed against the
canonical enterprise security groups.

The final report returned the following verified
group-membership assignments:

• Accounting – David Martinez – dmartinez

• Accounting – Sara Chung – schung

• HR – Nathan Miller – nmiller

• IT – Alicia Simmons – asimmons

• IT – Nathan Miller – nmiller

• Managers – Micheal Rodriguez – mrodriguez

The final report matched the security group baseline
verified at the beginning of 08C-04.

This confirmed that the temporary group-membership
change used during testing had been successfully reversed
and that the canonical Active Directory group state was
preserved.

### Evidence

Evidence captured during 08C-04 includes:

• VS Code implementation evidence showing
  Manage-EnterpriseGroup.ps1 within the local Git
  repository development environment.

• PowerShell verification evidence from AD-DC-01 showing
  successful loading of the security group toolkit,
  function availability, and the verified enterprise
  group-membership report.

Evidence files:

• Phase08C-04-VSC-Script-Screenshot 2026-08-09 092157.png

• Phase08C-04-Entr-Grp-Rpt-Vrfd-Screenshot 2026-08-09 092003.png

### Engineering Notes

Development occurred on the Windows host using VS Code.

Execution and verification occurred on AD-DC-01 against
the canonical Active Directory environment.

Manage-EnterpriseGroup.ps1 was developed incrementally.
Each function was added to the authoritative Git repository
source, transferred to the Domain Controller, loaded using
dot-sourcing, and verified before development continued.

The implementation demonstrated the difference between
performing an administrative change and verifying the
resulting Active Directory state.

Read-only functions were verified before modifying
functions were tested.

A controlled and reversible membership change was used
to validate group administration without permanently
altering the canonical enterprise baseline.

Alicia Simmons was temporarily added to the HR security
group, the resulting membership was independently
verified, and the user was then removed from HR.

Final reporting confirmed that the original security
group baseline had been restored.

The completed toolkit provides reusable workflows for
displaying membership, testing membership, adding users,
removing users, and reporting security group assignments.

This objective extends the reusable PowerShell
administration capabilities established during 08C-03
while preserving verification as part of every modifying
workflow.

