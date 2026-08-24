<#
.SYNOPSIS
Tests enterprise Active Directory infrastructure baseline recreation
using an isolated temporary Active Directory structure.

.DESCRIPTION
Creates an isolated temporary infrastructure baseline that mirrors
the enterprise Organizational Unit and security group structure
without modifying the existing enterprise infrastructure.

The test workflow verifies Organizational Unit creation,
Organizational Unit protection settings, security group creation,
security group configuration, and post-creation verification.

Employee identity provisioning, security group membership assignment,
workstation domain joining, and workstation placement are outside
the scope of this test harness.

All test objects must remain contained within the temporary
08C-Recreation-Test Organizational Unit and must be removable
after verification.
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
# TEST ENVIRONMENT CONFIGURATION
# ============================================================

$TestRootOUName = "08C-Recreation-Test"
$TestRootOUDN   = "OU=$TestRootOUName,$($Domain.DistinguishedName)"

# ============================================================
# TEST ENVIRONMENT SAFETY CHECK
# ============================================================

$ExistingTestRoot = Get-ADOrganizationalUnit `
    -Filter "Name -eq '$TestRootOUName'" `
    -SearchBase $Domain.DistinguishedName `
    -SearchScope OneLevel `
    -ErrorAction SilentlyContinue

if ($ExistingTestRoot) {
    Write-Error "The test root OU already exists: $TestRootOUDN"
    Write-Host "Remove or review the existing test environment before running this harness."
    exit 1
}

# ============================================================
# TEST INFRASTRUCTURE BASELINE DATA
# ============================================================

$TestOUs = @(
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

$TestGroups = @(
    [PSCustomObject]@{
        Name           = "Accounting-08C"
        SamAccountName = "Accounting-08C"
        GroupScope     = "Global"
        GroupCategory  = "Security"
        TargetOU       = "Groups"
    }
    [PSCustomObject]@{
        Name           = "HR-08C"
        SamAccountName = "HR-08C"
        GroupScope     = "Global"
        GroupCategory  = "Security"
        TargetOU       = "Groups"
    }
    [PSCustomObject]@{
        Name           = "IT-08C"
        SamAccountName = "IT-08C"
        GroupScope     = "Global"
        GroupCategory  = "Security"
        TargetOU       = "Groups"
    }
    [PSCustomObject]@{
        Name           = "Managers-08C"
        SamAccountName = "Managers-08C"
        GroupScope     = "Global"
        GroupCategory  = "Security"
        TargetOU       = "Groups"
    }
)

# ============================================================
# TEST ROOT OU CREATION
# ============================================================

New-ADOrganizationalUnit `
    -Name $TestRootOUName `
    -Path $Domain.DistinguishedName `
    -ProtectedFromAccidentalDeletion $true `
    -ErrorAction Stop

Write-Host "Created test root OU: $TestRootOUName"

# ============================================================
# TEST ORGANIZATIONAL UNIT CREATION
# ============================================================

foreach ($OU in $TestOUs) {

    New-ADOrganizationalUnit `
        -Name $OU.Name `
        -Path $TestRootOUDN `
        -ProtectedFromAccidentalDeletion $OU.ProtectedFromAccidentalDeletion `
        -ErrorAction Stop

    Write-Host "Created test OU: $($OU.Name)"
}

# ============================================================
# TEST ORGANIZATIONAL UNIT VERIFICATION
# ============================================================

foreach ($OU in $TestOUs) {

    $ExpectedTestOUDN = "OU=$($OU.Name),$TestRootOUDN"

    $VerifiedTestOU = Get-ADOrganizationalUnit `
        -Identity $ExpectedTestOUDN `
        -Properties ProtectedFromAccidentalDeletion `
        -ErrorAction Stop

    if (
        $VerifiedTestOU.Name -eq $OU.Name -and
        $VerifiedTestOU.ProtectedFromAccidentalDeletion -eq $OU.ProtectedFromAccidentalDeletion
    ) {
        Write-Host "Verified test OU: $($OU.Name)"
    }
    else {
        Write-Error "Test OU verification failed: $($OU.Name)"
        exit 1
    }
}

# ============================================================
# TEST SECURITY GROUP CREATION
# ============================================================

foreach ($Group in $TestGroups) {

    $TestGroupPath = "OU=$($Group.TargetOU),$TestRootOUDN"

    New-ADGroup `
        -Name $Group.Name `
        -SamAccountName $Group.SamAccountName `
        -GroupScope $Group.GroupScope `
        -GroupCategory $Group.GroupCategory `
        -Path $TestGroupPath `
        -ErrorAction Stop

    Write-Host "Created test security group: $($Group.Name)"
}

# ============================================================
# TEST SECURITY GROUP VERIFICATION
# ============================================================

foreach ($Group in $TestGroups) {

    $ExpectedTestGroupDN = "CN=$($Group.Name),OU=$($Group.TargetOU),$TestRootOUDN"

    $VerifiedTestGroup = Get-ADGroup `
        -Identity $ExpectedTestGroupDN `
        -Properties GroupScope,GroupCategory `
        -ErrorAction Stop

    if (
        $VerifiedTestGroup.Name -eq $Group.Name -and
        $VerifiedTestGroup.SamAccountName -eq $Group.SamAccountName -and
        $VerifiedTestGroup.GroupScope -eq $Group.GroupScope -and
        $VerifiedTestGroup.GroupCategory -eq $Group.GroupCategory -and
        $VerifiedTestGroup.DistinguishedName -eq $ExpectedTestGroupDN
    ) {
        Write-Host "Verified test security group: $($Group.Name)"
    }
    else {
        Write-Error "Test security group verification failed: $($Group.Name)"
        exit 1
    }
}

# ============================================================
# FINAL TEST INFRASTRUCTURE VERIFICATION
# ============================================================

$TestVerificationFailures = @()

# Verify test Organizational Units
foreach ($OU in $TestOUs) {

    $ExpectedTestOUDN = "OU=$($OU.Name),$TestRootOUDN"

    try {
        $VerifiedTestOU = Get-ADOrganizationalUnit `
            -Identity $ExpectedTestOUDN `
            -Properties ProtectedFromAccidentalDeletion `
            -ErrorAction Stop

        if (
            $VerifiedTestOU.Name -ne $OU.Name -or
            $VerifiedTestOU.ProtectedFromAccidentalDeletion -ne $OU.ProtectedFromAccidentalDeletion -or
            $VerifiedTestOU.DistinguishedName -ne $ExpectedTestOUDN
        ) {
            $TestVerificationFailures += "OU: $($OU.Name)"
        }
    }
    catch {
        $TestVerificationFailures += "OU: $($OU.Name)"
    }
}

# Verify test security groups
foreach ($Group in $TestGroups) {

    $ExpectedTestGroupDN = "CN=$($Group.Name),OU=$($Group.TargetOU),$TestRootOUDN"

    try {
        $VerifiedTestGroup = Get-ADGroup `
            -Identity $Group.SamAccountName `
            -Properties GroupScope,GroupCategory `
            -ErrorAction Stop

        if (
            $VerifiedTestGroup.Name -ne $Group.Name -or
            $VerifiedTestGroup.SamAccountName -ne $Group.SamAccountName -or
            $VerifiedTestGroup.GroupScope -ne $Group.GroupScope -or
            $VerifiedTestGroup.GroupCategory -ne $Group.GroupCategory -or
            $VerifiedTestGroup.DistinguishedName -ne $ExpectedTestGroupDN
        ) {
            $TestVerificationFailures += "Group: $($Group.Name)"
        }
    }
    catch {
        $TestVerificationFailures += "Group: $($Group.Name)"
    }
}

if ($TestVerificationFailures.Count -gt 0) {

    Write-Error "Enterprise infrastructure recreation test verification failed."

    $TestVerificationFailures |
        Sort-Object -Unique |
        ForEach-Object {
            Write-Host "Failed verification: $_"
        }

    exit 1
}

Write-Host ""
Write-Host "============================================================"
Write-Host "ENTERPRISE INFRASTRUCTURE RECREATION TEST VERIFIED"
Write-Host "============================================================"
Write-Host ""
Write-Host "Test Organizational Units verified."
Write-Host "Test security groups verified."
Write-Host ""
Write-Host "Isolated infrastructure recreation test completed successfully."

# ============================================================
# CONTROLLED TEST ENVIRONMENT CLEANUP
# ============================================================

# Remove test security groups
foreach ($Group in $TestGroups) {

    $TestGroupDN = "CN=$($Group.Name),OU=$($Group.TargetOU),$TestRootOUDN"

    Remove-ADGroup `
        -Identity $TestGroupDN `
        -Confirm:$false `
        -ErrorAction Stop

    Write-Host "Removed test security group: $($Group.Name)"
}

# Disable accidental deletion protection on nested test OUs
foreach ($OU in $TestOUs) {

    $TestOUDN = "OU=$($OU.Name),$TestRootOUDN"

    Set-ADOrganizationalUnit `
        -Identity $TestOUDN `
        -ProtectedFromAccidentalDeletion $false `
        -ErrorAction Stop
}

# Remove nested test OUs
foreach ($OU in $TestOUs) {

    $TestOUDN = "OU=$($OU.Name),$TestRootOUDN"

    Remove-ADOrganizationalUnit `
        -Identity $TestOUDN `
        -Confirm:$false `
        -ErrorAction Stop

    Write-Host "Removed test OU: $($OU.Name)"
}

# Disable accidental deletion protection on the test root OU
Set-ADOrganizationalUnit `
    -Identity $TestRootOUDN `
    -ProtectedFromAccidentalDeletion $false `
    -ErrorAction Stop

# Remove the test root OU
Remove-ADOrganizationalUnit `
    -Identity $TestRootOUDN `
    -Confirm:$false `
    -ErrorAction Stop

Write-Host "Removed test root OU: $TestRootOUName"

# ============================================================
# POST-CLEANUP VERIFICATION
# ============================================================

$RemainingTestRoot = Get-ADOrganizationalUnit `
    -Filter "Name -eq '$TestRootOUName'" `
    -SearchBase $Domain.DistinguishedName `
    -SearchScope OneLevel `
    -ErrorAction SilentlyContinue

if ($RemainingTestRoot) {
    Write-Error "Test environment cleanup verification failed. The test root OU still exists: $TestRootOUDN"
    exit 1
}

Write-Host ""
Write-Host "============================================================"
Write-Host "TEST ENVIRONMENT CLEANUP VERIFIED"
Write-Host "============================================================"
Write-Host ""
Write-Host "Temporary test infrastructure successfully removed."
Write-Host "Existing enterprise infrastructure was not modified."
