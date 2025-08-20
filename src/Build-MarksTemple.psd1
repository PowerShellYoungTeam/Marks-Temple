@{
    # Module manifest for Build-MarksTemple
    RootModule = 'Build-MarksTemple.psm1'
    
    # Version number of this module.
    ModuleVersion = '1.0.0'
    
    # Supported PSEditions
    # CompatiblePSEditions = @()
    
    # ID used to uniquely identify this module
    GUID = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890'
    
    # Author of this module
    Author = 'PowerShellYoungTeam'
    
    # Company or vendor of this module
    CompanyName = 'PowerShellYoungTeam'
    
    # Copyright statement for this module
    Copyright = '(c) PowerShellYoungTeam. All rights reserved.'
    
    # Description of the functionality provided by this module
    Description = 'A PowerShell module that builds a Temple in honour of Dark mode in Procmon. Renders ASCII art temple with custom colours.'
    
    # Minimum version of the PowerShell engine required by this module
    PowerShellVersion = '5.1'
    
    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport = @('Build-MarksTemple')
    
    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport = @()
    
    # Variables to export from this module
    VariablesToExport = '*'
    
    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport = @()
    
    # DSC resources to export from this module
    # DscResourcesToExport = @()
    
    # List of all modules packaged with this module
    # ModuleList = @()
    
    # List of all files packaged with this module
    FileList = @('Build-MarksTemple.psm1', 'Temple.txt', 'Build-MarksTemple.psd1')
    
    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData = @{
        PSData = @{
            # Tags applied to this module. These help with module discovery in online galleries.
            Tags = @('ASCII', 'Art', 'Temple', 'Console', 'Procmon', 'SysInternals', 'Fun', 'PowerShell')
            
            # A URL to the license for this module.
            LicenseUri = 'https://github.com/PowerShellYoungTeam/Marks-Temple/blob/main/LICENSE'
            
            # A URL to the main website for this project.
            ProjectUri = 'https://github.com/PowerShellYoungTeam/Marks-Temple'
            
            # A URL to an icon representing this module.
            # IconUri = ''
            
            # ReleaseNotes of this module
            ReleaseNotes = 'Initial release of the Temple builder in honour of Dark mode in Procmon.'
            
            # Prerelease string of this module
            # Prerelease = ''
            
            # Flag to indicate whether the module requires explicit user acceptance for install/update/save
            # RequireLicenseAcceptance = $false
            
            # External dependent modules of this module
            # ExternalModuleDependencies = @()
        } # End of PSData hashtable
    } # End of PrivateData hashtable
    
    # HelpInfo URI of this module
    # HelpInfoURI = ''
    
    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''
}