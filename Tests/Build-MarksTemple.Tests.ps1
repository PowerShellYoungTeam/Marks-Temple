# Pester tests for Build-MarksTemple

# Load the script
. "$PSScriptRoot\..\src\Build-MarksTemple.ps1"

$templePath = "$PSScriptRoot\..\Temple.txt"

if (-not (Test-Path $templePath)) {
    Write-Warning "Temple.txt not found at $templePath. Skipping Build-MarksTemple tests."
    return
}

Describe "Build-MarksTemple" {
    It "Should run without error using default parameters" {
        { Build-MarksTemple } | Should -Not -Throw
    }

    It "Should run with custom colours" {
        { Build-MarksTemple -ForeGroundColour 'Red' -BackGroundColour 'White' } | Should -Not -Throw
    }

    It "Should throw with invalid colour" {
        { Build-MarksTemple -ForeGroundColour 'Orange' } | Should -Throw
    }
}