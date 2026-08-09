function Get-EnterpriseOU {

    Get-ADOrganizationalUnit -Filter * |
        Select-Object Name, DistinguishedName |
        Sort-Object Name

}

function Get-EnterpriseObjectOU {

    param (
        [Parameter(Mandatory)]
        [string]$Identity
    )

    Get-ADObject -Identity $Identity -Properties DistinguishedName |
        Select-Object Name, ObjectClass, DistinguishedName
}

function Test-EnterpriseObjectOU {

    param (
        [Parameter(Mandatory)]
        [string]$Identity,

        [Parameter(Mandatory)]
        [string]$ExpectedOU
    )

    $Object = Get-ADObject -Identity $Identity

    $Object.DistinguishedName -like "*,$ExpectedOU"
}

function Move-EnterpriseADObject {

    param (
        [Parameter(Mandatory)]
        [string]$Identity,

        [Parameter(Mandatory)]
        [string]$TargetOU
    )

    $Object = Get-ADObject -Identity $Identity

    Move-ADObject `
        -Identity $Object `
        -TargetPath $TargetOU

    $MovedObject = Get-ADObject -Identity $Object.ObjectGUID

    $MovedObject.DistinguishedName -like "*,$TargetOU"
}

function Get-EnterpriseOUReport {

    $OUs = Get-ADOrganizationalUnit -Filter * |
        Sort-Object Name

    foreach ($OU in $OUs) {

        $Objects = Get-ADObject `
            -Filter * `
            -SearchBase $OU.DistinguishedName `
            -SearchScope OneLevel

        foreach ($Object in $Objects) {

            [PSCustomObject]@{
                OU                = $OU.Name
                Name              = $Object.Name
                ObjectClass       = $Object.ObjectClass
                DistinguishedName = $Object.DistinguishedName
            }
        }
    }
}