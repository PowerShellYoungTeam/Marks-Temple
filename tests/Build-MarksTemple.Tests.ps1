# Pester tests for Build-MarksTemple

$functionScript = Join-Path -Path $PSScriptRoot -ChildPath '..\src\Build-MarksTemple.ps1'
$functionScript = (Resolve-Path $functionScript).ProviderPath

Write-Host "Dot-sourcing: $functionScript"
. $functionScript

$templePath = Join-Path -Path $PSScriptRoot -ChildPath '..\src\Temple.txt'
if (-not (Test-Path $templePath)) {
    Write-Warning "Temple.txt not found at $templePath. Skipping tests."
    return
}

Describe "Build-MarksTemple load" {
    It "Function should be loaded" {
        (Get-Command Build-MarksTemple -ErrorAction SilentlyContinue) | Should -Not -BeNullOrEmpty
    }
}

Describe "Build-MarksTemple execution" {
    It "Runs with defaults" {
        { Build-MarksTemple -TemplePath $templePath } | Should -Not -Throw
    }
    It "Runs with custom colours" {
        { Build-MarksTemple -ForeGroundColour Red -BackGroundColour White -TemplePath $templePath } | Should -Not -Throw
    }
    It "Throws on invalid colour (foreground)" {
        { Build-MarksTemple -ForeGroundColour Orange -TemplePath $templePath } | Should -Throw
    }
}