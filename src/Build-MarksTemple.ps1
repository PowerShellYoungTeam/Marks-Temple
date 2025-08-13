Function Build-MarksTemple {
    <#
    .SYNOPSIS
    Builds a Temple in honour of Dark mode in Procmon.

    .DESCRIPTION
    Renders the contents of a temple ASCII art file to the console with specified foreground
    and background colours. Reads ASCII from Temple.txt by default (same folder as this script).

    .PARAMETER ForeGroundColour
    Foreground colour for the ASCII art. Default Yellow.

    .PARAMETER BackGroundColour
    Background colour for the ASCII art. Default Black.

    .PARAMETER TemplePath
    Path to the temple ASCII art file. Defaults to 'Temple.txt' beside this script.

    .EXAMPLE
    Build-MarksTemple
    Renders using defaults.

    .EXAMPLE
    Build-MarksTemple -ForeGroundColour Red -BackGroundColour White

    .EXAMPLE
    Build-MarksTemple -TemplePath 'C:\Custom\Temple.txt'

    .NOTES
    Valid colours (ConsoleColor): Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta,
    DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White.
    #>
    [CmdletBinding()]
    param(
        [ValidateSet("Black", "DarkBlue", "DarkGreen", "DarkCyan", "DarkRed", "DarkMagenta", "DarkYellow", "Gray", "DarkGray", "Blue", "Green", "Cyan", "Red", "Magenta", "Yellow", "White")]
        [string]$ForeGroundColour = "Yellow",
        [ValidateSet("Black", "DarkBlue", "DarkGreen", "DarkCyan", "DarkRed", "DarkMagenta", "DarkYellow", "Gray", "DarkGray", "Blue", "Green", "Cyan", "Red", "Magenta", "Yellow", "White")]
        [string]$BackGroundColour = "Black",
        [string]$TemplePath = (Join-Path -Path $PSScriptRoot -ChildPath 'Temple.txt')
    )

    if (-not (Test-Path -LiteralPath $TemplePath)) {
        Write-Warning "Temple file not found: $TemplePath"
        return
    }

    Get-Content -LiteralPath $TemplePath | ForEach-Object {
        Write-Host $_ -ForegroundColor $ForeGroundColour -BackgroundColor $BackGroundColour
    }
}