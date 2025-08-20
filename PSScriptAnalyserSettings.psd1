# Create a file at the repo root: PSScriptAnalyzerSettings.psd1
@{
    Severity     = @('Error', 'Warning')
    ExcludeRules = @(
        # Add any rules you want to exclude
    )
    Rules        = @{
        PSAvoidUsingWriteHost = @{
            # Exception for this module since it's a visual console app
            Enable = $false
        }
    }
}