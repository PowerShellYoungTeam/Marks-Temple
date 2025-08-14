# --- DEBUG BLOCK: Place at the top of your test file ---

Write-Host "Current directory: $(Get-Location)"
Write-Host "PSScriptRoot: $PSScriptRoot"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot '..')
$moduleFile = Join-Path $repoRoot 'src/Build-MarksTemple.psm1'

# Search for Temple.txt anywhere in the repo
$templePathObj = Get-ChildItem -Path $repoRoot.Path -Recurse -Filter Temple.txt -File | Select-Object -First 1
$templePath = if ($templePathObj) { $templePathObj.FullName } else { $null }

Write-Host "Module file path: $moduleFile"
Write-Host "Module file exists: $(Test-Path $moduleFile)"
Write-Host "Temple file path: $templePath"
Write-Host "Temple file exists: $([bool]$templePath)"

try {
    [void][System.Management.Automation.Language.Parser]::ParseFile($moduleFile, [ref]$null, [ref]$null)
    Write-Host "Module parsed OK."
}
catch {
    Write-Host "Module parse error: $_"
}

Import-Module $moduleFile -Force -Verbose
<#if ($Error.Count -gt 0) {
    Write-Host "Errors after Import-Module:"
    $Error | Format-List
}#>

Write-Host "Functions loaded:"
Get-Command -Type Function | Where-Object Name -like '*MarksTemple*' | Format-Table Name, Source

#$bytes = [System.IO.File]::ReadAllBytes($moduleFile)
#Write-Host "First bytes of module file: $($bytes[0..4] -join ',')"

Describe "Build-MarksTemple" {
    Context "Load" {
        It "Function should be loaded" {
            (Get-Command Build-MarksTemple -ErrorAction SilentlyContinue) | Should -Not -BeNullOrEmpty
        }
    }

    Context "Execution" {
        BeforeAll {
            # Move the file search here to ensure it runs in the correct scope
            $repoRoot = Resolve-Path (Join-Path $PSScriptRoot '..')
            $templePathObj = Get-ChildItem -Path $repoRoot.Path -Recurse -Filter Temple.txt -File | Select-Object -First 1
            $script:localTemplePath = if ($templePathObj) { $templePathObj.FullName } else { $null }

            Write-Host "BeforeAll: Setting up templePath: $script:localTemplePath"
        }

        It "Temple file path should not be null or empty" {
            $script:localTemplePath | Should -Not -BeNullOrEmpty
        }

        It "Temple file exists at $templePath" -Skip:(!$script:localTemplePath) {
            Test-Path $script:localTemplePath | Should -BeTrue
        }

        It "Runs with defaults" -Skip:(!$script:localTemplePath) {
            { Build-MarksTemple -TemplePath $script:localTemplePath -Verbose } | Should -Not -Throw
        }

        It "Runs with custom colours" -Skip:(!$script:localTemplePath) {
            { Build-MarksTemple -ForeGroundColour Red -BackGroundColour White -TemplePath $script:localTemplePath -Verbose } | Should -Not -Throw
        }

        It "Throws on invalid colour" -Skip:(!$script:localTemplePath) {
            { Build-MarksTemple -ForeGroundColour Orange -TemplePath $script:localTemplePath -Verbose } | Should -Throw
        }
    }
}