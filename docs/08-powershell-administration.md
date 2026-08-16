
# Phase 08 – PowerShell Administration

## Project Metadata

| Field | Value |
|--------|-------|
| **Project** | Active Directory Homelab |
| **Repository** | Active-Directory-Homelab |
| **Phase** | 08 – PowerShell Administration |
| **Document** | 08-powershell-administration.md |
| **Platform** | Windows Server 2022 |
| **Domain** | coachtorres.local |
| **Author** | Coach Torres |
| **Status** | In Progress |
| **Last Updated** | 2026-08-16 |

---

## Table of Contents

1. Objective
2. Prerequisites
3. Phase Roadmap
4. What is PowerShell?
5. Why Organizations Use PowerShell
6. PowerShell in an Existing Enterprise
7. Phase 08A – Observe
8. Phase 08B – Respond
9. Phase 08C – Automate
10. Lessons Learned
11. Enterprise Notes
12. Evidence
13. References

---

## Objective

The objective of this phase is to introduce Microsoft PowerShell into an existing Active Directory environment and demonstrate how enterprise administrators transition from manual administration to PowerShell-driven administration and automation.

Rather than replacing the work completed during earlier phases, PowerShell builds upon the existing Active Directory infrastructure by providing a consistent method for auditing, administering, and automating common operational tasks.

This phase mirrors how many organizations adopt PowerShell in production environments—first by understanding the existing environment, then by performing routine administrative tasks, and finally by automating repetitive processes.

---

## Prerequisites

Before completing this phase, the following components were successfully deployed and verified:

- Windows Server 2022 installed
- Active Directory Domain Services (AD DS) installed
- Domain controller promoted
- Domain joined Windows client
- Organizational Units (OUs) created
- Users and security groups created
- Group Policy baseline implemented
- Password Policy configured
- Account Lockout Policy configured
- Kerberos Policy configured
- Active Directory environment operational

These prerequisites provide the enterprise environment required to safely administer Active Directory through PowerShell.

---

## Phase Roadmap

This phase consists of the following objectives:

| Objective | Description |
|-----------|-------------|
| **08.01** | Bulk User Creation using CSV |
| **08.02** | Bulk Group Creation |
| **08.03** | Bulk Organizational Unit Creation |
| **08.04** | Disable Stale Accounts |
| **08.05** | Password Reset Automation |
| **08.06** | Unlock User Accounts |
| **08.07** | Search and Query Active Directory |
| **08.08** | Export Active Directory Users |
| **08.09** | Generate Active Directory Reports |

As the phase evolves, supporting documentation may be added to document major PowerShell workflows and enterprise administration tasks while maintaining a modular documentation structure.

---

## What is PowerShell?

Microsoft PowerShell is Microsoft's task automation and configuration management framework built on the .NET platform.

Unlike graphical administration tools, PowerShell allows administrators to manage Windows systems through reusable commands, scripts, and automation workflows.

PowerShell combines a command-line interface with a powerful scripting language, enabling administrators to perform tasks consistently across individual systems or entire enterprise environments.

Within Active Directory, PowerShell provides administrators with the ability to query directory information, modify objects, automate repetitive tasks, and generate reports that would otherwise require significant manual effort.

---

## Why Organizations Use PowerShell

Organizations adopt PowerShell to:

- Standardize administrative processes
- Reduce repetitive manual work
- Improve consistency across environments
- Automate common operational tasks
- Generate reports and audits
- Reduce configuration drift
- Improve operational efficiency
- Support enterprise-scale administration

As Active Directory environments grow, automation becomes increasingly valuable for maintaining consistency while reducing administrative overhead.

---

## PowerShell in an Existing Enterprise

This project intentionally introduces PowerShell after the Active Directory environment has already been built through graphical administration tools.

The existing Organizational Units, users, security groups, and Group Policy Objects remain the production environment being administered.

PowerShell is used to extend that environment—not recreate it.

This approach reflects how many organizations gradually introduce automation into mature enterprise environments while preserving existing infrastructure.

---

## Phase 08A – Observe

The first stage of PowerShell administration focuses on understanding the existing Active Directory environment before making changes.

During this stage, PowerShell was used to audit and verify:

- Active Directory users
- Organizational Units
- Security groups
- Domain information
- Computer objects
- Account status
- Password information
- Group memberships

These audits established a verified baseline of the enterprise environment and confirmed that the Active Directory implementation from previous phases remained consistent.

No production objects were modified during this stage.

### Supporting Documentation

The complete audit command log for Phase 08A is documented
separately:

- [Phase 08A – Audit PowerShell Commands](Phase-08A-Audit-PowerShell-Commands.md)

This document contains the complete read-only audit,
verification commands, and command output used to establish
the Active Directory baseline before administrative changes
were performed.

---

## Phase 08B – Respond

The second stage focused on performing routine Active
Directory administration using PowerShell against the
existing enterprise environment.

Completed administrative activities included:

- Moving computer objects
- Updating user attributes
- Managing security group memberships
- Forcing password changes
- Resetting user passwords
- Disabling and enabling user accounts
- Investigating and correcting account lockout policy
- Unlocking user accounts
- Performing a controlled employee transfer

Every administrative action was verified immediately after
execution to confirm the expected Active Directory state.

### Supporting Documentation

The complete operational command log for Phase 08B is
documented separately:

- [Phase 08B – PowerShell Administration Log](Phase-08B-PowerShell-Administration-Log.md)

This document contains the verified PowerShell commands,
administrative workflow, observations, and validation
performed throughout Phase 08B.

---

## Phase 08C – Automate

Phase 08C introduces reusable PowerShell automation into the
existing Active Directory environment.

Automation builds upon the observation and administrative
experience developed during Phases 08A and 08B by converting
verified administrative procedures into reusable PowerShell
workflows.

The canonical `coachtorres.local` Active Directory
environment remains the primary proof-of-work environment.

Automation is developed incrementally against existing
enterprise users, security groups, and Organizational Units
rather than replacing the administrative experience
established during earlier phases.

### Automation Engineering Workflow

PowerShell source code is developed and maintained within
the local Git repository using Visual Studio Code.

Completed scripts are transferred to AD-DC-01 for execution
and verification against the canonical Active Directory
environment.

The Git repository remains the authoritative source of
PowerShell code while AD-DC-01 remains the execution and
verification environment.

The automation workflow follows the project's established
engineering process:

```text
Develop
    ↓
Transfer
    ↓
Execute
    ↓
Verify
    ↓
Capture
    ↓
Interpret

---

### Completed Automation Objectives

#### 08C-02 – Enterprise Reporting

Implemented and verified:

`Get-EnterpriseADUserReport.ps1`

The reporting workflow retrieves enterprise user
information including account identity, department,
enabled status, security group membership, and
Organizational Unit placement.

#### 08C-03 – Account Lifecycle Automation

Implemented and verified:

`Manage-EnterpriseUser.ps1`

Reusable functions provide verified workflows for
common enterprise user lifecycle administration.

#### 08C-04 – Security Group Administration

Implemented and verified:

`Manage-EnterpriseGroup.ps1`

Reusable functions provide security group membership
review, membership testing, controlled membership
modification, and enterprise group reporting.

#### 08C-05 – Organizational Unit Administration

Implemented and verified:

`Manage-EnterpriseOU.ps1`

Reusable functions provide Organizational Unit review,
Active Directory object-placement identification,
placement verification, controlled object movement, and
enterprise OU reporting.

A controlled and reversible test moved WIN11-01 from the
Workstations OU to the Lab OU and returned the computer
to Workstations after successful verification.

Final reporting confirmed that the canonical Active
Directory object-placement baseline was preserved.

## 08C-06 – Administrative Toolkit

### Objective

Consolidate the reusable PowerShell automation developed
during Phase 08C into a practical Active Directory
administrative toolkit while preserving modularity,
verification, and administrator control.

### Implementation

Created and verified:

`Import-EnterpriseADToolkit.ps1`

The toolkit provides a single entry point for loading the
verified Phase 08C PowerShell administration components:

• `Get-EnterpriseADUserReport.ps1`

• `Manage-EnterpriseUser.ps1`

• `Manage-EnterpriseGroup.ps1`

• `Manage-EnterpriseOU.ps1`

The loader uses `$PSScriptRoot` and PowerShell dot-sourcing
to load each component relative to the toolkit location
without merging the independently verified scripts into a
single monolithic file.

The enterprise reporting workflow was refactored into the
reusable `Get-EnterpriseADUserReport` function so the
reporting component can be loaded without automatically
executing a report.

### Testing and Verification

The toolkit was transferred to AD-DC-01 and successfully
loaded into the current PowerShell session.

Verification confirmed that:

• Toolkit loading completed without automatic execution.

• Reporting, account administration, security group
  administration, and Organizational Unit administration
  functions were available within the same PowerShell
  session.

• `Get-EnterpriseADUserReport` preserved the previously
  verified enterprise reporting behavior after refactoring.

• `Get-Command *Enterprise*` returned 16 reusable enterprise
  administration functions.

The completed toolkit demonstrates how independently
verified PowerShell administration workflows can be
organized behind a single administrative entry point while
preserving separation of responsibilities.

## 08C-07 – Bulk User Provisioning

### Objective

Review, harden, and validate the existing CSV-driven
Active Directory bulk user provisioning workflow while
preserving its purpose as an optional supporting learner
asset.

The workflow remains separate from the canonical enterprise
automation and must not recreate, replace, or overwrite the
five canonical enterprise users.

### Implementation

Reviewed and updated:

`Create-BulkADUsers.ps1`

The existing script was preserved rather than redesigned.

Targeted safeguards were added to improve the safety and
repeatability of the learner provisioning workflow:

• Required username validation.

• Existing-user detection using `Get-ADUser -Filter`.

• Required CSV field validation.

• Target Organizational Unit validation.

• Controlled `New-ADUser` execution using `try/catch` and
`-ErrorAction Stop`.

• Post-provisioning Active Directory verification.

The script continues to import provisioning data from:

`users.csv`

The repository copy of `users.csv` remains intentionally
empty so learners cloning the repository can define their
own provisioning dataset without receiving pre-populated
enterprise identities.

The expected CSV schema is:

`FirstName,LastName,Username,Department,Password,OU`

The provisioning password remains a plaintext CSV field for
the controlled homelab learning scenario and is converted
to a SecureString before being supplied to `New-ADUser`.

Provisioned accounts are configured with
`ChangePasswordAtLogon` enabled.

### Testing and Verification

PowerShell parser validation was performed on AD-DC-01
before executing the provisioning workflow.

The parser returned no syntax errors.

A temporary non-canonical test account was used for
controlled verification:

• Name: Jordan Test

• SamAccountName: `jtest`

• Department: Lab

• Target OU: `OU=Employees,DC=coachtorres,DC=local`

Pre-provisioning verification confirmed that `jtest` did
not already exist.

`Create-BulkADUsers.ps1` was then executed against the
temporary verification dataset.

The script reported successful account creation and
post-provisioning verification.

Independent Active Directory verification confirmed:

• Name: Jordan Test

• SamAccountName: `jtest`

• Department: Lab

• Enabled: True

• Distinguished Name:
`CN=Jordan Test,OU=Employees,DC=coachtorres,DC=local`

The temporary account was subsequently removed.

Independent post-removal verification confirmed that
`jtest` no longer existed.

`Get-EnterpriseADUserReport` was then executed using the
previously verified administrative toolkit.

The report confirmed that the five canonical enterprise
users remained present with their expected security group
memberships and Organizational Unit placement.

The controlled provisioning test therefore completed
without introducing a permanent change to the canonical
Active Directory environment.

### Engineering Discovery

Testing demonstrated an important distinction between
`Get-ADUser -Identity` and `Get-ADUser -Filter` when
performing existence checks.

`Get-ADUser -Identity` produced an
`ADIdentityNotFoundException` when the prospective test
identity did not exist.

Using `Get-ADUser -Filter` allowed the provisioning
workflow to treat zero matching users as an empty result,
making it better suited to the pre-provisioning duplicate
user check used by this learner workflow.

The verification also reinforced the distinction between
generic learner provisioning and canonical enterprise
baseline recreation.

Bulk provisioning provides a repeatable onboarding
exercise for learner-defined identities.

Recreation of the canonical enterprise environment remains
a separate engineering responsibility for Phase 08C-08.

### Evidence

Captured evidence:

• `Phase08C-07-BUP-Vfd-Screenshot 2026-08-16 104759.png`

• `Phase08C-07-BUP-Cleanup-Vfd-Screenshot 2026-08-16 105708.png`

• `Phase08C-07-Usr-Ste-Vfd-Screenshot 2026-08-16 110233.png`

Evidence demonstrates:

• Controlled CSV-driven user provisioning.

• Successful creation of a temporary non-canonical user.

• Independent verification of account attributes and
Organizational Unit placement.

• Controlled removal of the temporary verification account.

• Independent verification of account removal.

• Preservation of the canonical enterprise user state
after bulk-provisioning validation.

---

## Lessons Learned

PowerShell administration should begin with verification.

Read-only auditing establishes a trusted baseline before
administrative changes are introduced.

Reusable PowerShell functions can convert validated
administrative procedures into repeatable workflows while
preserving administrator control over execution.

Dot-sourcing allows functions defined within a PowerShell
script to remain available within the current interactive
PowerShell session.

Administrative automation should verify the resulting
Active Directory state rather than assuming that a command
completed as intended.

Controlled and reversible changes provide a practical way
to test modifying automation while preserving an established
enterprise baseline.

Active Directory object identity and object location should
be treated as separate concepts during automation.

An object's Distinguished Name changes when the object is
moved between Organizational Units, while its ObjectGUID
remains stable and can be used for reliable post-move
verification.

Capturing verified command output creates an operational
record that can later be interpreted for documentation and
portfolio purposes.

Separating operational logs from portfolio documentation
improves maintainability, preserves implementation detail,
and reduces documentation drift.

Reusable administrative automation does not require
combining every workflow into a single monolithic script.
A lightweight loader can provide one administrative entry
point while preserving separation of responsibilities
across independently maintained components.

Separating PowerShell function definition from execution
allows automation components to be loaded safely into an
interactive administrative session and executed only when
the administrator intentionally invokes them.

CSV-driven provisioning workflows should validate required
input data, existing identities, and target Organizational
Units before attempting to create Active Directory objects.

Active Directory existence checks should use query behavior
appropriate to the intended result. During bulk provisioning,
`Get-ADUser -Filter` allows a missing prospective identity to
return an empty result, while `Get-ADUser -Identity` expects
the specified identity to exist and can produce an
`ADIdentityNotFoundException` when it does not.

---

## Enterprise Notes

The Active Directory environment created during earlier phases remains the source of truth throughout Phase 08.

The five manually created enterprise users continue to represent existing production accounts and are administered through PowerShell rather than recreated through automation.

---

## Evidence

This phase includes evidence demonstrating:

- Active Directory audit commands
- Administrative PowerShell commands
- PowerShell automation scripts
- Active Directory verification
- Group Policy configuration
- Validation of completed tasks
- Visual Studio Code development environment
- Git source control integration

Supporting screenshots and additional evidence are stored within the project's
[`screenshots`](../screenshots/) directory.

### Phase 08A Screenshots

The following screenshots document the development environment and implementation
used throughout Phase 08A:

| Evidence | Description |
|----------|-------------|
| [VS Code Installation](../screenshots/VSCode-Install-Screenshot%202026-07-24%20074235.png) | Visual Studio Code installation via Winget. |
| [VS Code Version](../screenshots/Vscode-Version-Screenshot%202026-07-24%20075444.png) | Verification of the Visual Studio Code installation using `code --version`. |
| [VS Code Workspace](../screenshots/VSCode-Downloaded-Screenshot%202026-07-24%20105527.png) | Active Directory Homelab repository opened in Visual Studio Code. |
| [PowerShell Script](../screenshots/VSCode-Script-Screenshot%202026-07-24%20110444.png) | Initial implementation of `Create-BulkADUsers.ps1`. |
| [Project Structure](../screenshots/VSCode-File-Tree-Screenshot%202026-07-24%20111949.png) | Repository structure for the Active Directory Homelab project. |
| [Source Control](../screenshots/VSCode-Screenshot%202026-07-24%20113425.png) | Git Source Control integration within Visual Studio Code. |
| [Development Environment](../screenshots/VSCode-final-Screenshot%202026-07-24%20144924.png) | Completed Phase 08A Visual Studio Code development environment. |

### Phase 08B Screenshots

The following screenshots document the administrative tasks and policy
configuration completed throughout Phase 08B:

| Evidence | Description |
|----------|-------------|
| [Account Lockout Threshold Configuration](../screenshots/GPMC-Lkt-thd-Screenshot%202026-07-28%20174849.png) | Group Policy Management Console showing the Account Lockout Threshold configured within the Default Domain Policy. |
| [Account Lockout Policy Applied](../screenshots/GPMC-Lkt-Apy-Screenshot%202026-07-28%20175126.png) | Group Policy Management Console showing the completed Account Lockout Policy configuration after applying the required settings. |

### Phase 08C Screenshots

The following screenshots document the PowerShell automation
development and verification completed during Phase 08C:

| Evidence | Description |
| --- | --- |
| [Security Group Administration Script](../screenshots/Phase08C-04-VSC-Script-Screenshot%202026-08-09%20092157.png) | Visual Studio Code implementation of `Manage-EnterpriseGroup.ps1` within the local Git repository development environment. |
| [Enterprise Group Report Verification](../screenshots/Phase08C-04-Entr-Grp-Rpt-Vrfd-Screenshot%202026-08-09%20092003.png) | AD-DC-01 PowerShell verification showing the loaded security group administration function and the final verified enterprise group-membership report. |
| [Organizational Unit Administration Script](../screenshots/Phase08C-05-VSC-Spt-Screenshot%202026-08-09%20140439.png) | Visual Studio Code implementation of `Manage-EnterpriseOU.ps1` within the local Git repository development environment. |
| [Enterprise OU Report Verification](../screenshots/Phase08C-05-OU-Rpt-Vfd-Screenshot%202026-08-09%20140321.png) | AD-DC-01 PowerShell verification showing the loaded Organizational Unit administration function and the final verified enterprise OU object-placement report. |
| [Administrative Toolkit Script](../screenshots/Phase08C-06-VSC-Ipt-Tkt-Screenshot%202026-08-09%20220656.png) | Visual Studio Code implementation of `Import-EnterpriseADToolkit.ps1`, showing the single toolkit entry point and the four reusable Phase 08C automation components. |
| [Administrative Toolkit Verification](../screenshots/Phase08C-06-Get-Cmd-Screenshot%202026-08-09%20220402.png) | AD-DC-01 PowerShell verification showing successful toolkit loading, execution of the enterprise user report, and availability of the complete 16-function enterprise administrative toolkit. |
| [Bulk User Provisioning Verification](../screenshots/Phase08C-07-BUP-Vfd-Screenshot%202026-08-16%20104759.png) | AD-DC-01 PowerShell verification showing successful CSV-driven creation of the temporary `jtest` account and independent verification of the account name, SamAccountName, department, enabled status, and Organizational Unit placement. |
| [Bulk User Provisioning Cleanup Verification](../screenshots/Phase08C-07-BUP-Cleanup-Vfd-Screenshot%202026-08-16%20105708.png) | AD-DC-01 PowerShell verification showing controlled removal of the temporary `jtest` account and subsequent confirmation that the account no longer existed. |
| [Canonical User State Verification](../screenshots/Phase08C-07-Usr-Ste-Vfd-Screenshot%202026-08-16%20110233.png) | AD-DC-01 PowerShell verification using `Get-EnterpriseADUserReport`, confirming that the five canonical enterprise users, expected security group memberships, and Organizational Unit placement remained intact after the controlled bulk provisioning test. |

---

## References

- Microsoft Learn – PowerShell Documentation
- Microsoft Learn – Active Directory PowerShell Module
- Microsoft Learn – Active Directory Administration
- Active Directory Homelab Engineering Contract
- Active Directory Homelab GitHub Repository
