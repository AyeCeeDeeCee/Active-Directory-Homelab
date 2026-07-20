# Phase 1 – Virtual Machine Creation

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

Create a stable Windows Server 2022 Domain Controller virtual machine that will serve as the foundation for the Active Directory Homelab.

---

## Lab Environment

| Component | Value |
|----------|-------|
| Host OS | Windows 11 |
| Hypervisor | Oracle VirtualBox 7.2.8 |
| Guest OS | Windows Server 2022 Evaluation |
| VM Name | AD-DC-01 |
| Memory | 4096 MB |
| CPUs | 2 |
| Firmware | EFI |
| Chipset | PIIX3 |
| Graphics Controller | VMSVGA |
| VRAM | 128 MB |
| Storage Controller | SATA (Intel AHCI) |
# 01 – Virtual Machine Creation

## Objective

Create a stable Windows Server 2022 Domain Controller virtual machine that will serve as the foundation for the Active Directory Homelab.

---

## Initial VM Configuration

The virtual machine was created using Oracle VirtualBox and configured with hardware resources appropriate for a Windows Server 2022 Active Directory Domain Controller.

Initial validation confirmed successful installation of Windows Server 2022 Evaluation Edition.

---

## VirtualBox Stabilization Build 001

### Issue

After Windows installation and Active Directory configuration, the virtual machine became unstable.

Observed symptoms included:

- Freezing shortly after login
- Server Manager becoming unresponsive
- Automatic Refresh Failed notification
- Repeated desktop lockups
- Linux virtual machines remained stable

---

### Troubleshooting Strategy

Rather than rebuilding the environment, each configuration change was isolated and tested individually.

A baseline VM configuration was exported before making changes.

---

### Configuration Change

The following VirtualBox setting was modified:

Previous:

```
Paravirtualization Provider: Default
```

Updated:

```
Paravirtualization Provider: KVM
```

No other VM configuration changes were made during this validation.

---

### Validation Results

Following the configuration change:

- Windows booted successfully
- Login completed successfully
- Desktop remained responsive
- Server Manager loaded successfully
- Windows Admin Center prompt appeared
- Existing Active Directory Domain remained intact
- Organizational Units (OUs) were successfully verified
- No freezing observed during validation

---

## Status

**VirtualBox Stabilization Build 001**

✅ Successful Initial Validation

Further validation will continue throughout the remaining project phases.
## Operational Command Reference

The following VBoxManage commands were validated during VirtualBox Stabilization Build 001. These commands form the standard operating procedure (SOP) for managing the AD-DC-01 virtual machine from Git Bash.
