# Phase 07a – Password Policy

## Project Metadata

| Field | Value |
|--------|-------|
| **Project** | Active Directory Homelab |
| **Repository** | Active-Directory-Homelab |
| **Phase** | 07a – Password Policy |
| **Document** | 07a-password-policy.md |
| **Platform** | Windows Server 2022 |
| **Domain** | coachtorres.local |
| **Author** | Coach Torres |
| **Status** | In Progress |
| **Last Updated** | 2026-07-21 |

---

## Table of Contents

1. Objective
2. Prerequisites
3. Overview / Theory
4. Implementation
5. Verification
6. Lessons Learned
7. Enterprise Notes
8. Evidence
9. References

---

## Objective

Describe the purpose of configuring a domain password policy and explain how it strengthens authentication security within the Active Directory environment.

---

## Prerequisites

Before completing this phase, verify the following:

- Windows Server 2022 installed
- Active Directory Domain Services (AD DS) installed
- Domain controller operational
- Group Policy Baseline completed
- FTOS Workstation Baseline GPO created

---

## Overview / Theory

This section explains:

- Why password policies exist
- Password complexity
- Password history
- Password age
- Password length
- Reversible encryption
- Enterprise security considerations

---

## Implementation

Document each configuration step including:

- Opening Group Policy Management
- Editing the FTOS Workstation Baseline GPO
- Navigating to:

```

Computer Configuration
→ Policies
→ Windows Settings
→ Security Settings
→ Account Policies
→ Password Policy

```

For every policy include:

- Purpose
- Configured Value
- Reasoning

---

## Verification

Verify that:

- Group Policy applied successfully
- Password policy settings match expected values
- Test user behavior validates the configuration
- Any PowerShell or command-line verification used

---

## Lessons Learned

Document observations, challenges encountered, and what was learned during implementation.

---

## Enterprise Notes

Discuss how password policies are commonly implemented in enterprise environments, including security best practices and operational considerations.

---

## Evidence

Include:

- Screenshots
- PowerShell output
- Command Prompt output
- Group Policy Editor screenshots
- ADUC verification
- Git commit references (optional)

---

## References

Document Microsoft Learn articles, Microsoft documentation, CIS Benchmarks, or other authoritative resources used during this phase.
