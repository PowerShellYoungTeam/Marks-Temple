# Create this as .\build\Update-Version.ps1
param(
    [Parameter()]
    [ValidateSet('Major', 'Minor', 'Patch')]
    [string]$BumpType = 'Patch',

    [Parameter()]
    [string]$PreRelease = ''
)

# Load current version
$versionFile = Join-Path $PSScriptRoot '..\version.json'
$version = Get-Content -Path $versionFile | ConvertFrom-Json

# Update version
switch ($BumpType) {
    'Major' {
        $version.major++
        $version.minor = 0
        $version.patch = 0
    }
    'Minor' {
        $version.minor++
        $version.patch = 0
    }
    'Patch' {
        $version.patch++
    }
}
$version.prerelease = $PreRelease

# Save version
$version | ConvertTo-Json | Set-Content -Path $versionFile

# Update module manifest
$manifestPath = Join-Path $PSScriptRoot '..\src\Build-MarksTemple.psd1'
$versionString = "{0}.{1}.{2}" -f $version.major, $version.minor, $version.patch
if ($PreRelease) {
    $versionString += "-$PreRelease"
}

Update-ModuleManifest -Path $manifestPath -ModuleVersion $versionString

Write-Host "Updated version to $versionString"