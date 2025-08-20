# Create a file at the repo root: PSScriptAnalyzerSettings.psd1
@{
    Severity     = @('Error', 'Warning')
    ExcludeRules = @(
        'PSAvoidUsingWriteHost',
        'PSUseToExportFieldsInManifest'
    )
    Rules        = @{
        PSAvoidUsingWriteHost = @{
            # Exception for this module since it's a visual console app
            Enable = $false
        }
    }
}