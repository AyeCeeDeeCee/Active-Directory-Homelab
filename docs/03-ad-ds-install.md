# Phase 3 – Active Directory Domain Services Installation

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

Install the Active Directory Domain Services (AD DS) server role on Windows Server 2022 to prepare the server for promotion as the first domain controller in the lab environment.

---

## Lab Environment

| Component | Value |
|----------|-------|
| Server Role | Active Directory Domain Services (AD DS) |
| Operating System | Windows Server 2022 Evaluation |
| Virtual Machine | AD-DC-01 |
| Hypervisor | Oracle VirtualBox 7.2.8 |
| Host OS | Windows 11 |

---

## Installation Summary

The Active Directory Domain Services server role was installed using Server Manager.

The installation included the core Active Directory services required to configure the server as a domain controller. At the completion of the installation, Windows indicated that additional configuration was required before the server could begin providing directory services.

No errors or installation failures were encountered during the role installation.

---

## Installed Components

The following server role was installed:

- Active Directory Domain Services (AD DS)

Server Manager automatically installed the required supporting features and management tools necessary to administer Active Directory.

---

## Validation Results

Successful validation confirmed:

- Active Directory Domain Services role installed successfully
- Required management tools installed
- Server Manager displayed the post-deployment configuration notification
- Server prepared for domain controller promotion

---

## Evidence

Supporting screenshots include:

- Add-Roles-And-Features.png
- Server-Manager-AD-DS-DNS-Installed.png

These screenshots document the successful installation of the Active Directory Domain Services server role and confirm the server was prepared for domain controller promotion.
## Status

**Active Directory Domain Services Installation**

✅ Successful

The server is prepared for promotion to the first domain controller within the Active Directory environment.

---

## Next Phase

Proceed to:

**04 – Domain Controller Promotion**
