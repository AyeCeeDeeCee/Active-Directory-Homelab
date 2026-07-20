
# Phase 4 – Domain Controller Promotion

## Project Metadata

| Property | Value |
|----------|-------|
| Project | Active Directory Homelab |
| Author | Coach Torres |
| Platform | Windows Server 2022 Evaluation |
| Virtualization | Oracle VirtualBox |
| Domain | coachtorres.local |
| Status | Completed |
| Documentation Status | Backfilled |

---

# Objective

Promote the Windows Server 2022 virtual machine to the first Domain Controller in a new Active Directory forest. This establishes centralized authentication, authorization, directory services, and DNS for the lab environment.

---

# Lab Environment

- Host Operating System: Windows 11 Pro
- Hypervisor: Oracle VirtualBox
- Guest OS: Windows Server 2022 Evaluation
- Server Name: AD-DC-01
- Domain Name: coachtorres.local

---

# Architecture Overview

The server was promoted from a standalone Windows Server installation to the first Domain Controller in a brand-new Active Directory forest.

This promotion enabled:

- Active Directory Domain Services (AD DS)
- DNS Server
- Centralized authentication
- Domain-based administration
- Organizational Units
- User and Group management

The Domain Controller became the authoritative identity source for the lab.

---

# Prerequisites

Before promotion, the following tasks were completed:

- Windows Server installed
- Initial server configuration completed
- Static networking configured
- Server Manager operational
- Active Directory Domain Services role installed
- DNS Server role installed

---

# Implementation Summary

The Active Directory Domain Services Configuration Wizard was used to promote the server to a Domain Controller.

Configuration included:

- Creating a new Active Directory forest
- Creating the root domain:
  coachtorres.local
- Installing DNS during promotion
- Configuring Directory Services Restore Mode (DSRM)
- Completing prerequisite validation
- Rebooting the server to finalize promotion

After the reboot, the server functioned as the first Domain Controller for the environment.

---

# Validation

Although screenshots of the promotion wizard were not captured during implementation, successful promotion was verified through later administrative tasks.

Validation included:

- Successful login using domain credentials
- Active Directory Users and Computers available
- Domain "coachtorres.local" present
- Organizational Units successfully created
- User accounts successfully created
- Security Groups successfully created
- DNS functioning correctly

These later phases confirm the Domain Controller promotion completed successfully.

---

# Evidence

Supporting screenshots include:

- Server-Manager-AD-DS-DNS-Installed.png
- Add-Roles-And-Features.png
- AD-Created-Users.png
- AD-Created-Groups.png

These screenshots demonstrate the successful deployment and continued operation of Active Directory after promotion.

---

# Lessons Learned

- Capturing screenshots during each implementation phase improves documentation quality.
- Domain Controller promotion represents the transition from a standalone Windows server to centralized enterprise identity management.
- DNS is a critical dependency for Active Directory.
- Successful validation through later administrative tasks can provide trustworthy evidence when implementation screenshots are unavailable.

---

# Next Phase

Phase 5 – Domain Join

The next phase adds Windows client computers to the coachtorres.local domain so they can authenticate against the Domain Controller and receive centralized management through Active Directory.
