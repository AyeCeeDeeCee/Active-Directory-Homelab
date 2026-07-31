


# Phase 08B – PowerShell Administration Log

## Project Metadata

| Field | Value |
|--------|-------|
| **Project** | Active Directory Homelab |
| **Repository** | Active-Directory-Homelab |
| **Phase** | 08B – Respond |
| **Document** | Phase-08B-PowerShell-Administration-Log.md |
| **Platform** | Windows Server 2022 |
| **Domain** | coachtorres.local |
| **Author** | Coach Torres |
| **Status** | In Progress |
| **Last Updated** | 2026-07-29 |

---

## Table of Contents

1. Objective
2. Prerequisites
3. Computer Object Administration
4. User Attribute Administration
5. Security Group Administration
6. Password Administration
7. Account Lifecycle Administration
8. Account Lockout Administration
9. Employee Transfer Administration
10. Phase 08B Summary
11. Related Documents
12. Enterprise Notes
13. References

---

## Objective

The objective of this document is to consolidate the verified
PowerShell administrative actions executed during Phase 08B –
Respond of the Active Directory Homelab.

These commands were used to safely modify and validate the
existing `coachtorres.local` Active Directory environment after
the Phase 08A baseline audit was completed.

Administrative operations documented include:

- Computer object management
- User attribute modification
- Security group membership changes
- Password administration
- Account lifecycle management
- Account lockout troubleshooting and resolution
- Employee transfer workflow

All changes were verified after execution to confirm the
expected Active Directory state.

---

## Related Documentation

### Phase Overview

[08 – PowerShell Administration](08-powershell-administration.md)

### Phase 08A – Observe

[Phase-08A-Audit-PowerShell-Commands](Phase-08A-Audit-PowerShell-Commands.md)

---

## Computer Object Administration

### Ticket 001 – Move WIN11-01 into the Workstations OU

### Objective

Move the WIN11-01 computer object from the default Computers
container into the Workstations Organizational Unit.

This represents a common Active Directory administrative task
performed after a workstation joins the domain.

---

### Initial State

#### Verify Current Computer Object Location

Command:

```powershell
Get-ADComputer -Identity "WIN11-01" -Properties DistinguishedName |
Select-Object Name, DistinguishedName
```

Output:

```text
Name     DistinguishedName
----     -----------------
WIN11-01 CN=WIN11-01,CN=Computers,DC=coachtorres,DC=local
```

---

#### Verify Destination Organizational Unit

Command:

```powershell
Get-ADOrganizationalUnit -Identity "OU=Workstations,DC=coachtorres,DC=local"
```

Output:

```text
City                     :
Country                  :
DistinguishedName        : OU=Workstations,DC=coachtorres,DC=local
LinkedGroupPolicyObjects : {}
ManagedBy                :
Name                     : Workstations
ObjectClass              : organizationalUnit
ObjectGUID               : 0eba1c7c-bcc5-496c-8950-bf3acf7fc7ba
PostalCode               :
State                    :
StreetAddress            :
```

---

### Administrative Action

Command:

```powershell
Move-ADObject -Identity "CN=WIN11-01,CN=Computers,DC=coachtorres,DC=local" -TargetPath "OU=Workstations,DC=coachtorres,DC=local"
```

Output:

```text
No output returned.
```

---

### Verification

Command:

```powershell
Get-ADComputer -Identity "WIN11-01" -Properties DistinguishedName |
Select-Object Name, DistinguishedName
```

Output:

```text
Name     DistinguishedName
----     -----------------
WIN11-01 CN=WIN11-01,OU=Workstations,DC=coachtorres,DC=local
```

### Ticket 002 – Update User Department Attribute

#### Objective

Update Nathan Miller's Department attribute from blank to HR.

---

### Initial State

#### Verify Current Department

Command:

```powershell
Get-ADUser -Filter * -SearchBase "OU=Employees,DC=coachtorres,DC=local" -Properties Department |
Select-Object Name, SamAccountName, Department
```

Output:

```text
Name              SamAccountName Department
----              -------------- ----------
Alicia Simmons    asimmons
Nathan Miller     nmiller
Sara Chung        schung
David Martinez    dmartinez
Micheal Rodriguez mrodriguez
```

---

#### Verify Target User

Command:

```powershell
Get-ADUser -Identity "nmiller" -Properties Department |
Select-Object Name, SamAccountName, Department
```

Output:

```text
Name          SamAccountName Department
----          -------------- ----------
Nathan Miller nmiller
```

---

### Administrative Action

Command:

```powershell
Set-ADUser -Identity "nmiller" -Department "HR"
```

Output:

```text
No output returned.
```

---

### Verification

Command:

```powershell
Get-ADUser -Identity "nmiller" -Properties Department |
Select-Object Name, SamAccountName, Department
```

Output:

```text
Name          SamAccountName Department
----          -------------- ----------
Nathan Miller nmiller        HR
```

### Ticket 003 – Add a User to a Security Group

Command:

```powershell
Get-ADPrincipalGroupMembership -Identity "nmiller" | Select-Object Name, GroupCategory | Sort-Object Name
```

Output:

```text
Name         GroupCategory
----         -------------
Domain Users Security
IT           Security
```

Command:

```powershell
Add-ADGroupMember -Identity "HR" -Members "nmiller"
```

Output:

```text
No output returned.
```

Command:

```powershell
Get-ADPrincipalGroupMembership -Identity "nmiller" | Select-Object Name, GroupCategory | Sort-Object Name
```

Output:

```text
Name         GroupCategory
----         -------------
Domain Users Security
HR           Security
IT           Security
```

### Ticket 004 – Force Password Change at Next Logon

Command:

```powershell
Get-ADUser -Identity "mrodriguez" -Properties PasswordLastSet | Select-Object Name, SamAccountName, PasswordLastSet
```

Output:

```text
Name              SamAccountName PasswordLastSet
----              -------------- ---------------
Micheal Rodriguez mrodriguez
```

Command:

```powershell
Set-ADUser -Identity "mrodriguez" -ChangePasswordAtLogon $true
```

Output:

```text
No output returned.
```

Command:

```powershell
Get-ADUser -Identity "mrodriguez" -Properties PasswordLastSet | Select-Object Name, SamAccountName, PasswordLastSet
```

Output:

```text
Name              SamAccountName PasswordLastSet
----              -------------- ---------------
Micheal Rodriguez mrodriguez
```

Observation:

`PasswordLastSet` remained blank after enabling
`ChangePasswordAtLogon`.

This behavior is expected because the password itself
was not changed during this operation.

The `PasswordLastSet` attribute will receive a new timestamp only after the password is reset or changed.

### Ticket 005 - Reset a Forgotten Password

Command:

```powershell
Set-ADAccountPassword -Identity "mrodriguez" -Reset -NewPassword (ConvertTo-SecureString "TempP@ssw0rd123!" -AsPlainText -Force)
```
Output:

```text
No output returned.
```

Command:

```powershell
Get-ADUser -Identity "mrodriguez" -Properties PasswordLastSet | Select-Object Name, SamAccountName, PasswordLastSet
```

Output:

```text
Name              SamAccountName PasswordLastSet
----              -------------- ---------------
Micheal Rodriguez mrodriguez     7/28/2026 1:39:08 PM
```

Observation:

Resetting the password caused `PasswordLastSet` to receive
a current timestamp.

If the user must change the temporary password at the next
sign-in, the Ticket 004 command must be applied again after
the password reset.

### Ticket 006 - Disable a User Account

Command:

```powershell
Get-ADUser -Identity "schung" -Properties Enabled | Select-Object Name, SamAccountName, Enabled
```

Output:

```text
Name       SamAccountName Enabled
----       -------------- -------
Sara Chung schung            True
```

Command:

```powershell
Disable-ADAccount -Identity "schung"
```

Output:

```text
No output returned.
```

Command:

```powershell
Get-ADUser -Identity "schung" -Properties Enabled | Select-Object Name, SamAccountName, Enabled
```

Output:

```text
Name       SamAccountName Enabled
----       -------------- -------
Sara Chung schung           False
```

### Ticket 007 - Re-enable a User Account

Command:

```powershell
Get-ADUser -Identity "schung" -Properties Enabled | Select-Object Name, SamAccountName, Enabled
```

Output:

```text
Name       SamAccountName Enabled
----       -------------- -------
Sara Chung schung           False
```

Command:

```powershell
Enable-ADAccount -Identity "schung"
```

Output:

```text
No output returned.
```

Command:

```powershell
Get-ADUser -Identity "schung" -Properties Enabled | Select-Object Name, SamAccountName, Enabled
```

Output:

```text
Name       SamAccountName Enabled
----       -------------- -------
Sara Chung schung            True
```

### Ticket 008 – Account Lockout Administration

#### 008 – Initial Investigation

Command:

```powershell
Search-ADAccount -LockedOut
```

Output:

```text
No output returned.
```

Command:

```powershell
Get-ADDefaultDomainPasswordPolicy
```

Output:

```text
ComplexityEnabled           : True
DistinguishedName           : DC=coachtorres,DC=local
LockoutDuration             : 00:30:00
LockoutObservationWindow    : 00:30:00
LockoutThreshold            : 0
MaxPasswordAge              : 42.00:00:00
MinPasswordAge              : 1.00:00:00
MinPasswordLength           : 7
objectClass                 : {domainDNS}
objectGuid                  : 9420fb8a-87e2-4ec5-ba6f-f668a390daa1
PasswordHistoryCount        : 24
ReversibleEncryptionEnabled : False
```

Observation:

No locked user accounts were found.

The effective domain password policy reported a
`LockoutThreshold` of `0`, indicating that account lockout
was not currently enforced.

### Ticket 008A – Investigate Policy Scope

Command:

```powershell
Get-GPInheritance -Target "DC=coachtorres,DC=local"
```

Output:

```text
Name                  : coachtorres.local
ContainerType         : Domain
Path                  : dc=coachtorres,dc=local
GpoInheritanceBlocked : No
GpoLinks              : {Default Domain Policy}
InheritedGpoLinks     : {Default Domain Policy}
```

Command:

```powershell
Get-GPInheritance -Target "OU=Employees,DC=coachtorres,DC=local"
```

Output:

```text
Name                  : employees
ContainerType         : OU
Path                  : ou=employees,dc=coachtorres,dc=local
GpoInheritanceBlocked : No
GpoLinks              : {FTOS - Workstation Baseline}
InheritedGpoLinks     : {FTOS - Workstation Baseline, Default Domain Policy}
```

Command:

```powershell
Get-GPOReport -Name "FTOS - Workstation Baseline" -ReportType Xml | Select-String -Pattern "Lockout"
```

Output:

```text
Confirmed account lockout settings existed in the
FTOS - Workstation Baseline GPO.
```

Observation:

The account lockout configuration existed in an
OU-linked Group Policy Object rather than functioning
as the effective domain account policy.

### Ticket 008B – Correct Effective Domain Policy

#### Verify Target Group Policy Object

Command:

```powershell
Get-GPO -Name "Default Domain Policy"
```

Output:

```text
DisplayName      : Default Domain Policy
DomainName       : coachtorres.local
Owner            : COACHTORRES\Domain Admins
Id               : 31b2f340-016d-11d2-945f-00c04fb984f9
GpoStatus        : AllSettingsEnabled
Description      :
CreationTime     : 6/21/2026 9:56:43 PM
ModificationTime : 6/21/2026 10:00:50 PM
UserVersion      : AD Version: 0, SysVol Version: 0
ComputerVersion  : AD Version: 3, SysVol Version: 3
WmiFilter        :
```

---

#### Administrative Action

Tool:

```text
Group Policy Management Console (gpmc.msc)
```

Action:

Configured the **Default Domain Policy** with the following
account lockout settings:

- Account lockout threshold: 5 invalid logon attempts
- Account lockout duration: 30 minutes
- Reset account lockout counter after: 30 minutes

Evidence:

The policy configuration was performed using the
Group Policy Management Console (GPMC).

Screenshots:

- GPMC-Lkt-thd-Screenshot 2026-07-28 174849.png
- GPMC-Lkt-Apy-Screenshot 2026-07-28 175126.png

### Ticket 008C – Validate Policy Application

Command:

```powershell
Get-ADDefaultDomainPasswordPolicy
```

Output:

```text
ComplexityEnabled           : True
DistinguishedName           : DC=coachtorres,DC=local
LockoutDuration             : 00:30:00
LockoutObservationWindow    : 00:30:00
LockoutThreshold            : 5
MaxPasswordAge              : 42.00:00:00
MinPasswordAge              : 1.00:00:00
MinPasswordLength           : 7
objectClass                 : {domainDNS}
objectGuid                  : 9420fb8a-87e2-4ec5-ba6f-f668a390daa1
PasswordHistoryCount        : 24
ReversibleEncryptionEnabled : False
```

Command:

```powershell
gpupdate /force
```

Output:

```text
Updating policy...

Computer Policy update has completed successfully.
User Policy update has completed successfully.
```

Observation:

The effective domain password policy now reported a
`LockoutThreshold` of `5`.

The client workstation successfully refreshed both computer
and user policy, confirming that the updated Group Policy
configuration had been applied.

### Ticket 008D - Reproduce an Account Lockout

Command:

```powershell
Search-ADAccount -LockedOut
```

Output:

```text
AccountExpirationDate :
DistinguishedName     : CN=Alicia Simmons,OU=Employees,DC=coachtorres,DC=local
Enabled               : True
LastLogonDate         : 7/19/2026 3:08:03 PM
LockedOut             : True
Name                  : Alicia Simmons
ObjectClass           : user
ObjectGUID            : a95d76cf-7ac7-4989-93c1-8fabc72253b9
PasswordExpired       : False
PasswordNeverExpires  : False
SamAccountName        : asimmons
SID                   : S-1-5-21-1304369662-1492964185-2224717632-1103
UserPrincipalName     : asimmons@coachtorres.local
```

Observation:

After the corrected domain account lockout policy was
applied, intentionally entering invalid credentials on the
domain-joined Windows 11 workstation successfully produced
a locked Active Directory user account.

The `Search-ADAccount -LockedOut` cmdlet confirmed that
Alicia Simmons was in a locked-out state.

### Ticket 008E – Unlock the Account

Command:

```powershell
Unlock-ADAccount -Identity "asimmons"
```

Output:

```text
No output returned.
```

Command:

```powershell
Search-ADAccount -LockedOut
```

Output:

```text
No output returned.
```

Observation:

The account was successfully unlocked using
`Unlock-ADAccount`.

A subsequent search for locked accounts returned no results,
confirming that Alicia Simmons was no longer in a locked-out
state.

### Ticket 009 - Employee Transfer

Command:

```powershell
Get-ADUser "schung" -Properties Department | Select-Object Name,SamAccountName,Department
```

Output:

```text
Name       SamAccountName Department
----       -------------- ----------
Sara Chung schung
```

Command:

```powershell
Set-ADUser "schung" -Department "Accounting"
```

Output:

```text
No output returned.
```

Command:

```powershell
Get-ADUser "schung" -Properties Department | Select-Object Name,Department
```

Output:

```text
Name       Department
----       ----------
Sara Chung Accounting
```

Command:

```powershell
Get-ADPrincipalGroupMembership "schung" | Select-Object Name
```

Output:

```text
Name
----
Domain Users
HR
```

Command:

```powershell
Add-ADGroupMember -Identity "Accounting" -Members "schung"
```

Output:

```text
No output returned.
```

Command:

```powershell
Get-ADPrincipalGroupMembership schung | Select-Object Name
```

Output:

```text
Name
----
Domain Users
HR
Accounting
```

Command:

```powershell
Remove-ADGroupMember -Identity "HR" -Members "schung"
```

Output:

```text
Confirmation prompt displayed.

Administrator confirmed the removal by entering:

Y
```

Command:

```powershell
Get-ADPrincipalGroupMembership "schung" | Select-Object Name
```

Output:

```text
Name
----
Domain Users
Accounting
```

Observation:

The employee transfer was completed in stages.

The Department attribute was updated to Accounting, the
Accounting security group membership was added, and the
obsolete HR group membership was removed.

Domain Users membership remained unchanged throughout the
process.

---

# Phase 08B Summary

Phase 08B documented the verified PowerShell administrative
operations performed against the `coachtorres.local`
Active Directory environment.

The following administrative tasks were completed and
validated:

- Ticket 001 – Move WIN11-01 into the Workstations OU
- Ticket 002 – Update a user Department attribute
- Ticket 003 – Add a user to a security group
- Ticket 004 – Force password change at next logon
- Ticket 005 – Reset a forgotten password
- Ticket 006 – Disable a user account
- Ticket 007 – Re-enable a user account
- Ticket 008 – Account Lockout Administration
- Ticket 009 – Employee Transfer

Each administrative action was verified after execution to
confirm the expected Active Directory state.

This document serves as the operational command log for
Phase 08B and complements the Phase 08 PowerShell
Administration documentation.

---

## Related Documentation

- [08 – PowerShell Administration](08-powershell-administration.md)

- [Phase-08A-Audit-PowerShell-Commands](Phase-08A-Audit-PowerShell-Commands.md)

---

## Evidence

Supporting screenshots for this phase are located in:

`screenshots/`

Primary evidence includes:

- [`../screenshots/GPMC-Lkt-thd-Screenshot 2026-07-28 174849.png`](../screenshots/GPMC-Lkt-thd-Screenshot%202026-07-28%20174849.png)

- [`../screenshots/GPMC-Lkt-Apy-Screenshot 2026-07-28 175126.png`](../screenshots/GPMC-Lkt-Apy-Screenshot%202026-07-28%20175126.png)

---

End of Document
