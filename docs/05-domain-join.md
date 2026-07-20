# Phase 5 – Windows Client Domain Join

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

Deploy a Windows 11 Enterprise client virtual machine, integrate it into the `coachtorres.local` Active Directory domain, and validate successful centralized authentication using Active Directory user accounts.

This phase transitions the lab from a standalone Domain Controller into a functional client-server Active Directory environment.

---

## Lab Environment

| Component | Value |
|----------|-------|
| Domain Controller | AD-DC-01 |
| Client VM | WIN11-01 |
| Client Operating System | Windows 11 Enterprise 25H2 |
| Hypervisor | Oracle VirtualBox 7.2.8 |
| Network | AD-Lab-NAT |
| DNS | Active Directory DNS |
| Domain | coachtorres.local |

---

## Architecture Overview

A dedicated Windows 11 virtual machine was provisioned using Oracle VirtualBox and configured as the first domain workstation within the lab.

The deployment consisted of four major stages:

1. Virtual machine provisioning
2. Windows 11 installation
3. Active Directory domain integration
4. Domain authentication validation

Successful completion established a centrally managed Windows workstation capable of authenticating against Active Directory Domain Services.

---

## Prerequisites

Before joining the workstation to the domain, the following components were operational:

- Windows Server 2022 Domain Controller
- Active Directory Domain Services
- DNS Server
- Domain `coachtorres.local`
- Active Directory Users and Computers
- Domain user accounts
- VirtualBox NAT Network

---

## Implementation Summary

The Windows 11 workstation was created entirely from the VirtualBox command line using `VBoxManage`.

Configuration included:

- Creating the virtual machine
- Allocating CPU and memory
- Creating virtual storage
- Attaching the Windows 11 installation media
- Configuring EFI firmware
- Connecting the VM to the AD-Lab-NAT network

Following installation:

- Guest Additions media was attached
- DNS client settings were updated to use the Domain Controller
- Name resolution was verified
- The workstation was joined to `coachtorres.local`
- The system was restarted to establish domain trust

---

## Validation Workflow

The deployment was validated in the following sequence.

### 1. Virtual Machine Provisioning

The Windows 11 virtual machine was successfully created and configured using `VBoxManage`.

Validation included:

- VM creation
- Storage controller configuration
- Virtual disk creation
- ISO attachment
- NAT Network assignment

---

### 2. Windows Installation

Windows 11 Enterprise completed installation successfully.

Validation included:

- Successful first boot
- Initial Windows configuration
- Desktop access
- Network adapter detection

---

### 3. Network Validation

Communication with the Active Directory environment was verified.

Validation commands included:

```powershell
ipconfig /all
```

```powershell
Set-DnsClientServerAddress
```

```powershell
nslookup coachtorres.local
```

Successful DNS resolution confirmed the workstation could locate the Domain Controller.

---

### 4. Domain Join

The workstation was joined using PowerShell.

```powershell
Add-Computer -DomainName "coachtorres.local"
```

The workstation restarted successfully.

---

### 5. Authentication Validation

Following reboot, authentication was verified.

```powershell
whoami
```

Result:

```text
coachtorres\administrator
```

Additional validation confirmed successful login using the Active Directory user account:

**Alicia Simmons**

This verified:

- Domain trust
- DNS functionality
- Active Directory authentication
- User account functionality

---

## Validation Results

Successful validation confirmed:

- Windows 11 VM created successfully
- VirtualBox configuration completed
- NAT Network connectivity established
- DNS resolution functioning
- Domain join completed successfully
- Domain trust established
- Active Directory authentication functioning
- Domain user login successful

The environment now consists of a functioning Domain Controller and managed Windows client workstation.

---

## Evidence

### GUI Evidence

- Win11-Setup-Screenshot 2026-07-17 170132.png
- Win11-Domain-Join-Screenshot 2026-07-19 124754.png
- Win11-Domain-User-Login-Alicia-Screenshot 2026-07-19 171142.png

These screenshots document successful workstation deployment, domain membership, and user authentication.

---

### Command-Line Evidence

Supporting engineering evidence includes command history documenting:

VirtualBox

- VBoxManage createvm
- VBoxManage modifyvm
- VBoxManage createmedium
- VBoxManage storagectl
- VBoxManage storageattach
- VBoxManage showvminfo
- VBoxManage startvm

Networking

- ipconfig
- ipconfig /all
- Set-DnsClientServerAddress
- nslookup coachtorres.local

Active Directory

- Add-Computer
- Restart-Computer
- whoami

These command logs establish the chain of custody for the workstation deployment from VM creation through successful Active Directory authentication.

---

## Lessons Learned

- Command-line automation provides reproducible infrastructure deployment.
- Proper DNS configuration is required before a domain join can succeed.
- `nslookup` provides an effective validation step before attempting domain membership.
- Domain membership establishes a trust relationship between the workstation and Domain Controller.
- Validation should include both technical commands and successful user authentication.
- Combining GUI screenshots with command history creates a stronger engineering evidence package than either source independently.

---

## Status

**Windows Client Domain Join**

✅ Completed

The Windows 11 workstation was successfully deployed, joined to `coachtorres.local`, and validated through both command-line verification and successful Active Directory user authentication.

---

## Next Phase

Phase 6a – Users and Security Groups

The next phase documents the Organizational Unit hierarchy used to organize administrative accounts, employees, groups, workstations, and service accounts within the Active Directory environment.
