# Active Directory Homelab – Users and Security Groups

## Overview

This phase of the Active Directory Homelab focused on building a realistic organizational structure by creating domain user accounts, security groups, and assigning users to their appropriate departments. This establishes the foundation for future administration tasks including Group Policy Objects (GPOs), shared folders, NTFS permissions, and Windows client domain joins.

---

## Objectives

- Create Active Directory user accounts.
- Create departmental security groups.
- Assign users to the appropriate security groups.
- Verify user and group creation using Active Directory Users and Computers (ADUC).

---

## Organizational Unit

**Employees**

Created the following domain users:

| Name | Username | Department |
|------|----------|------------|
| Alicia Simmons | asimmons | IT |
| Nathan Miller | nmiller | IT |
| Sarah Chen | schen | Human Resources |
| David Martinez | dmartinez | Accounting |
| Michael Torres | mtorres | Management |

---

## Security Groups

The following Global Security Groups were created within the **Groups** Organizational Unit:

- IT
- HR
- Accounting
- Managers

---

## Group Memberships

| User | Security Group |
|------|----------------|
| Alicia Simmons | IT |
| Nathan Miller | IT |
| Sarah Chen | HR |
| David Martinez | Accounting |
| Michael Torres | Managers |

---

## Skills Demonstrated

- Active Directory Users and Computers (ADUC)
- Organizational Unit administration
- User account creation
- Security Group creation
- Group membership management
- Active Directory administration using Windows Server 2022

---

## Evidence

Screenshots captured during this phase:

- `screenshots/AD-Created-Users-Screenshot 2026-07-08 171902.png`
- `screenshots/AD-Created-Groups-Screenshot 2026-07-08 172004.png`

---

## Lessons Learned

This phase reinforced one of the most important concepts in Active Directory administration:

> Permissions should be assigned to **Security Groups**, and users should become members of those groups instead of assigning permissions directly to individual user accounts.

This approach simplifies administration, improves scalability, and follows enterprise best practices.

---

## Next Steps

The next phase of the project will include:

- Joining a Windows 11 client to the domain.
- Logging in using domain user accounts.
- Creating shared folders.
- Configuring NTFS permissions.
- Applying Group Policy Objects (GPOs).
