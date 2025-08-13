# Pester tests for Build-MarksTemple

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