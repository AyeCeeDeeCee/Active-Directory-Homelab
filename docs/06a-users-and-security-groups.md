# Phase 6A – Users and Security Groups

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

## Objective

Create representative Active Directory user accounts and Global Security Groups to simulate an enterprise organizational structure.

This phase establishes role-based administration by assigning users to security groups rather than assigning permissions directly to individual accounts.

---

## Lab Environment

| Component | Value |
|----------|-------|
| Domain Controller | AD-DC-01 |
| Operating System | Windows Server 2022 Evaluation |
| Domain | coachtorres.local |
| Management Tool | Active Directory Users and Computers (ADUC) |
| Organizational Unit | Employees |
| Organizational Unit | Groups |

---

## Architecture Overview

Enterprise Active Directory environments organize users according to business functions instead of individual permissions.

During this phase:

- User accounts were created within the Employees Organizational Unit.
- Global Security Groups were created to represent departments.
- Users were assigned membership within their appropriate departmental group.

This structure simplifies future administration and provides the foundation for Group Policy, shared resources, and delegated administration.

---

## Implementation Summary

The Active Directory Users and Computers (ADUC) management console was used to provision user accounts and security groups.

Five representative employee accounts were created within the Employees Organizational Unit.

Four Global Security Groups were created within the Groups Organizational Unit.

Users were then assigned membership according to departmental responsibilities.

---

## User Accounts

| Display Name | Username | Department |
|--------------|----------|------------|
| Alicia Simmons | asimmons | IT |
| Nathan Miller | nmiller | IT |
| Sarah Chen | schen | Human Resources |
| David Martinez | dmartinez | Accounting |
| Michael Torres | mtorres | Management |

---

## Global Security Groups

The following Global Security Groups were created:

- IT
- HR
- Accounting
- Managers

---

## Group Membership Validation

| User | Assigned Security Group |
|------|-------------------------|
| Alicia Simmons | IT |
| Nathan Miller | IT |
| Sarah Chen | HR |
| David Martinez | Accounting |
| Michael Torres | Managers |

---

## Validation Results

Successful validation confirmed:

- Employee user accounts created successfully
- Global Security Groups created successfully
- Users assigned to the appropriate department
- Group memberships verified in ADUC
- Organizational Units functioning correctly

These results confirm that the Active Directory environment is prepared for future authorization, Group Policy, and delegated administration.

---

## Skills Demonstrated

- Active Directory Users and Computers (ADUC)
- Organizational Unit administration
- User provisioning
- Security Group administration
- Group membership management
- Enterprise identity administration
- Windows Server 2022 Active Directory management

---

## Evidence

### GUI Evidence

Supporting screenshots include:

- `AD-Created-Users-Screenshot 2026-07-08 171902.png`
- `AD-Created-Groups-Screenshot 2026-07-08 172004.png`

These screenshots verify successful creation of both user accounts and Global Security Groups within Active Directory.

---

## Lessons Learned

This phase reinforced a core Active Directory design principle:

> Assign permissions to Security Groups rather than directly to user accounts.

Managing permissions through group membership:

- simplifies administration,
- improves scalability,
- reduces administrative overhead,
- follows Microsoft enterprise best practices,
- supports least-privilege administration.

---

## Status

**Users and Security Groups**

✅ Completed

The Active Directory environment now contains representative enterprise user accounts and departmental security groups, providing the identity structure required for centralized administration.

---

## Next Phase

**Phase 6 – Organizational Units**

The next phase documents the Organizational Unit hierarchy used to organize administrative accounts, employees, groups, service accounts, domain controllers, and workstations within the `coachtorres.local` Active Directory environment.
