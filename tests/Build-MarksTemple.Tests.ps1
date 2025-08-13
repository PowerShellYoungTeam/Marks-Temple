# --- DEBUG BLOCK: Place at the top of your test file ---

Write-Host "Current directory: $(Get-Location)"
Write-Host "PSScriptRoot: $PSScriptRoot"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot '..')
$scriptFile = Join-Path $repoRoot 'src/Build-MarksTemple.ps1'
$templePath = Join-Path $repoRoot 'src/Temple.txt'

Write-Host "Script file path: $scriptFile"
Write-Host "Script file exists: $(Test-Path $scriptFile)"
Write-Host "Temple file path: $templePath"
Write-Host "Temple file exists: $(Test-Path $templePath)"

Write-Host "First 10 lines of script file:"
Get-Content $scriptFile -TotalCount 10 | Write-Host

try {
    [void][System.Management.Automation.Language.Parser]::ParseFile($scriptFile, [ref]$null, [ref]$null)
    Write-Host "Script parsed OK."
}
catch {
    Write-Host "Script parse error: $_"
}

. $scriptFile
if ($Error.Count -gt 0) {
    Write-Host "Errors after dot-sourcing:"
    $Error | Format-List
}

Write-Host "Functions loaded:"
Get-Command -Type Function | Where-Object Name -like '*MarksTemple*' | Format-Table Name, Source

$bytes = [System.IO.File]::ReadAllBytes($scriptFile)
Write-Host "First bytes of script file: $($bytes[0..4] -join ',')"

# --- END DEBUG BLOCK ---
# Pester tests for Build-MarksTemple

$ErrorActionPreference = 'Stop'

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot '..')
$scriptFile = Join-Path $repoRoot 'src/Build-MarksTemple.ps1'
$rawTemple = Join-Path $repoRoot 'src/Temple.txt'

if (-not (Test-Path -LiteralPath $scriptFile)) {
    throw "Script file missing: $scriptFile"
}

# Resolve temple path if it exists
if (Test-Path -LiteralPath $rawTemple) {
    $templePath = (Resolve-Path -LiteralPath $rawTemple).ProviderPath
}

# Parse check
[void][System.Management.Automation.Language.Parser]::ParseFile($scriptFile, [ref]$null, [ref]$null)

. $scriptFile

Describe "Build-MarksTemple" {

    Context "Load" {
        It "Function should be loaded" {
            (Get-Command Build-MarksTemple -ErrorAction SilentlyContinue) | Should -Not -BeNullOrEmpty
        }
    }

    Context "Execution" {

        It "Temple file exists at $rawTemple" {
            Test-Path -LiteralPath $rawTemple | Should -BeTrue
        }

        It "Runs with defaults" -Skip:(!(Test-Path -LiteralPath $rawTemple)) {
            { Build-MarksTemple -TemplePath $templePath } | Should -Not -Throw
        }

        It "Runs with custom colours" -Skip:(!(Test-Path -LiteralPath $rawTemple)) {
            { Build-MarksTemple -ForeGroundColour Red -BackGroundColour White -TemplePath $templePath } | Should -Not -Throw
        }

        It "Throws on invalid colour" -Skip:(!(Test-Path -LiteralPath $rawTemple)) {
            { Build-MarksTemple -ForeGroundColour Orange -TemplePath $templePath } | Should -Throw
        }
    }
}