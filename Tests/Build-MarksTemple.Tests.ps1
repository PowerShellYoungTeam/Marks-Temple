# Pester tests for Build-MarksTemple

# Load the script
. "$PSScriptRoot\..\src\Build-MarksTemple.ps1"

$templePath = "$PSScriptRoot\..\src\Temple.txt"

if (-not (Test-Path $templePath)) {
    Write-Warning "Temple.txt not found at $templePath. Skipping Build-MarksTemple tests."
    return
}

Describe "Build-MarksTemple" {
    It "Should run without error using default parameters" {
        { Build-MarksTemple -TemplePath $templePath } | Should -Not -Throw
    }

    It "Should run with custom colours" {
        { Build-MarksTemple -ForeGroundColour 'Red' -BackGroundColour 'White' -TemplePath $templePath } | Should -Not -Throw
    }

    It "Should throw with invalid colour" {
        { Build-MarksTemple -ForeGroundColour 'Orange' -TemplePath $templePath } | Should -Throw
    }
}