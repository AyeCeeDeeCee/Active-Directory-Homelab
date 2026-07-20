# 06 - Organizational Units (OUs)

## Project Metadata

| Property | Value |
|----------|-------|
| **Project** | Active Directory Homelab |
| **Repository** | Active-Directory-Homelab |
| **Document** | 06-organizational-units.md |
| **Phase** | 06 - Organizational Units |
| **Status** | ✅ Complete |
| **Author** | Coach Torres |
| **Environment** | Windows Server 2022 |
| **Hostname** | AD-DC-01 |
| **Domain** | coachtorres.local |
| **Last Updated** | 2026-07-20 |

---

# Objective

Design and implement a logical Organizational Unit (OU) structure within the Active Directory domain. This organizational hierarchy serves as the foundation for user management, security groups, Group Policy Objects (GPOs), workstation administration, and future enterprise scalability.

---

# Overview

In enterprise Active Directory environments, Organizational Units provide administrators with a logical method of grouping directory objects. Rather than placing all users and computers into the default containers, OUs allow administrators to organize resources by business function while simplifying administration, security, and policy deployment.

The OU hierarchy created during this phase establishes the framework that will support every remaining phase of this homelab project.

---

# Organizational Unit Structure

The following custom Organizational Units were created beneath the **coachtorres.local** domain:

- Admin
- Employees
- Groups
- Lab
- Service Accounts
- Workstations

The following default Active Directory containers remain unchanged:

- Builtin
- Computers
- Domain Controllers
- ForeignSecurityPrincipals
- Managed Service Accounts
- Users

---

# Why Organizational Units Matter

A well-designed OU structure provides several advantages:

- Logical organization of Active Directory objects
- Simplified administration
- Delegation of administrative permissions
- Targeted Group Policy deployment
- Easier troubleshooting
- Improved scalability for future growth
- Separation of administrative accounts, users, computers, and service accounts

This design mirrors common enterprise Active Directory implementations and prepares the environment for later phases involving security groups, workstation joins, Group Policy, and security hardening.

---

# Implementation Summary

Completed tasks during this phase:

- Installed and configured Active Directory Domain Services
- Created the Organizational Unit hierarchy
- Verified all Organizational Units within Active Directory Users and Computers (ADUC)
- Preserved Microsoft's default containers
- Prepared the environment for user, group, and workstation management

---

# Validation

The OU hierarchy was verified using **Active Directory Users and Computers (ADUC)**.

Verification confirmed:

- All custom Organizational Units exist beneath the domain.
- Default Active Directory containers remain intact.
- Directory structure is ready for subsequent configuration phases.

---

# Evidence

### Screenshot

**File**

`screenshots/AD-OU-Hierarchy-Screenshot 2026-07-20 145445.png`

The screenshot demonstrates:

- Successful Active Directory installation
- Complete Organizational Unit hierarchy
- Default Active Directory containers
- Proper domain structure under **coachtorres.local**

---

# Lessons Learned

Creating Organizational Units before adding users and computers results in a cleaner and more scalable Active Directory environment. This organizational approach closely reflects enterprise best practices and simplifies future administration, delegation, and Group Policy management.

---

# Next Phase

**07 – Group Policy**

The Organizational Unit hierarchy will now be populated with user accounts and security groups that will later be used for permissions, workstation management, and Group Policy deployment throughout the remainder of the homelab.
