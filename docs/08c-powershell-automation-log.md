
# Phase 08C – PowerShell Automation Log

## Project Metadata

| Field | Value |
|--------|-------|
| **Project** | Active Directory Homelab |
| **Repository** | Active-Directory-Homelab |
| **Phase** | 08 – PowerShell Administration |
| **Stage** | 08C – Automate |
| **Document** | 08c-powershell-automation-log.md |
| **Platform** | Windows Server 2022 |
| **Domain** | coachtorres.local |
| **Author** | Coach Torres |
| **Status** | In Progress |
| **Last Updated** | 2026-08-24 |

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
9. 08C-09 – Documentation & Publication

## Repository Information

| Field | Value |
|--------|-------|
| **Current Branch** | master |
| **Repository Location** | docs/ |
| **Primary Script Location** | scripts/phase-08-powershell-administration/ |
| **Document Type** | Implementation Log |
| **Current Engineering Focus** | Complete Phase 08C documentation, evidence, repository, and publication review |

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

- `screenshots/Phase08C-02-VS-Ent-Rpt-Screenshot 2026-08-03 095715.png`
- `screenshots/Phase08C-02-Ent-Rpt-Screenshot 2026-08-03 095535.png`
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

- `screenshots/Phase08C-03-VSC-Entr-Usr-Screenshot 2026-08-04 153825.png`
- `screenshots/Phase08C-03-Auto-Log-Screenshot 2026-08-04 154511.png`
- PowerShell command history captured.
- Console output verified.

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

---

## 08C-07 – Bulk User Provisioning

### Objective

Review, harden, and validate the existing CSV-driven Active
Directory bulk user provisioning workflow while preserving
its role as an optional supporting learner asset.

The objective was to demonstrate repeatable user
provisioning without redesigning the existing learner
workflow or modifying the established canonical enterprise
baseline.

The bulk provisioning workflow remains separate from the
enterprise administrative toolkit and from the planned
canonical baseline recreation workflow.

### Implementation

Reviewed and updated:

`Create-BulkADUsers.ps1`

Supporting learner asset:

`users.csv`

The repository copy of `users.csv` remains intentionally
empty so learners cloning the repository can define their
own provisioning dataset.

The expected CSV schema is:

`FirstName,LastName,Username,Department,Password,OU`

The existing provisioning script was preserved rather than
redesigned.

Targeted safeguards were added to improve the safety and
repeatability of the learner workflow.

Implemented safeguards include:

• Required username validation.

• Existing-user detection before account creation.

• Required CSV field validation.

• Target Organizational Unit validation.

• Controlled `New-ADUser` execution using `try/catch`.

• `-ErrorAction Stop` for controlled provisioning failures.

• Post-provisioning Active Directory verification.

The existing-user check uses:

`Get-ADUser -Filter`

This allows a prospective username that does not already
exist to return an empty result without interrupting the
provisioning workflow.

The target Organizational Unit supplied through the CSV is
validated using `Get-ADOrganizationalUnit` before account
creation is attempted.

The initial provisioning password is supplied through the
CSV and converted to a SecureString before being passed to
`New-ADUser`.

This plaintext password workflow is retained specifically
for the controlled homelab learning scenario and is not
intended to represent enterprise credential-management
practice.

Provisioned accounts are configured with:

`-ChangePasswordAtLogon $true`

The script description was also corrected to accurately
reflect the implemented behavior.

The previous description referenced automatic security
group assignment even though the script did not implement
that functionality.

The updated description now reflects user validation,
Organizational Unit placement, account creation, and
post-provisioning verification.

### Testing and Verification

The updated `Create-BulkADUsers.ps1` script was transferred
from the authoritative Git repository on the Windows host
to:

`C:\Scripts`

on AD-DC-01.

Before execution, PowerShell parser validation was performed
against the transferred script.

Parser verification returned no syntax errors.

A temporary CSV verification dataset was then created on
AD-DC-01 using a single non-canonical learner account.

Temporary verification account:

• Name: Jordan Test

• SamAccountName: `jtest`

• Department: Lab

• Target Organizational Unit:
  `OU=Employees,DC=coachtorres,DC=local`

Pre-provisioning verification confirmed that the `jtest`
account did not already exist.

During verification, `Get-ADUser -Identity jtest` produced
an `ADIdentityNotFoundException` when the prospective
identity was absent.

The existence-check design was therefore reviewed.

Testing confirmed that:

`Get-ADUser -Filter "SamAccountName -eq 'jtest'"`

returned no output when the prospective identity did not
exist.

The bulk provisioning script was updated to preserve
`Get-ADUser -Filter` for duplicate-user detection.

The corrected script was then executed against the
temporary CSV dataset.

The script reported:

`User 'jtest' created successfully.`

`Verified 'jtest' in Active Directory.`

Independent verification was then performed using
`Get-ADUser`.

Verified account state:

• Name: Jordan Test

• SamAccountName: `jtest`

• Department: Lab

• Enabled: True

• Distinguished Name:
  `CN=Jordan Test,OU=Employees,DC=coachtorres,DC=local`

This independently confirmed successful user creation,
attribute assignment, account enablement, and Organizational
Unit placement.

The temporary verification account was then identified
before removal using a read-only Active Directory query.

The account was removed using:

`Remove-ADUser -Identity jtest -Confirm:$false`

Post-removal verification using `Get-ADUser -Filter`
returned no result.

This confirmed that the temporary verification account had
been successfully removed.

The previously verified enterprise administrative toolkit
was then loaded using:

`. C:\Scripts\Import-EnterpriseADToolkit.ps1`

Toolkit loading completed with no output.

`Get-EnterpriseADUserReport` was executed to independently
verify the final canonical Active Directory state.

The report returned the five canonical enterprise users:

• Sara Chung – `schung`

• Nathan Miller – `nmiller`

• Alicia Simmons – `asimmons`

• David Martinez – `dmartinez`

• Micheal Rodriguez – `mrodriguez`

The report also confirmed the expected security group
memberships and Organizational Unit placement.

The temporary `jtest` account was absent.

Final verification confirmed that the controlled bulk
provisioning test introduced no permanent change to the
canonical enterprise environment.

### Evidence

Evidence captured during 08C-07 includes:

• Bulk user provisioning and independent account
  verification.

• Controlled removal of the temporary learner account.

• Independent verification that the temporary account no
  longer existed.

• Final canonical enterprise user-state verification using
  the previously verified administrative toolkit.

Evidence files:

• `Phase08C-07-BUP-Vfd-Screenshot 2026-08-16 104759.png`

• `Phase08C-07-BUP-Cleanup-Vfd-Screenshot 2026-08-16 105708.png`

• `Phase08C-07-Usr-Ste-Vfd-Screenshot 2026-08-16 110233.png`

### Engineering Notes

Development and source modification occurred on the Windows
host using Visual Studio Code.

Git remains the authoritative source of
`Create-BulkADUsers.ps1`.

Execution and verification occurred on AD-DC-01.

The existing learner provisioning workflow was intentionally
preserved rather than replaced with a more complex
enterprise provisioning framework.

The objective of 08C-07 was to strengthen the existing
beginner proof-of-work workflow with clear validation and
verification controls while keeping the script readable and
understandable for learners.

The intentionally empty repository copy of `users.csv`
preserves the script as a reusable learner asset without
shipping a populated identity dataset.

The canonical enterprise users were not added to the bulk
provisioning dataset and were not recreated during testing.

Duplicate-user detection provides an additional safeguard
against attempting to create identities that already exist
in Active Directory.

Testing also demonstrated an important behavioral
difference between `Get-ADUser -Identity` and
`Get-ADUser -Filter`.

`Get-ADUser -Identity` expects the requested identity to
exist and produced an `ADIdentityNotFoundException` during
the pre-provisioning test.

`Get-ADUser -Filter` was better suited to this workflow
because an absent prospective username could be represented
as an empty result and handled intentionally by the script.

This discovery reinforced the importance of selecting
PowerShell query behavior based on the administrative
operation being performed rather than assuming equivalent
behavior between cmdlet parameter sets.

The controlled verification scenario also reinforced the
Phase 08 engineering standard of independently verifying
resulting Active Directory state after modifying operations.

Successful script output alone was not treated as sufficient
proof of account creation.

The newly created account was independently queried,
verified, removed, and independently confirmed absent.

The canonical enterprise user report was then reused to
confirm that the established Active Directory baseline
remained intact.

Bulk user provisioning remains a supporting learner
workflow.

Canonical enterprise baseline recreation remains a separate
engineering responsibility for 08C-08.

---

## 08C-08 – Enterprise Active Directory Infrastructure Baseline Recreation

### Objective

Develop and validate a reusable PowerShell workflow for
recreating the enterprise Active Directory infrastructure
baseline in a clean deployment.

The objective focuses on infrastructure required to support
subsequent Active Directory operational lifecycle activities.

The recreation workflow establishes the enterprise
Organizational Unit structure, Organizational Unit protection
settings, security groups, security group configuration, and
required security group placement.

Employee identity provisioning, security group membership
assignment, workstation domain joining, and workstation
placement are intentionally treated as separate operational
lifecycle responsibilities.

The implementation must also protect the existing canonical
Active Directory environment from accidental recreation or
modification during validation.

### Implementation

Created:

`Recreate-EnterpriseADBaseline.ps1`

Created supporting validation harness:

`Test-EnterpriseADBaselineRecreation.ps1`

`Recreate-EnterpriseADBaseline.ps1` provides the production
workflow for recreating the enterprise Active Directory
infrastructure baseline in a clean deployment.

The recreation workflow defines and creates the following
enterprise Organizational Units:

• Admin

• Employees

• Groups

• Lab

• Service Accounts

• Workstations

Each Organizational Unit is configured with protection from
accidental deletion enabled.

The workflow also defines and creates the following enterprise
security groups:

• Accounting

• HR

• IT

• Managers

Each group is configured as a Global Security group and is
placed within the Groups Organizational Unit.

Before infrastructure creation begins, the script imports the
Active Directory PowerShell module and verifies that an Active
Directory domain can be detected.

An existing-infrastructure safety check then searches for the
defined enterprise Organizational Units and security groups.

If any of the expected infrastructure objects already exist,
the recreation workflow is blocked before modifying operations
begin.

The script performs verification after Organizational Unit
creation and security group creation.

A final infrastructure verification independently confirms
the expected Organizational Unit names, Distinguished Names,
accidental-deletion protection settings, security group names,
SamAccountNames, group scopes, group categories, and security
group Distinguished Names.

`Test-EnterpriseADBaselineRecreation.ps1` provides an isolated
validation harness for testing the infrastructure recreation
logic without modifying the existing enterprise infrastructure.

The harness creates the temporary root Organizational Unit:

`08C-Recreation-Test`

The six test Organizational Units are created beneath this
temporary root, and four uniquely named test security groups
are created within its isolated Groups Organizational Unit.

The test harness performs creation verification and final
infrastructure verification before beginning controlled cleanup.

After successful verification, the temporary security groups,
child Organizational Units, and test root Organizational Unit
are removed.

Post-cleanup verification confirms that the temporary test
infrastructure no longer exists.

### Testing and Verification

Validation was performed on the existing Active Directory
domain controller using the isolated recreation test harness.

Before execution, the PowerShell parser was used to verify
that the test harness contained no syntax errors.

The script structure was also reviewed to confirm the presence
of the expected creation, verification, cleanup, and
post-cleanup operations.

The isolated test harness was then executed:

`C:\Scripts\Test-EnterpriseADBaselineRecreation.ps1`

Execution successfully created the temporary test root
Organizational Unit:

`08C-Recreation-Test`

The following child Organizational Units were successfully
created and verified:

• Admin

• Employees

• Groups

• Lab

• Service Accounts

• Workstations

The following isolated test security groups were successfully
created and verified:

• Accounting-08C

• HR-08C

• IT-08C

• Managers-08C

PowerShell reported:

`ENTERPRISE INFRASTRUCTURE RECREATION TEST VERIFIED`

The test harness then performed controlled cleanup.

All four temporary security groups were removed.

All six temporary child Organizational Units were removed.

The temporary `08C-Recreation-Test` root Organizational Unit
was then removed.

Post-cleanup verification reported:

`TEST ENVIRONMENT CLEANUP VERIFIED`

The completed test demonstrated the full infrastructure
recreation lifecycle:

`Create → Verify → Validate → Remove → Verify Cleanup`

The existing enterprise infrastructure was not modified
during isolated validation.

### Evidence

The following screenshots document the 08C-08 implementation
and isolated validation workflow.

#### Infrastructure Recreation Script

`Rcte-Epe-Bse-Screenshot 2026-08-23 194619.png`

Documents the completed
`Recreate-EnterpriseADBaseline.ps1` implementation in VS Code.

The screenshot provides source-level evidence of the enterprise
Active Directory infrastructure recreation workflow developed
for 08C-08.

#### Isolated Test Harness

`Test-Epe-Spt-Screenshot 2026-08-23 194356.png`

Documents the completed
`Test-EnterpriseADBaselineRecreation.ps1` validation harness
in VS Code.

The screenshot provides source-level evidence of the isolated
testing workflow used to validate infrastructure recreation
without modifying the existing enterprise infrastructure.

#### Recreation Test and Cleanup Verification

`Tst-Epe-Vfd-Screenshot 2026-08-23 195055.png`

Documents successful PowerShell execution of the isolated
infrastructure recreation test.

The captured output verifies:

• Temporary test root OU creation

• Six child OU creations and verifications

• Four test security group creations and verifications

• Successful final infrastructure verification

• Controlled removal of the four test security groups

• Controlled removal of the six child OUs

• Removal of the temporary test root OU

• Successful post-cleanup verification

The final PowerShell output confirms:

`ENTERPRISE INFRASTRUCTURE RECREATION TEST VERIFIED`

and:

`TEST ENVIRONMENT CLEANUP VERIFIED`

The evidence demonstrates that the temporary infrastructure
could be created, independently verified, removed, and verified
as removed while leaving the existing enterprise infrastructure
unchanged.

### Engineering Outcome

08C-08 established a clear separation between Active Directory
infrastructure deployment and ongoing identity and endpoint
lifecycle administration.

The original baseline recreation concept was evaluated against
the operational responsibilities already implemented throughout
Phase 08C.

That review identified that employee provisioning, security
group membership assignment, workstation domain joining, and
workstation placement should not be embedded within the
infrastructure recreation workflow.

Those activities represent operational lifecycle processes
performed after the underlying Active Directory infrastructure
has been established.

The final 08C-08 architecture therefore defines the enterprise
infrastructure baseline as:

• Organizational Unit structure

• Organizational Unit protection settings

• Security group creation

• Security group scope and category configuration

• Security group placement

This separation prevents the infrastructure recreation workflow
from duplicating responsibilities already represented by the
Phase 08C administration and provisioning workflows.

The production recreation script also implements a defensive
safety boundary.

Before creating infrastructure, the script searches for the
expected enterprise Organizational Units and security groups.

If existing baseline infrastructure is detected, execution is
blocked before recreation begins.

Because the existing `coachtorres.local` environment already
contains the enterprise infrastructure, destructive production
testing was intentionally avoided.

Instead, an isolated validation harness was developed to reproduce
the infrastructure hierarchy beneath a temporary test root OU.

This allowed the same fundamental Active Directory creation and
verification operations to be exercised without deleting,
replacing, or modifying the established enterprise baseline.

The validation harness additionally implemented controlled
cleanup and post-cleanup verification, demonstrating that the
temporary test infrastructure could be safely removed after
successful validation.

08C-08 therefore demonstrates more than Active Directory object
creation.

It demonstrates infrastructure modeling, defensive automation,
environment isolation, independent verification, controlled
cleanup, and separation of infrastructure deployment from
operational lifecycle administration.

### Lessons Learned

Infrastructure recreation and operational administration are
related Active Directory responsibilities, but they should not
automatically be treated as the same automation problem.

Separating the enterprise infrastructure baseline from employee
and workstation lifecycle operations produced a clearer and more
reusable recreation model.

The implementation reinforced the importance of validating the
current environment before performing modifying operations.

A recreation script should not assume that its target environment
is empty simply because it was designed for clean deployment.

Explicit detection of existing infrastructure provides a safety
boundary that reduces the risk of accidental duplicate creation
or modification of an established environment.

The isolated test harness demonstrated the value of validating
potentially destructive infrastructure automation without
requiring destruction of the working enterprise baseline.

Using a temporary parent Organizational Unit created a controlled
namespace in which the infrastructure hierarchy could be created,
verified, and removed independently.

Verification also proved to be a separate engineering concern
from creation.

Successful execution of `New-ADOrganizationalUnit` or
`New-ADGroup` alone does not prove that the resulting object
matches the intended infrastructure state.

The workflow therefore verifies object identity, placement,
configuration, and protection settings after creation.

Finally, cleanup requires the same level of verification as
deployment.

The test was not considered complete when the temporary objects
were removed. Post-cleanup validation was used to confirm that
the isolated test infrastructure no longer existed.

### Current State

08C-08 enterprise Active Directory infrastructure baseline
recreation implementation is complete.

`Recreate-EnterpriseADBaseline.ps1` defines the clean-deployment
workflow for recreating the enterprise Organizational Unit and
security group infrastructure baseline.

`Test-EnterpriseADBaselineRecreation.ps1` provides an isolated
validation harness for exercising the infrastructure recreation
logic without modifying the existing enterprise baseline.

The isolated test successfully demonstrated:

• Temporary infrastructure creation

• Organizational Unit verification

• Security group verification

• Final infrastructure verification

• Controlled test-environment cleanup

• Post-cleanup verification

The existing enterprise Active Directory environment and
WIN11-01 remained unchanged during validation.

08C-08 documentation and repository publication are complete.

The implementation was committed in:

54e63f7

Commit message:

Implement Phase 08C enterprise infrastructure recreation

---

## 08C-09 – Documentation & Publication

### Objective

Perform the final Phase 08C documentation, evidence,
repository, and publication review required to close
the Automate stage.

The objective is to reconcile the completed engineering
work from 08C-01 through 08C-08, correct documentation
gaps discovered during final review, verify published
automation and evidence assets, and prepare Phase 08C
for final repository publication and transition to
Phase 09 – Security Hardening.
