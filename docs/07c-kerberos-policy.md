# Phase 07c – Kerberos Policy

## Project Metadata

| Field | Value |
|--------|-------|
| **Project** | Active Directory Homelab |
| **Repository** | Active-Directory-Homelab |
| **Phase** | 07c – Kerberos Policy |
| **Document** | 07c-kerberos-policy.md |
| **Platform** | Windows Server 2022 |
| **Domain** | coachtorres.local |
| **Author** | Coach Torres |
| **Status** | Complete |
| **Last Updated** | 2026-07-22 |

---

## Table of Contents

1. Objective
2. Background / Theory
3. Enterprise Use Case
4. Configuration Path
5. Configuration Summary
6. Implementation
7. Testing & Validation
8. Lessons Learned
9. Authentication Lifecycle
10. Evidence
11. References

---

# Objective

Document the purpose of Kerberos Policy within Active Directory and explain how Kerberos provides secure, ticket-based authentication across enterprise Windows environments.

This phase documents the Kerberos Policy settings observed within the **FTOS Workstation Baseline** Group Policy Object while reinforcing the relationship between Group Policy scope and Active Directory authentication.

---

# Background / Theory

## What is Kerberos?

Kerberos is Microsoft's default authentication protocol for Active Directory domains. Rather than repeatedly transmitting passwords across the network, Kerberos authenticates users through encrypted authentication tickets issued by the **Key Distribution Center (KDC)** running on the domain controller.

This ticket-based authentication model provides stronger security, supports Single Sign-On (SSO), and significantly reduces the risk of password exposure.

Kerberos is used every day in enterprise environments whenever domain users authenticate to file servers, printers, applications, SQL servers, or other Active Directory resources.

---

## Kerberos Authentication Flow

```text
User Logon
      │
      ▼
Key Distribution Center (KDC)
      │
      ▼
Ticket Granting Ticket (TGT)
      │
      ▼
Requests Service Ticket
      │
      ▼
Access File Server
Access SQL Server
Access Print Server
Access Applications
```

---

## Ticket Granting Ticket (TGT)

The Ticket Granting Ticket (TGT) is issued after a successful domain logon.

Rather than granting access directly to network resources, the TGT acts as a master authentication ticket that allows users to request individual Service Tickets without repeatedly entering their password.

By default, the TGT remains valid for approximately **10 hours** and may be renewed for up to **7 days**, depending on domain policy.

---

## Service Tickets

A Service Ticket is issued for an individual network resource.

Examples include:

- File Server
- SQL Server
- Print Server
- IIS Web Server
- Domain Services

Each Service Ticket is independent and allows authenticated access only to its specific resource.

---

## Why Time Synchronization Matters

Kerberos relies heavily on synchronized system clocks.

Authentication tickets contain timestamps that help protect against replay attacks.

By default, Windows allows a maximum clock difference of **5 minutes** between computers participating in Kerberos authentication.

Maintaining synchronized time throughout the Active Directory domain is critical for successful authentication.

---

# Enterprise Use Case

Kerberos provides secure authentication across enterprise Windows environments while supporting Single Sign-On (SSO).

Organizations rely on Kerberos to:

- Authenticate domain users
- Reduce repeated password transmissions
- Improve authentication security
- Support centralized identity management
- Provide scalable authentication across thousands of systems

Kerberos is one of the foundational technologies behind Active Directory authentication.

---

# Configuration Path

```text
Computer Configuration
└── Policies
    └── Windows Settings
        └── Security Settings
            └── Account Policies
                └── Kerberos Policy
```

---

# Configuration Summary

| Setting | Configured Value | Purpose |
|----------|-----------------|---------|
| Enforce user logon restrictions | **Not Defined** | Uses the effective domain Kerberos policy. |
| Maximum lifetime for service ticket | **Not Defined** | Controls Service Ticket lifetime. |
| Maximum lifetime for user ticket | **Not Defined** | Controls Ticket Granting Ticket lifetime. |
| Maximum lifetime for user ticket renewal | **Not Defined** | Controls TGT renewal period. |
| Maximum tolerance for computer clock synchronization | **Not Defined** | Prevents replay attacks through time synchronization. |

---

# Implementation

## Enforce User Logon Restrictions

### Configured Value

**Not Defined**

### Purpose

Determines whether the Key Distribution Center validates user account restrictions such as disabled accounts, expired accounts, and permitted logon times before issuing service tickets.

### Implementation Rationale

Although this policy appears within the FTOS Workstation Baseline GPO, it remains **Not Defined** because Kerberos account policies are typically governed by the effective domain policy rather than an Organizational Unit (OU)-linked Group Policy Object.

---

## Maximum Lifetime for Service Ticket

### Configured Value

**Not Defined**

### Purpose

Determines how long a Service Ticket remains valid before a new ticket must be requested.

### Implementation Rationale

Service Tickets are issued individually for network resources. The effective domain policy normally controls their lifetime to maintain consistent authentication behavior across the Active Directory environment.

---

## Maximum Lifetime for User Ticket

### Configured Value

**Not Defined**

### Purpose

Determines how long the Ticket Granting Ticket (TGT) remains valid.

### Implementation Rationale

The Ticket Granting Ticket serves as the primary authentication credential used to request Service Tickets. Because of its importance, its lifetime is centrally managed through the effective domain Kerberos policy.

---

## Maximum Lifetime for User Ticket Renewal

### Configured Value

**Not Defined**

### Purpose

Determines how long an existing Ticket Granting Ticket may be renewed without requiring a full user logon.

### Implementation Rationale

Allowing limited renewal improves usability while preventing indefinite reuse of authentication credentials.

---

## Maximum Tolerance for Computer Clock Synchronization

### Configured Value

**Not Defined**

### Purpose

Defines the maximum allowable clock difference between computers participating in Kerberos authentication.

### Implementation Rationale

Kerberos uses timestamps to prevent replay attacks. Maintaining synchronized time across the Active Directory domain is essential for successful authentication.

---

# Testing & Validation

During implementation, every Kerberos Policy setting within the **FTOS Workstation Baseline** Group Policy Object appeared as **Not Defined**.

Initial observations suggested that Kerberos Policy might not be enabled.

Further investigation demonstrated an important Active Directory concept:

**Not Defined does not mean Disabled.**

Instead, the OU-linked FTOS Workstation Baseline GPO is simply not configuring these settings.

Kerberos account policies are normally governed by the effective domain policy, allowing consistent authentication behavior across the entire Active Directory environment.

This exercise reinforced the importance of understanding Group Policy scope rather than assuming every visible setting is actively configured.

---

# Lessons Learned

This phase reinforced several important Active Directory concepts:

- Kerberos is Microsoft's default authentication protocol for Active Directory.
- Kerberos uses encrypted authentication tickets instead of repeatedly transmitting passwords.
- Ticket Granting Tickets (TGTs) request individual Service Tickets.
- Service Tickets authenticate users to individual network resources.
- Time synchronization is essential for Kerberos authentication.
- Kerberos helps prevent replay attacks through timestamp validation.
- Group Policy scope determines whether Kerberos settings are actively configured.
- **Not Defined** does not mean **Disabled**.
- Understanding why security settings exist is just as important as configuring them.

---

# Authentication Lifecycle

```text
User Logon
      │
      ▼
Kerberos Authentication
      │
      ▼
Ticket Granting Ticket (TGT)
      │
      ▼
Requests Service Ticket
      │
      ▼
Access Network Resource
      │
      ▼
Service Ticket Expires
      │
      ▼
Request New Service Ticket
```

---

# Evidence

The following screenshots document the Kerberos Policy review performed within the **FTOS Workstation Baseline** Group Policy Object.

# Evidence

The following screenshots document the review and analysis of the Kerberos Policy within the **FTOS Workstation Baseline** Group Policy Object.

| Screenshot | Description |
|------------|-------------|
| `GPO-Kerb-Init-Screenshot 2026-07-22 112922.png` | Initial Kerberos Policy view showing all policy settings as **Not Defined**. |
| `GPO-Kerb-Sett-Screenshot 2026-07-22 115824.png` | Kerberos Policy settings displayed within the FTOS Workstation Baseline GPO. |
| `GPO-Kerb-Explain-Screenshot 2026-07-22 120030.png` | Explain tab for Kerberos Policy demonstrating Microsoft's description of the selected policy setting. |
| `GPO-Kerb-Mx-Lf-Exp-Screenshot 2026-07-22 120928.png` | Maximum Lifetime for Service Ticket policy. |
| `GPO-Kerb-Mx-Lf-Tix-Screenshot 2026-07-22 121122.png` | Maximum Lifetime for User Ticket (Ticket Granting Ticket) policy. |
| `GPO-Mx-Lf-Tix-Renew-Screenshot 2026-07-22 121657.png` | Maximum Lifetime for User Ticket Renewal policy. |
| `GPO-Kerb-Clk-Sync-Screenshot 2026-07-22 122502.png` | Maximum Tolerance for Computer Clock Synchronization policy. |


---

# References

- Microsoft Learn – Kerberos Authentication
- Microsoft Learn – Kerberos Policy
- Microsoft Learn – Active Directory Authentication
- Microsoft Learn – Group Policy
- Windows Server Security Baselines
- CIS Microsoft Windows Server Benchmarks
