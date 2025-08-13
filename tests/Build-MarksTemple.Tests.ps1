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