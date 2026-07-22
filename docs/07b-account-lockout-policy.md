
# 07b – Account Lockout Policy

## Project Metadata

| Field | Value |
|--------|-------|
| **Project** | Active Directory Homelab |
| **Repository** | Active-Directory-Homelab |
| **Phase** | 07b |
| **Category** | Group Policy |
| **Component** | Account Lockout Policy |
| **Platform** | Windows Server 2022 |
| **Domain** | coachtorres.local |
| **GPO** | FTOS Baseline |
| **Tool** | Group Policy Management Console (GPMC) |
| **Author** | Coach Torres |
| **Status** | Complete |
| **Last Updated** | 2026-07-22 |

---

## Objective

Configure an enterprise-style Account Lockout Policy within the **FTOS Baseline** Group Policy Object to reduce the effectiveness of brute-force password attacks while maintaining a practical balance between security and user productivity.

---

## Background

Account Lockout Policy is a core Active Directory security control that protects domain user accounts from repeated password-guessing attempts.

Without an account lockout policy, attackers can continuously attempt passwords against an account until they discover the correct credentials. By temporarily locking an account after a defined number of failed logon attempts, organizations significantly slow brute-force attacks and reduce the likelihood of unauthorized access.

A well-designed policy must balance:

- Security
- User productivity
- Help Desk workload
- Business continuity

Policies that are too restrictive increase unnecessary lockouts and support requests, while policies that are too lenient provide attackers additional opportunities to guess passwords.

---

## Enterprise Use Case

Most enterprise environments implement Account Lockout Policies as part of their security baseline.

Typical objectives include:

- Slowing brute-force password attacks
- Protecting privileged and standard user accounts
- Reducing credential abuse
- Supporting organizational security policies and compliance requirements

The exact configuration varies depending on an organization's security posture, regulatory requirements, MFA deployment, and operational needs.

---

## Configuration Path

```
Computer Configuration
└── Policies
    └── Windows Settings
        └── Security Settings
            └── Account Policies
                └── Account Lockout Policy
```

---

## Configuration Summary

| Setting | Configured Value | Purpose |
|----------|-----------------|---------|
| Account Lockout Threshold | **5 invalid logon attempts** | Limits repeated authentication failures before locking the account. |
| Account Lockout Duration | **10 minutes** | Automatically unlocks the account after a short delay, reducing unnecessary Help Desk requests. |
| Reset Account Lockout Counter After | **10 minutes** | Clears the failed-attempt counter after the defined interval, providing a predictable security policy. |

---

## Implementation

### Account Lockout Threshold

**Configured Value**

**5 invalid logon attempts**

**Purpose**

Defines how many failed authentication attempts are allowed before Windows temporarily locks the account.

**Implementation Rationale**

Five attempts provide a practical balance between security and usability by allowing users several opportunities to correct typing mistakes while limiting repeated password guessing.

---

### Account Lockout Duration

**Configured Value**

**10 minutes**

**Purpose**

Determines how long an account remains locked before automatically becoming available again.

**Implementation Rationale**

A 10-minute lockout was selected to reduce unnecessary downtime for legitimate users while still slowing automated password attacks.

This value minimizes Help Desk involvement while maintaining an effective deterrent against repeated authentication attempts.

---

### Reset Account Lockout Counter After

**Configured Value**

**10 minutes**

**Purpose**

Determines how long Windows remembers failed authentication attempts before resetting the counter back to zero.

**Implementation Rationale**

Testing performed during implementation demonstrated that Windows Server requires this value to remain consistent with the configured Account Lockout Duration through the Group Policy editor.

The final configuration provides a simple, predictable policy while satisfying the platform's configuration requirements.

---

## Testing & Validation

The Account Lockout Policy was configured within the **FTOS Baseline** Group Policy Object using the Group Policy Management Console.

During testing, multiple configurations were evaluated.

An initial design proposed:

- Account Lockout Duration: **10 minutes**
- Reset Account Lockout Counter After: **15 minutes**

Windows Server would not accept this configuration through the Group Policy editor.

The final validated configuration consists of:

- Threshold: **5 attempts**
- Lockout Duration: **10 minutes**
- Reset Counter: **10 minutes**

This exercise demonstrated the importance of validating configuration decisions through hands-on testing rather than assumptions.

---

## Lessons Learned

This phase reinforced several important Active Directory concepts:

- Account Lockout Policy consists of three interdependent settings.
- Security controls must balance protection with operational usability.
- Windows Server enforces relationships between Account Lockout Policy settings.
- Engineering decisions should be validated through testing.
- Documentation should explain both **what** was configured and **why** it was configured.

---

## Evidence

### Screenshot 1

Account Lockout Threshold configured to **5 invalid logon attempts**.

### Screenshot 2

Account Lockout Duration configured to **10 minutes**.

### Screenshot 3

Reset Account Lockout Counter configured to **10 minutes**.

### Screenshot 4

Completed Account Lockout Policy showing all configured settings.

The following screenshots document the implementation and validation of the Account Lockout Policy within the **FTOS Baseline** Group Policy Object.

| Screenshot | Description |
|------------|-------------|
| `GPO-Acct-Lckot-Screenshot 2026-07-22 081825.png` | Configured **Account Lockout Threshold** to 5 invalid logon attempts. |
| `GPO-Acct-Lckot-Drn-Screenshot 2026-07-22 083518.png` | Configured **Account Lockout Duration** to 10 minutes. |
| `GPO-Acct-Lckot-Ctr-Screenshot 2026-07-22 083751.png` | Configured **Reset Account Lockout Counter After** to 10 minutes. |
| `GPO-Acct-Lckot-Overview-Screenshot 2026-07-22 084200.png` | Final Account Lockout Policy overview showing all configured settings. |

---

## References

- Microsoft Learn – Group Policy
- Microsoft Learn – Account Lockout Policy
- Windows Server Security Baselines
