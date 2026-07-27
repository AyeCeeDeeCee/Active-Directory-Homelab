
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
| **Last Updated** | 2026-07-26 |

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

The complete PowerShell audit commands, command explanations, audit findings, and verification process for Phase 08A are documented separately:

- [Active Directory Audit PowerShell Commands](ActiveDirectory-Audit-PowerShell-Commands.md)

This supporting document contains the detailed read-only audit procedures used to validate the Active Directory environment before any administrative or automation tasks were performed.

---

## Phase 08B – Respond

The second stage focuses on routine Active Directory administration through PowerShell.

Typical administrative tasks include:

- Resetting passwords
- Unlocking user accounts
- Enabling and disabling accounts
- Updating user attributes
- Managing security group memberships
- Moving users between Organizational Units

These activities represent common Help Desk and Systems Administration responsibilities performed within enterprise environments.

---

## Phase 08C – Automate

After developing confidence administering Active Directory through PowerShell, automation is introduced to reduce repetitive operational tasks.

Planned automation includes:

- Bulk user provisioning
- Bulk security group creation
- Bulk Organizational Unit creation
- Active Directory reporting
- Account lifecycle automation

Automation is introduced only after the administrative processes have been understood and validated.

---

## Lessons Learned

PowerShell should be introduced after administrators understand the environment they are responsible for managing.

Beginning with read-only auditing establishes confidence in the environment before administrative changes are made.

Building automation on top of verified administrative processes produces safer, more reliable enterprise solutions.

---

## Enterprise Notes

The Active Directory environment created during earlier phases remains the source of truth throughout Phase 08.

The five manually created enterprise users continue to represent existing production accounts and are administered through PowerShell rather than recreated through automation.

Bulk provisioning scripts introduced during this phase are intended to demonstrate repeatable onboarding workflows for future users while preserving the integrity of the existing enterprise environment.

---

## Evidence

This phase includes evidence demonstrating:

- PowerShell audit commands
- Active Directory verification
- Administrative PowerShell commands
- Automation scripts
- Validation of completed tasks

Screenshots and supporting evidence are stored within the project's `screenshots` directory.

---

## References

- Microsoft Learn – PowerShell Documentation
- Microsoft Learn – Active Directory PowerShell Module
- Microsoft Learn – Active Directory Administration
- Active Directory Homelab Engineering Contract
- Active Directory Homelab GitHub Repository
