Function Build-MarksTemple{
    <#
    .SYNOPSIS
    Function that builds a Temple in honour of Dark mode in Procmon
    by Steven Wight
    .DESCRIPTION
    Build-MarksTemple -ForeGroundColour <Colour> Default = Yellow -BackgroundColor <Colour> Default Black
    .EXAMPLE
    Build-MarksTemple RED BLACK
    .NOTES
    can take any of these as ForeGround or BackGround Colours
    "Black","DarkBlue","DarkGreen","DarkCyan","DarkRed","DarkMagenta","DarkYellow","Gray","DarkGray","Blue","Green","Cyan","Red","Magenta","Yellow","White"
    #>
    [CmdletBinding()]
    param(
    [Parameter()] [String] [ValidateSet("Black","DarkBlue","DarkGreen","DarkCyan","DarkRed","DarkMagenta","DarkYellow","Gray","DarkGray","Blue","Green","Cyan","Red","Magenta","Yellow","White")] $ForeGroundColour = "YELLOW",  
    [Parameter()] [String] [ValidateSet("Black","DarkBlue","DarkGreen","DarkCyan","DarkRed","DarkMagenta","DarkYellow","Gray","DarkGray","Blue","Green","Cyan","Red","Magenta","Yellow","White")] $BackGroundColour = "BLACK"
    )
get-content .\Temple.txt | write-host -ForegroundColor $ForeGroundColour -BackgroundColor $BackGroundColour
}