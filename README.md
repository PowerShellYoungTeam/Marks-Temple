# Marks-Temple

A PowerShell module that builds a Temple in honour of Dark mode in Procmon.

This was promised to Mark Russinovich after hours burning my eyes staring at Procmon logs
[Twitter Thread](https://x.com/PoSHYoungTeam/status/1418667570920570881)

![CI](https://github.com/PowerShellYoungTeam/Marks-Temple/actions/workflows/ci.yml/badge.svg)
[![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/Build-MarksTemple)](https://www.powershellgallery.com/packages/Build-MarksTemple)
[![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/Build-MarksTemple)](https://www.powershellgallery.com/packages/Build-MarksTemple)

## Features

- Renders ASCII art temple with custom colours
- Easy to use and extend
- Cross-platform support (Windows, Linux, macOS)

## Installation

### PowerShell Gallery (Recommended)

```powershell
Install-Module -Name Build-MarksTemple -Scope CurrentUser
```

# Clone the repository
git clone https://github.com/PowerShellYoungTeam/Marks-Temple.git
cd Marks-Temple

# Import the module
Import-Module ./src/Build-MarksTemple.psm1

# Display the temple with default colors (Yellow on Black)
Build-MarksTemple

# Change the colors
Build-MarksTemple -ForeGroundColour Red -BackGroundColour White

# Use a custom temple file
Build-MarksTemple -TemplePath 'C:\Custom\Temple.txt'

# Available Colors
The module supports all standard PowerShell console colors:

Black
DarkBlue
DarkGreen
DarkCyan
DarkRed
DarkMagenta
DarkYellow
Gray
DarkGray
Blue
Green
Cyan
Red
Magenta
Yellow
White

# Development

Prerequisites
PowerShell 5.1 or later
Pester (for running tests)
Running Tests

```powershell
Invoke-Pester -Path tests
```

# Build and Version
To increment the version:


```powershell
# For patch version (0.0.x)
./build/Update-Version.ps1 -BumpType Patch

# For minor version (0.x.0)
./build/Update-Version.ps1 -BumpType Minor

# For major version (x.0.0)
./build/Update-Version.ps1 -BumpType Major
```

# Contributing
Pull requests are welcome. Please add tests for new features.

Fork the repository
Create your feature branch (git checkout -b feature/amazing-feature)
Commit your changes (git commit -m 'Add some amazing feature')
Push to the branch (git push origin feature/amazing-feature)
Open a Pull Request

# License

MIT
