
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

## 08C-05 – Organizational Unit Administration

### Objective

Develop and verify reusable PowerShell workflows for
reviewing and administering the existing Organizational
Unit structure.

The implementation focused on the canonical
coachtorres.local Active Directory environment and
introduced reusable workflows for reviewing OUs,
identifying object placement, verifying expected
placement, moving Active Directory objects between
approved OUs, and reporting OU object assignments.

All modifying operations were performed using controlled
and reversible testing to preserve the canonical
enterprise baseline.

### Implementation

Created and verified:

`Manage-EnterpriseOU.ps1`

The script provides reusable PowerShell functions for
Organizational Unit administration and Active Directory
object-placement verification within the canonical
enterprise environment.

Implemented functions:

• Get-EnterpriseOU

• Get-EnterpriseObjectOU

• Test-EnterpriseObjectOU

• Move-EnterpriseADObject

• Get-EnterpriseOUReport

### Testing and Verification

The existing Organizational Unit structure was verified
before modifying automation was introduced.

The following OUs were confirmed:

• Admin

• Domain Controllers

• Employees

• Groups

• Lab

• Service Accounts

• Workstations

Distinguished Names were verified against the
coachtorres.local domain.

The five canonical enterprise users were verified within
the Employees OU:

• Alicia Simmons – asimmons

• David Martinez – dmartinez

• Micheal Rodriguez – mrodriguez

• Nathan Miller – nmiller

• Sara Chung – schung

Computer-object placement was also verified:

• WIN11-01 – Workstations

• WIN-J24UO6114L0 – Domain Controllers

The toolkit was transferred to AD-DC-01 and loaded into
the current PowerShell session using dot-sourcing.

Function availability was verified using Get-Command.

Get-EnterpriseOU was executed and reproduced the verified
Organizational Unit baseline.

Get-EnterpriseObjectOU was verified against WIN11-01 and
correctly returned the computer object within the
Workstations OU.

Test-EnterpriseObjectOU was then verified against both
known-true and known-false placement states.

Known-true test:

• WIN11-01 – Workstations → True

Known-false test:

• WIN11-01 – Lab → False

### Controlled Object Move Verification

A controlled and reversible object-placement change was
performed using WIN11-01.

The verified starting state was:

• WIN11-01 – Workstations

Move-EnterpriseADObject was used to move WIN11-01 from
the Workstations OU to the Lab OU.

The workflow returned:

• Workstations → Lab → True

The resulting Active Directory state was independently
verified using Get-EnterpriseObjectOU.

Observed placement:

• WIN11-01 – Lab

Move-EnterpriseADObject was then used to return WIN11-01
from the Lab OU to the Workstations OU.

The workflow returned:

• Lab → Workstations → True

Final independent verification confirmed:

• WIN11-01 – Workstations

The temporary object-placement change was therefore
successfully reversed and the original verified
workstation baseline was restored.

Move-EnterpriseADObject preserves the object's ObjectGUID
before the move and uses that stable identifier for
post-move verification.

This allows the same Active Directory object to be
verified after its Distinguished Name changes as a
result of moving between Organizational Units.

### Enterprise OU Report Verification

Get-EnterpriseOUReport was executed against the
canonical Active Directory environment.

The final report returned the following verified
object-placement assignments:

• Domain Controllers – WIN-J24UO6114L0 – computer

• Employees – Alicia Simmons – user

• Employees – David Martinez – user

• Employees – Micheal Rodriguez – user

• Employees – Nathan Miller – user

• Employees – Sara Chung – user

• Groups – Accounting – group

• Groups – HR – group

• Groups – IT – group

• Groups – Managers – group

• Workstations – WIN11-01 – computer

The report used one-level searches against each
Organizational Unit to identify objects directly
contained within the verified OU structure.

The final report matched the Active Directory object
placement baseline verified at the beginning of 08C-05.

This confirmed that the temporary WIN11-01 move used
during testing had been successfully reversed and that
the canonical Organizational Unit state was preserved.

### Evidence

Evidence captured during 08C-05 includes:

• VS Code implementation evidence showing
Manage-EnterpriseOU.ps1 within the local Git repository
development environment.

• PowerShell verification evidence from AD-DC-01 showing
successful loading of the Organizational Unit toolkit,
function availability, and the verified enterprise
OU object-placement report.

Evidence files:

• Phase08C-05-VSC-Spt-Screenshot 2026-08-09 140439.png

• Phase08C-05-OU-Rpt-Vfd-Screenshot 2026-08-09 140321.png

### Engineering Notes

Development occurred on the Windows host using VS Code.

Execution and verification occurred on AD-DC-01 against
the canonical Active Directory environment.

Manage-EnterpriseOU.ps1 was developed incrementally.
Each function was added to the authoritative Git repository
source, transferred to the Domain Controller, loaded using
dot-sourcing, and verified before development continued.

The implementation reinforced the importance of verifying
Active Directory object placement before performing
Organizational Unit administration.

Read-only and verification functions were implemented
before modifying automation was introduced.

A controlled and reversible object move was used to
validate Organizational Unit administration without
permanently altering the canonical enterprise baseline.

WIN11-01 was temporarily moved from the Workstations OU
to the Lab OU, the resulting placement was independently
verified, and the computer object was then returned to
the Workstations OU.

The object move workflow demonstrated an important
Active Directory identity concept.

An object's Distinguished Name changes when the object
is moved between Organizational Units.

The object's ObjectGUID remains stable and can therefore
be used to locate and verify the same object after the
move.

Final reporting confirmed that WIN11-01 had been restored
to the Workstations OU and that the original canonical
object-placement baseline was preserved.

Get-EnterpriseOUReport also introduced reusable structured
reporting of objects directly contained within the
enterprise Organizational Unit structure.

The completed toolkit provides reusable workflows for
reviewing OUs, identifying object placement, testing
expected placement, moving Active Directory objects, and
reporting OU assignments.

This objective extends the reusable PowerShell
administration capabilities established during 08C-03
and 08C-04 while preserving verification and reversible
testing as core requirements for modifying automation.

## 08C-06 – Administrative Toolkit

### Objective

Develop and verify a reusable Active Directory administrative
toolkit that provides a single entry point for the enterprise
PowerShell automation created during Phase 08C.

The implementation consolidates access to the previously
verified enterprise reporting, account lifecycle, security
group, and Organizational Unit administration workflows
without unnecessarily merging or rewriting the underlying
PowerShell components.

The toolkit preserves separation of administrative
responsibilities while allowing the verified functions to be
loaded together into a single PowerShell session.

### Implementation

Created and verified:

`Import-EnterpriseADToolkit.ps1`

The script provides a single entry point for loading the
verified Phase 08C enterprise PowerShell administration
components into the current PowerShell session.

The toolkit loader imports the Active Directory PowerShell
module and uses `$PSScriptRoot` to locate and dot-source the
component scripts relative to the loader's own location.

Loaded components:

• `Get-EnterpriseADUserReport.ps1`

• `Manage-EnterpriseUser.ps1`

• `Manage-EnterpriseGroup.ps1`

• `Manage-EnterpriseOU.ps1`

Using `$PSScriptRoot` avoids hard-coding the toolkit source
directory and allows the component scripts to remain
organized as separate administrative responsibilities.

The existing enterprise automation scripts were also
standardized with consistent project metadata while
preserving their previously verified administrative logic.

`Get-EnterpriseADUserReport.ps1` was refactored from an
immediately executing script into the reusable
`Get-EnterpriseADUserReport` function.

This change allows the reporting component to be loaded by
the administrative toolkit without automatically generating
a report when the toolkit is imported.

The underlying reporting workflow and verified report
contents were preserved.

### Testing and Verification

The completed administrative toolkit was transferred to
AD-DC-01 and loaded into the current PowerShell session
using dot-sourcing.

The toolkit loader executed successfully with no output,
confirming that the component scripts could be loaded
without automatically executing administrative workflows.

Representative function availability was verified using
`Get-Command`.

Verified functions included:

• `Get-EnterpriseADUserReport`

• `Disable-EnterpriseUser`

• `Get-EnterpriseGroupMember`

• `Get-EnterpriseOU`

This confirmed successful loading of functionality from
each major toolkit component.

The refactored `Get-EnterpriseADUserReport` function was
then executed independently.

The resulting report successfully returned the previously
verified canonical enterprise user state, including:

• User identity and SamAccountName

• Department assignment

• Enabled status

• Security group memberships

• Organizational Unit location

The successful report confirmed that converting the
reporting script into a reusable function preserved its
verified behavior.

A complete toolkit inventory was then performed using:

`Get-Command *Enterprise*`

The loaded PowerShell session contained 16 reusable
enterprise administration functions:

• `Add-EnterpriseGroupMember`

• `Disable-EnterpriseUser`

• `Enable-EnterpriseUser`

• `Get-EnterpriseADUserReport`

• `Get-EnterpriseGroupMember`

• `Get-EnterpriseGroupReport`

• `Get-EnterpriseObjectOU`

• `Get-EnterpriseOU`

• `Get-EnterpriseOUReport`

• `Move-EnterpriseADObject`

• `Remove-EnterpriseGroupMember`

• `Reset-EnterpriseUserPassword`

• `Set-EnterpriseUserPasswordChange`

• `Test-EnterpriseGroupMember`

• `Test-EnterpriseObjectOU`

• `Unlock-EnterpriseUser`

The final inventory confirmed that reporting, account
lifecycle administration, security group administration,
Organizational Unit administration, and verification
functions were available together within a single
PowerShell session.

### Evidence

Evidence captured during 08C-06 includes:

• Visual Studio Code implementation evidence showing
`Import-EnterpriseADToolkit.ps1` within the local Git
repository development environment.

• PowerShell verification evidence from AD-DC-01 showing
successful toolkit loading, execution of the refactored
enterprise user report, and availability of the complete
enterprise administrative function inventory.

Evidence files:

• `Phase08C-06-VSC-Ipt-Tkt-Screenshot 2026-08-09 220656.png`

• `Phase08C-06-Get-Cmd-Screenshot 2026-08-09 220402.png`

### Engineering Notes

Development occurred on the Windows host using Visual Studio
Code.

Execution and verification occurred on AD-DC-01 against the
canonical Active Directory environment.

The administrative toolkit was designed to reuse the
verified automation developed during earlier Phase 08C
objectives rather than duplicate or unnecessarily rewrite
working PowerShell logic.

The component scripts remain separated by administrative
responsibility:

• Enterprise reporting

• Account lifecycle administration

• Security group administration

• Organizational Unit administration

`Import-EnterpriseADToolkit.ps1` provides a single entry
point that loads these components into the current
PowerShell session.

This architecture preserves separation of responsibilities
while improving administrative usability.

Using `$PSScriptRoot` allows the loader to locate its
component scripts relative to its own directory instead of
depending on a hard-coded source path.

The enterprise reporting workflow required a small
architectural change before it could participate safely in
the toolkit.

Previously, loading `Get-EnterpriseADUserReport.ps1`
immediately executed the reporting workflow.

Refactoring the workflow into the
`Get-EnterpriseADUserReport` function separated loading
from execution.

The administrator can now load the toolkit without
automatically generating a report and explicitly execute
the reporting function when required.

Testing also identified and corrected a missing opening
comment marker in the reporting script before successful
toolkit loading.

The parser error was investigated from PowerShell output,
the affected source was inspected, the malformed
comment-based help block was corrected in the authoritative
Git repository source, and the corrected script was
transferred back to AD-DC-01 for verification.

Final verification confirmed that the toolkit loads without
output, exposes 16 reusable enterprise administration
functions, and preserves the previously verified enterprise
user reporting behavior.

The completed 08C-06 implementation demonstrates how
independently developed administrative automation can be
organized into a coherent toolkit without sacrificing
modularity, verification, or administrator control.