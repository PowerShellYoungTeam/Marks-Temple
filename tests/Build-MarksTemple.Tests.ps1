# --- DEBUG BLOCK: Place at the top of your test file ---

Write-Host "Current directory: $(Get-Location)"
Write-Host "PSScriptRoot: $PSScriptRoot"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot '..')
$scriptFile = Join-Path $repoRoot 'src/Build-MarksTemple.ps1'

# Search for Temple.txt anywhere in the repo
$templePathObj = Get-ChildItem -Path $repoRoot.Path -Recurse -Filter Temple.txt -File | Select-Object -First 1
$templePath = if ($templePathObj) { $templePathObj.FullName } else { $null }

Write-Host "Script file path: $scriptFile"
Write-Host "Script file exists: $(Test-Path $scriptFile)"
Write-Host "Temple file path: $templePath"
Write-Host "Temple file exists: $([bool]$templePath)"

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

Describe "Build-MarksTemple" {
    Context "Load" {
        It "Function should be loaded" {
            (Get-Command Build-MarksTemple -ErrorAction SilentlyContinue) | Should -Not -BeNullOrEmpty
        }
    }

    Context "Execution" {
        It "Temple file path should not be null or empty" {
            $templePath | Should -Not -BeNullOrEmpty
        }

        It "Temple file exists at $templePath" -Skip:(!$templePath) {
            Test-Path $templePath | Should -BeTrue
        }

        It "Runs with defaults" -Skip:(!$templePath) {
            { Build-MarksTemple -TemplePath $templePath } | Should -Not -Throw
        }

        It "Runs with custom colours" -Skip:(!$templePath) {
            { Build-MarksTemple -ForeGroundColour Red -BackGroundColour White -TemplePath $templePath } | Should -Not -Throw
        }

        It "Throws on invalid colour" -Skip:(!$templePath) {
            { Build-MarksTemple -ForeGroundColour Orange -TemplePath $templePath } | Should -Throw
        }
    }
}