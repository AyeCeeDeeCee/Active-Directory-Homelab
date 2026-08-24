<#
.SYNOPSIS
Recreates the enterprise Active Directory infrastructure baseline.

.DESCRIPTION
Recreates the verified Active Directory infrastructure
baseline for the Active-Directory-Homelab project in a
clean deployment.

The workflow recreates the enterprise Organizational Unit
structure, Organizational Unit protection settings,
security groups, and required security group configuration.

Employee identity provisioning, security group membership
assignment, workstation domain joining, and workstation
placement are separate operational lifecycle responsibilities.

This script must not be executed against an environment
where the enterprise infrastructure baseline already exists.
#>

# ============================================================
# PREREQUISITE VALIDATION
# ============================================================

try {
    Import-Module ActiveDirectory -ErrorAction Stop
}
catch {
    Write-Error "The Active Directory PowerShell module could not be loaded."
    exit 1
}

try {
    $Domain = Get-ADDomain -ErrorAction Stop
}
catch {
    Write-Error "An Active Directory domain could not be detected."
    exit 1
}

# ============================================================
# EXISTING INFRASTRUCTURE SAFETY CHECK
# ============================================================

$InfrastructureOUs = @(
    "Admin"
    "Employees"
    "Groups"
    "Lab"
    "Service Accounts"
    "Workstations"
)

$InfrastructureGroups = @(
    "Accounting"
    "HR"
    "IT"
    "Managers"
)

$ExistingBaselineObjects = @()

foreach ($OU in $InfrastructureOUs) {
    $ExistingOU = Get-ADOrganizationalUnit -Filter "Name -eq '$OU'" `
        -SearchBase $Domain.DistinguishedName `
        -ErrorAction SilentlyContinue

    if ($ExistingOU) {
        $ExistingBaselineObjects += "OU: $OU"
    }
}

foreach ($Group in $InfrastructureGroups) {
    $ExistingGroup = Get-ADGroup -Filter "Name -eq '$Group'" `
        -ErrorAction SilentlyContinue

    if ($ExistingGroup) {
        $ExistingBaselineObjects += "Group: $Group"
    }
}

if ($ExistingBaselineObjects.Count -gt 0) {
    Write-Error "Enterprise infrastructure baseline objects already exist. Infrastructure recreation has been blocked."
    $ExistingBaselineObjects | ForEach-Object {
        Write-Host "Detected: $_"
    }
    exit 1
}

# ============================================================
# ENTERPRISE INFRASTRUCTURE BASELINE DATA
# ============================================================

$BaselineOUs = @(
    [PSCustomObject]@{
        Name = "Admin"
        ProtectedFromAccidentalDeletion = $true
    }
    [PSCustomObject]@{
        Name = "Employees"
        ProtectedFromAccidentalDeletion = $true
    }
    [PSCustomObject]@{
        Name = "Groups"
        ProtectedFromAccidentalDeletion = $true
    }
    [PSCustomObject]@{
        Name = "Lab"
        ProtectedFromAccidentalDeletion = $true
    }
    [PSCustomObject]@{
        Name = "Service Accounts"
        ProtectedFromAccidentalDeletion = $true
    }
    [PSCustomObject]@{
        Name = "Workstations"
        ProtectedFromAccidentalDeletion = $true
    }
)

$BaselineGroups = @(
    [PSCustomObject]@{
        Name          = "Accounting"
        SamAccountName = "Accounting"
        GroupScope    = "Global"
        GroupCategory = "Security"
        TargetOU      = "Groups"
    }
    [PSCustomObject]@{
        Name          = "HR"
        SamAccountName = "HR"
        GroupScope    = "Global"
        GroupCategory = "Security"
        TargetOU      = "Groups"
    }
    [PSCustomObject]@{
        Name          = "IT"
        SamAccountName = "IT"
        GroupScope    = "Global"
        GroupCategory = "Security"
        TargetOU      = "Groups"
    }
    [PSCustomObject]@{
        Name          = "Managers"
        SamAccountName = "Managers"
        GroupScope    = "Global"
        GroupCategory = "Security"
        TargetOU      = "Groups"
    }
)

# ============================================================
# ORGANIZATIONAL UNIT RECREATION
# ============================================================

foreach ($OU in $BaselineOUs) {

    $OUPath = $Domain.DistinguishedName

    New-ADOrganizationalUnit `
        -Name $OU.Name `
        -Path $OUPath `
        -ProtectedFromAccidentalDeletion $OU.ProtectedFromAccidentalDeletion `
        -ErrorAction Stop

    Write-Host "Created OU: $($OU.Name)"
}

# ============================================================
# ORGANIZATIONAL UNIT VERIFICATION
# ============================================================

foreach ($OU in $BaselineOUs) {

    $ExpectedDN = "OU=$($OU.Name),$($Domain.DistinguishedName)"

    $VerifiedOU = Get-ADOrganizationalUnit `
        -Identity $ExpectedDN `
        -Properties ProtectedFromAccidentalDeletion `
        -ErrorAction Stop

    if (
        $VerifiedOU.Name -eq $OU.Name -and
        $VerifiedOU.ProtectedFromAccidentalDeletion -eq $OU.ProtectedFromAccidentalDeletion
    ) {
        Write-Host "Verified OU: $($OU.Name)"
    }
    else {
        Write-Error "OU verification failed: $($OU.Name)"
        exit 1
    }
}

# ============================================================
# SECURITY GROUP RECREATION
# ============================================================

foreach ($Group in $BaselineGroups) {

    $GroupPath = "OU=$($Group.TargetOU),$($Domain.DistinguishedName)"

    New-ADGroup `
        -Name $Group.Name `
        -SamAccountName $Group.SamAccountName `
        -GroupScope $Group.GroupScope `
        -GroupCategory $Group.GroupCategory `
        -Path $GroupPath `
        -ErrorAction Stop

    Write-Host "Created security group: $($Group.Name)"
}

# ============================================================
# SECURITY GROUP VERIFICATION
# ============================================================

foreach ($Group in $BaselineGroups) {

    $ExpectedGroupDN = "CN=$($Group.Name),OU=$($Group.TargetOU),$($Domain.DistinguishedName)"

    $VerifiedGroup = Get-ADGroup `
        -Identity $ExpectedGroupDN `
        -Properties GroupScope,GroupCategory `
        -ErrorAction Stop

    if (
        $VerifiedGroup.Name -eq $Group.Name -and
        $VerifiedGroup.SamAccountName -eq $Group.SamAccountName -and
        $VerifiedGroup.GroupScope -eq $Group.GroupScope -and
        $VerifiedGroup.GroupCategory -eq $Group.GroupCategory
    ) {
        Write-Host "Verified security group: $($Group.Name)"
    }
    else {
        Write-Error "Security group verification failed: $($Group.Name)"
        exit 1
    }
}

# ============================================================
# FINAL BASELINE VERIFICATION
# ============================================================

$VerificationFailures = @()

# Verify Organizational Units
foreach ($OU in $BaselineOUs) {

    $ExpectedDN = "OU=$($OU.Name),$($Domain.DistinguishedName)"

    try {
        $VerifiedOU = Get-ADOrganizationalUnit `
            -Identity $ExpectedDN `
            -Properties ProtectedFromAccidentalDeletion `
            -ErrorAction Stop

        if (
            $VerifiedOU.Name -ne $OU.Name -or
            $VerifiedOU.ProtectedFromAccidentalDeletion -ne $OU.ProtectedFromAccidentalDeletion -or
            $VerifiedOU.DistinguishedName -ne $ExpectedDN
        ) {
            $VerificationFailures += "OU: $($OU.Name)"
        }
    }
    catch {
        $VerificationFailures += "OU: $($OU.Name)"
    }
}

# Verify security groups
foreach ($Group in $BaselineGroups) {

    $ExpectedGroupDN = "CN=$($Group.Name),OU=$($Group.TargetOU),$($Domain.DistinguishedName)"

    try {
        $VerifiedGroup = Get-ADGroup `
            -Identity $Group.SamAccountName `
            -Properties GroupScope,GroupCategory `
            -ErrorAction Stop

        if (
            $VerifiedGroup.Name -ne $Group.Name -or
            $VerifiedGroup.SamAccountName -ne $Group.SamAccountName -or
            $VerifiedGroup.GroupScope -ne $Group.GroupScope -or
            $VerifiedGroup.GroupCategory -ne $Group.GroupCategory -or
            $VerifiedGroup.DistinguishedName -ne $ExpectedGroupDN
        ) {
            $VerificationFailures += "Group: $($Group.Name)"
        }
    }
    catch {
        $VerificationFailures += "Group: $($Group.Name)"
    }
}

# Final result
if ($VerificationFailures.Count -gt 0) {

    Write-Error "Enterprise infrastructure recreation verification failed."

    $VerificationFailures |
        Sort-Object -Unique |
        ForEach-Object {
            Write-Host "Failed verification: $_"
        }

    exit 
}

Write-Host ""
Write-Host "============================================================"
Write-Host "ENTERPRISE ACTIVE DIRECTORY INFRASTRUCTURE RECREATION VERIFIED"
Write-Host "============================================================"
Write-Host ""
Write-Host "Enterprise Organizational Units verified."
Write-Host "Enterprise security groups verified."
Write-Host ""
Write-Host "Enterprise infrastructure recreation completed successfully."
