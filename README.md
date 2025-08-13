# Marks-Temple

A PowerShell script that builds a Temple in honour of Dark mode in Procmon.

This was promised to Mark Russinovich after hours burning my eyes staring at Procmon logs
[Twitter Thread]](https://x.com/PoSHYoungTeam/status/1418667570920570881)

## Features

- Renders ASCII art temple with custom colours
- Easy to use and extend

## Installation

Clone the repository and import the script:

```powershell
. .\src\Build-MarksTemple.ps1
```

## Usage

```powershell
Build-MarksTemple
Build-MarksTemple -ForeGroundColour 'Red' -BackGroundColour 'White'
Build-MarksTemple -TemplePath 'C:\Custom\Temple.txt'
```

## Testing

Run Pester tests:

```powershell
Invoke-Pester -Path tests
```

## CI/CD

![CI](https://github.com/PowerShellYoungTeam/Marks-Temple/actions/workflows/ci.yml/badge.svg)

## Contributing

Pull requests are welcome. Please add tests for new features.

## License

MIT
