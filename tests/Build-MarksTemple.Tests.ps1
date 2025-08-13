# Pester tests for Build-MarksTemple

if ($IsWindows) {
    $scriptPath = Resolve-Path "$PSScriptRoot\..\src\Build-MarksTemple.ps1"
    $templePath = Resolve-Path "$PSScriptRoot\..\src\Temple.txt"
}
else {
    $scriptPath = Resolve-Path "$PSScriptRoot/../src/Build-MarksTemple.ps1"
    $templePath = Resolve-Path "$PSScriptRoot/../src/Temple.txt"
}

. $scriptPath.Path

if (-not (Test-Path $templePath.Path)) {
    Write-Warning "Temple.txt not found at $($templePath.Path). Skipping Build-MarksTemple tests."
    return
}

Describe "Build-MarksTemple" {
    It "Should run without error using default parameters" {
        { Build-MarksTemple -TemplePath $templePath.Path } | Should -Not -Throw
    }

    It "Should run with custom colours" {
        { Build-MarksTemple -ForeGroundColour 'Red' -BackGroundColour 'White' -TemplePath $templePath.Path } | Should -Not -Throw
    }

    It "Should throw with invalid colour" {
        { Build-MarksTemple -ForeGroundColour 'Orange' -TemplePath $templePath.Path } | Should -Throw
    }
}