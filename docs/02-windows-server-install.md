# Phase 2 – Windows Server Installation

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

Install Windows Server 2022 Evaluation Edition on the AD-DC-01 virtual machine and establish a stable operating system prior to Active Directory deployment.

---

## Lab Environment

| Component | Value |
|----------|-------|
| Operating System | Windows Server 2022 Evaluation |
| Virtual Machine | AD-DC-01 |
| Hypervisor | Oracle VirtualBox 7.2.8 |
| Host OS | Windows 11 |


---

## Installation Summary

Windows Server 2022 Evaluation Edition was successfully installed on the AD-DC-01 virtual machine using the default graphical installation wizard.

Following installation, the operating system booted successfully and completed the Out-of-Box Experience (OOBE), allowing initial administrative configuration.

---

## Initial Configuration

The following post-installation tasks were completed:

- Configured the local Administrator account
- Logged into Windows Server successfully
- Verified desktop functionality
- Verified Server Manager launched automatically
- Confirmed network adapter detection
- Confirmed local storage availability

---

## Validation Results

Successful validation confirmed:

- Windows Server booted without errors
- Administrator login completed successfully
- Server Manager loaded successfully
- Virtual hardware was detected correctly
- Operating system was ready for Active Directory Domain Services installation

---

## Status

**Windows Server Installation**

✅ Successful

The operating system is functioning normally and serves as the baseline platform for Active Directory Domain Services deployment.

---

## Next Phase

Proceed to:

**03 – Active Directory Domain Services Installation**
