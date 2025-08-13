Function Build-MarksTemple {
    <#
    .SYNOPSIS
    Builds a Temple in honour of Dark mode in Procmon.

    .DESCRIPTION
    Renders the contents of a temple ASCII art file to the console with specified foreground and background colours.

    .PARAMETER ForeGroundColour
    The colour to use for the temple text. Default is Yellow.

    .PARAMETER BackGroundColour
    The colour to use for the temple background. Default is Black.

    .PARAMETER TemplePath
    Path to the temple ASCII art file. Defaults to 'Temple.txt' in the script directory.

    .EXAMPLE
    Build-MarksTemple
    Displays the temple using default colours.

    .EXAMPLE
    Build-MarksTemple -ForeGroundColour 'Red' -BackGroundColour 'White'
    Displays the temple in red text on a white background.

    .EXAMPLE
    Build-MarksTemple -TemplePath 'C:\Custom\Temple.txt'
    Displays a custom temple file.

    .NOTES
    Valid colours: Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White.

    .OUTPUTS
    None. Writes output to the console.

    .WARNINGS
    If the temple file is missing, a warning is displayed and nothing is rendered.

    .AUTHOR
    Steven Wight
    #>
    [CmdletBinding()]
    param(
        [Parameter()] [String] [ValidateSet("Black", "DarkBlue", "DarkGreen", "DarkCyan", "DarkRed", "DarkMagenta", "DarkYellow", "Gray", "DarkGray", "Blue", "Green", "Cyan", "Red", "Magenta", "Yellow", "White")] $ForeGroundColour = "YELLOW",
        [Parameter()] [String] [ValidateSet("Black", "DarkBlue", "DarkGreen", "DarkCyan", "DarkRed", "DarkMagenta", "DarkYellow", "Gray", "DarkGray", "Blue", "Green", "Cyan", "Red", "Magenta", "Yellow", "White")] $BackGroundColour = "BLACK",
        [Parameter()] [String] $TemplePath = "$PSScriptRoot\Temple.txt"
    )
    if (-not (Test-Path $TemplePath)) {
        Write-Warning "Temple file not found at $TemplePath"
        return
    }
    Get-Content $TemplePath | Write-Host -ForegroundColor $ForeGroundColour -BackgroundColor $BackGroundColour
}