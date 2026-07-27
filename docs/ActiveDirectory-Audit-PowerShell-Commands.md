
# Active Directory Audit PowerShell Commands

## Project Metadata

| Field | Value |
|--------|-------|
| **Project** | Active Directory Homelab |
| **Repository** | Active-Directory-Homelab |
| **Phase** | 08A – Observe |
| **Document** | ActiveDirectory-Audit-PowerShell-Commands.md |
| **Platform** | Windows Server 2022 |
| **Domain** | coachtorres.local |
| **Author** | Coach Torres |
| **Status** | Completed |
| **Last Updated** | 2026-07-26 |

---

## Table of Contents

1. Objective
2. Prerequisites
3. Active Directory Module Verification
4. Domain Audit
5. Organizational Unit Audit
6. User Audit
7. Security Group Audit
8. Group Membership Audit
9. Account Health Audit
10. Password Status Audit
11. Computer Object Audit
12. Engineering Finding
13. Lessons Learned
14. Enterprise Notes
15. References

---

## Objective

The objective of this document is to consolidate the read-only PowerShell commands executed and verified during Phase 08A of the Active Directory Homelab.

These commands were used to establish an accurate baseline of the existing `coachtorres.local` Active Directory environment before performing administrative changes or introducing additional automation.

The audit covered:

- Active Directory module availability
- Domain configuration
- Organizational Units
- Users
- Security groups
- User group memberships
- Account health
- Password status
- Computer objects

No Active Directory objects were modified during these audits.

---

## Prerequisites

Before executing these commands, the following components were installed and operational:

- Windows Server 2022
- Active Directory Domain Services
- Promoted domain controller
- Active Directory PowerShell module
- `coachtorres.local` domain
- Existing Organizational Units
- Existing users
- Existing security groups
- Domain-joined Windows 11 client

PowerShell was run with administrative privileges on the domain controller.

---

## Active Directory Module Verification

The Active Directory PowerShell module must be available before Active Directory cmdlets can be executed.

```powershell
Get-Module -ListAvailable ActiveDirectory
```

### Verified Result

The `ActiveDirectory` module was available.

```text
ModuleType Version Name
---------- ------- ----
Manifest   1.0.1.0 ActiveDirectory
```

---

## Domain Audit

### Retrieve Complete Domain Information

```powershell
Get-ADDomain
```

This command returned the complete Active Directory domain configuration, including:

- DNS root
- NetBIOS name
- Domain functional level
- Forest
- FSMO role holders
- Default object containers
- Domain controller information

### Retrieve Selected Domain Information

```powershell
Get-ADDomain |
Select-Object DNSRoot,NetBIOSName,DomainMode,Forest,InfrastructureMaster,PDCEmulator,RIDMaster |
Format-List
```

### Verified Result

```text
DNSRoot              : coachtorres.local
NetBIOSName          : COACHTORRES
DomainMode           : Windows2016Domain
Forest               : coachtorres.local
InfrastructureMaster : WIN-J24UO6114L0.coachtorres.local
PDCEmulator          : WIN-J24UO6114L0.coachtorres.local
RIDMaster            : WIN-J24UO6114L0.coachtorres.local
```

The domain audit confirmed that the single domain controller currently owns all three domain-level FSMO roles.

---

## Organizational Unit Audit

### Retrieve Organizational Units

```powershell
Get-ADOrganizationalUnit -Filter * |
Select-Object Name,DistinguishedName |
Sort-Object Name |
Format-Table -AutoSize
```

### Verified Result

```text
Name               DistinguishedName
----               -----------------
Admin              OU=Admin,DC=coachtorres,DC=local
Domain Controllers OU=Domain Controllers,DC=coachtorres,DC=local
Employees          OU=Employees,DC=coachtorres,DC=local
Groups             OU=Groups,DC=coachtorres,DC=local
Lab                OU=Lab,DC=coachtorres,DC=local
Service Accounts   OU=Service Accounts,DC=coachtorres,DC=local
Workstations       OU=Workstations,DC=coachtorres,DC=local
```

The audit verified all six custom Organizational Units and the default Domain Controllers OU.

---

## User Audit

### Retrieve All Domain Users

```powershell
Get-ADUser -Filter * |
Select-Object Name,SamAccountName,Enabled
```

### Verified Result

```text
Name              SamAccountName Enabled
----              -------------- -------
Administrator     Administrator     True
Guest             Guest            False
krbtgt            krbtgt           False
Alicia Simmons    asimmons          True
Nathan Miller     nmiller           True
Sara Chung        schung            True
David Martinez    dmartinez         True
Micheal Rodriguez mrodriguez        True
```

This command returned both built-in accounts and the five canonical enterprise employees.

### Retrieve Employees OU Users and Department Attributes

```powershell
Get-ADUser -Filter * -SearchBase "OU=Employees,DC=coachtorres,DC=local" -Properties Department |
Select-Object Name,SamAccountName,Department,DistinguishedName
```

### Verified Result

The five canonical enterprise users were located inside the Employees OU.

The `Department` attribute was blank for all five users.

### Retrieve Employee Account Status and Location

```powershell
Get-ADUser -Filter * -SearchBase "OU=Employees,DC=coachtorres,DC=local" -Properties Department,Enabled,DistinguishedName |
Select-Object Name,SamAccountName,Enabled,Department,DistinguishedName
```

### Verified Result

All five enterprise users were:

- Enabled
- Located in the Employees OU
- Missing Department attribute values

---

## Security Group Audit

### Retrieve All Active Directory Groups

```powershell
Get-ADGroup -Filter * |
Select-Object Name,GroupScope,GroupCategory
```

This command returned all built-in and custom Active Directory groups.

### Retrieve Groups from the Groups OU

```powershell
Get-ADGroup -Filter * -SearchBase "OU=Groups,DC=coachtorres,DC=local" -Properties GroupScope,GroupCategory |
Select-Object Name,GroupScope,GroupCategory,DistinguishedName |
Sort-Object Name |
Format-Table -AutoSize
```

### Verified Result

```text
Name       GroupScope GroupCategory DistinguishedName
----       ---------- ------------- -----------------
Accounting Global     Security      CN=Accounting,OU=Groups,DC=coachtorres,DC=local
HR         Global     Security      CN=HR,OU=Groups,DC=coachtorres,DC=local
IT         Global     Security      CN=IT,OU=Groups,DC=coachtorres,DC=local
Managers   Global     Security      CN=Managers,OU=Groups,DC=coachtorres,DC=local
```

The four custom enterprise groups were verified as Global Security groups located inside the Groups OU.

### Retrieve Specific Enterprise Groups

```powershell
Get-ADGroup -Filter 'Name -eq "IT" -or Name -eq "HR" -or Name -eq "Accounting" -or Name -eq "Managers"' |
Select-Object Name,DistinguishedName
```

### Verified Result

```text
Name       DistinguishedName
----       -----------------
HR         CN=HR,OU=Groups,DC=coachtorres,DC=local
IT         CN=IT,OU=Groups,DC=coachtorres,DC=local
Managers   CN=Managers,OU=Groups,DC=coachtorres,DC=local
Accounting CN=Accounting,OU=Groups,DC=coachtorres,DC=local
```

---

## Group Membership Audit

### Retrieve Enterprise Group Memberships

```powershell
Get-ADUser -Filter * -SearchBase "OU=Employees,DC=coachtorres,DC=local" |
ForEach-Object {
    $User = $_

    Get-ADPrincipalGroupMembership -Identity $User |
    Where-Object Name -in @("IT","HR","Accounting","Managers") |
    Select-Object @{
        Name = "User"
        Expression = { $User.Name }
    },Name
}
```

This command retrieves each employee and displays membership in the four enterprise security groups.

### Create a Consolidated Group Membership Report

```powershell
Get-ADUser -Filter * -SearchBase "OU=Employees,DC=coachtorres,DC=local" |
ForEach-Object {
    $User = $_

    $Groups = Get-ADPrincipalGroupMembership -Identity $User |
        Where-Object Name -in @("IT","HR","Accounting","Managers") |
        Select-Object -ExpandProperty Name

    [PSCustomObject]@{
        User           = $User.Name
        SamAccountName = $User.SamAccountName
        SecurityGroup  = $Groups -join ", "
    }
} |
Format-Table -AutoSize
```

### Verified Result

```text
User              SamAccountName SecurityGroup
----              -------------- -------------
Alicia Simmons    asimmons       IT
Nathan Miller     nmiller        IT
Sara Chung        schung         HR
David Martinez    dmartinez      Accounting
Micheal Rodriguez mrodriguez     Managers
```

This report confirmed the intended enterprise role-based group memberships.

---

## Account Health Audit

### Retrieve Account Health Information

```powershell
Get-ADUser -Filter * -SearchBase "OU=Employees,DC=coachtorres,DC=local" -Properties PasswordLastSet,LastLogonDate,Created,LockedOut |
Select-Object Name,SamAccountName,Enabled,LockedOut,PasswordLastSet,LastLogonDate,Created |
Format-Table -AutoSize
```

### Verified Findings

- All five enterprise user accounts were enabled.
- No enterprise user accounts were locked.
- Alicia Simmons had logged on and changed her password.
- The remaining four users did not have recorded password or last-logon dates.
- All five accounts showed their original creation dates.

---

## Password Status Audit

### Retrieve Password Status Information

```powershell
Get-ADUser -Filter * -SearchBase "OU=Employees,DC=coachtorres,DC=local" -Properties PasswordLastSet,PasswordExpired,PasswordNeverExpires,CannotChangePassword |
Select-Object Name,SamAccountName,PasswordLastSet,PasswordExpired,PasswordNeverExpires,CannotChangePassword |
Format-Table -AutoSize
```

### Verified Findings

- Alicia Simmons had successfully changed her password.
- Alicia Simmons did not have an expired password.
- Nathan Miller had an expired password.
- Sara Chung had an expired password.
- David Martinez had an expired password.
- Micheal Rodriguez had an expired password.
- No enterprise user had `PasswordNeverExpires` enabled.
- No enterprise user was prevented from changing their password.

These findings indicate that four users were still awaiting their initial interactive logon and required password change.

---

## Computer Object Audit

### Retrieve Computer Objects

```powershell
Get-ADComputer -Filter * -Properties OperatingSystem,Enabled |
Select-Object Name,OperatingSystem,Enabled,DistinguishedName |
Sort-Object Name |
Format-Table -AutoSize
```

### Verified Result

```text
Name            OperatingSystem                         Enabled DistinguishedName
----            ---------------                         ------- -----------------
WIN11-01        Windows 11 Pro                          True    CN=WIN11-01,CN=Computers,DC=coachtorres,DC=local
WIN-J24UO6114L0 Windows Server 2022 Standard Evaluation True    CN=WIN-J24UO6114L0,OU=Domain Controllers,DC=coachtorres,DC=local
```

## Engineering Findings

### Finding 01 - The Windows 11 workstation `WIN11-01` remains inside the default Computers container:

```text
CN=WIN11-01,CN=Computers,DC=coachtorres,DC=local
```

It is not currently located inside the custom Workstations OU.

The domain controller is correctly located inside the Domain Controllers OU.

---

## Engineering Finding

### Finding 02 Unsupported `-in` Operator in the Active Directory Filter

The following command was attempted:

```powershell
Get-ADGroup -Filter 'Name -in "IT","HR","Accounting","Managers"' |
Select-Object Name,DistinguishedName
```

The command failed with the following error:

```text
Operator Not Supported: -in
```

The `-Filter` parameter used by Active Directory cmdlets does not support every standard PowerShell comparison operator.

The query was corrected by using multiple `-eq` comparisons connected with `-or`:

```powershell
Get-ADGroup -Filter 'Name -eq "IT" -or Name -eq "HR" -or Name -eq "Accounting" -or Name -eq "Managers"' |
Select-Object Name,DistinguishedName
```

The standard PowerShell `-in` operator worked successfully after Active Directory objects had already been returned through the pipeline:

```powershell
Where-Object Name -in @("IT","HR","Accounting","Managers")
```

This demonstrates the difference between:

- The Active Directory filter language used inside `Get-ADGroup -Filter`
- Standard PowerShell filtering performed by `Where-Object`

---

## Lessons Learned

PowerShell auditing provided a complete and repeatable view of the Active Directory environment without modifying directory objects.

Using `-SearchBase` limited queries to the intended Organizational Unit and prevented built-in accounts or groups from being mixed with enterprise objects.

Selecting only required properties made command output easier to review and document.

Formatting commands such as `Format-Table -AutoSize` and `Format-List` improved readability without changing the underlying Active Directory data.

The audit also exposed configuration details that were not immediately visible through graphical administration tools, including:

- Missing Department attributes
- Accounts awaiting first logon
- Password expiration status
- Exact object locations
- Workstation placement in the default Computers container

---

## Enterprise Notes

The live Active Directory environment remains the source of truth for this project.

The five canonical enterprise employees were created manually during an earlier phase and must not be recreated through Phase 08 bulk-provisioning automation.

The Phase 08A audit established the baseline required before beginning PowerShell-based administrative changes.

All commands in this document were executed and verified within the `coachtorres.local` lab environment.

Additional commands should only be added after they have been executed and verified.

---

## References

- Phase 08 – PowerShell Administration Overview (08-powershell-administration.md)
- Microsoft Learn – Active Directory PowerShell Module
- Microsoft Learn – Get-ADDomain
- Microsoft Learn – Get-ADOrganizationalUnit
- Microsoft Learn – Get-ADUser
- Microsoft Learn – Get-ADGroup
- Microsoft Learn – Get-ADPrincipalGroupMembership
- Microsoft Learn – Get-ADComputer
- Phase 08 – PowerShell Administration
- Active Directory Homelab Engineering Contract
