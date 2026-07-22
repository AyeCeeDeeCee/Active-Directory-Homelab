# Phase 07 – Group Policy Baseline

## Project Metadata

| Field | Value |
|--------|-------|
| **Project** | Active Directory Homelab |
| **Repository** | Active-Directory-Homelab |
| **Phase** | 07 – Group Policy Baseline |
| **Document** | 07-group-policy-baseline.md |
| **Platform** | Windows Server 2022 |
| **Domain** | coachtorres.local |
| **Author** | Coach Torres |
| **Status** | In Progress |
| **Last Updated** | 2026-07-21 |

---

## Table of Contents

1. Objective
2. Phase Roadmap
3. What is Group Policy?
4. Why Organizations Use Group Policy?
5. Group Policy Objects (GPOs)
6. Computer vs User Configuration
7. Group Policy Processing Order (LSDOU)
8. Creating the FTOS Workstation Baseline
9. Linking the GPO to the Employees OU
10. Lessons Learned
11. Enterprise Notes
12. Evidence
13. References

---

## Objective

The objective of this phase is to introduce Microsoft Group Policy within an Active Directory domain and establish a baseline Group Policy Object (GPO) that will be used throughout the remainder of this project.

Rather than configuring every security setting in a single document, this phase is divided into focused implementation guides. This approach mirrors how enterprise engineering teams document infrastructure changes by separating architecture from implementation.

The baseline GPO created during this phase serves as the foundation for future security, authentication, and workstation configuration policies applied to the domain.

This document focuses on the architectural concepts behind Group Policy. Detailed implementation and configuration of individual security policies are documented separately in their respective Phase 07 sub-documents.

---

## Prerequisites

Before completing this phase, the following components were successfully deployed and verified:

- Windows Server 2022 installed
- Active Directory Domain Services (AD DS) installed
- Domain controller promoted
- Organizational Units (OUs) created
- Users and security groups created
- Domain environment operational

These prerequisites provide the Active Directory infrastructure required for implementing and managing Group Policy.

---

## Phase Roadmap

This phase consists of the following documents:

| Document | Description |
|----------|-------------|
| **07-group-policy-baseline.md** | Group Policy overview and baseline GPO creation |
| **07a-password-policy.md** | Domain password policy configuration |
| **07b-account-lockout-policy.md** | Account lockout configuration |
| **07c-kerberos-policy.md** | Kerberos authentication policy |

Each document focuses on a specific aspect of Group Policy to keep the documentation modular, easier to maintain, and aligned with enterprise documentation practices.

---

## What is Group Policy?

Group Policy is Microsoft's centralized management framework used to configure operating systems, users, computers, and security settings across an Active Directory environment.

Instead of configuring every workstation individually, administrators create a Group Policy Object (GPO) once and deploy it across multiple users or computers through Active Directory Organizational Units (OUs).

This provides consistency, reduces administrative overhead, and helps organizations enforce security standards throughout the enterprise.

Group Policy is one of the core administrative technologies in Windows enterprise environments and is commonly used by IT departments to centrally manage thousands of domain-joined computers and users.

---

## Why Organizations Use Group Policy

Organizations use Group Policy to:

- Standardize workstation configurations
- Enforce password and authentication requirements
- Apply security baselines
- Restrict unauthorized user actions
- Deploy software and configuration settings
- Reduce configuration drift
- Improve security compliance
- Simplify enterprise administration

As environments grow from a handful of computers to hundreds or thousands of systems, centralized management becomes essential for maintaining consistency and reducing operational risk.
