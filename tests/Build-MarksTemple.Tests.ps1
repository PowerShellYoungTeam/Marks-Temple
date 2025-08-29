# --- DEBUG BLOCK: Place at the top of your test file ---

Write-Host "Current directory: $(Get-Location)"
Write-Host "PSScriptRoot: $PSScriptRoot"
$repoRoot = Resolve-Path (Join-Path $PSScriptRoot '..')
$moduleFile = Join-Path $repoRoot 'src\MarksTemple\MarksTemple.psm1'

# Search for Temple.txt anywhere in the repo
$templePathObj = Get-ChildItem -Path $repoRoot.Path -Recurse -Filter Temple.txt -File | Select-Object -First 1
$templePath = if ($templePathObj) { $templePathObj.FullName } else { $null }

Write-Host "Module file path: $moduleFile"
Write-Host "Module file exists: $(Test-Path $moduleFile)"
Write-Host "Temple file path: $templePath"
Write-Host "Temple file exists: $(Test-Path $templePath -ErrorAction SilentlyContinue)"

try {
    [void][System.Management.Automation.Language.Parser]::ParseFile($moduleFile, [ref]$null, [ref]$null)
    Write-Host "Module parsed OK."
}
catch {
    Write-Host "Module parse error: $_"
}

Import-Module $moduleFile -Force -Verbose

Write-Host "Functions loaded:"
Get-Command -Type Function | Where-Object Name -like '*MarksTemple*' | Format-Table Name, Source
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
            # Write-Host "BeforeAll: Setting up templePath: $script:localTemplePath"  # Removed debug output
            # Write-Host "Temple file exists in BeforeAll: $(Test-Path $script:localTemplePath -ErrorAction SilentlyContinue)"  # Removed debug output
        }

        It "Temple file path should not be null or empty" {
            $script:localTemplePath | Should -Not -BeNullOrEmpty
        }

        # Fixed: Use $script:localTemplePath in the test name and removed skip condition
        It "Temple file exists at path" {
            Test-Path $script:localTemplePath | Should -BeTrue
        }

        # Fixed: Removed skip conditions since we've verified the path exists
        It "Runs with defaults" {
            { Build-MarksTemple -TemplePath $script:localTemplePath -Verbose } | Should -Not -Throw
        }

        It "Runs with custom colours" {
            { Build-MarksTemple -ForeGroundColour Red -BackGroundColour White -TemplePath $script:localTemplePath -Verbose } | Should -Not -Throw
        }

        It "Throws on invalid colour" {
            { Build-MarksTemple -ForeGroundColour Orange -TemplePath $script:localTemplePath -Verbose } | Should -Throw
        }
    }
}