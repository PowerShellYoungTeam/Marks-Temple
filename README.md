# Marks-Temple

A PowerShell script that builds a Temple in honour of Dark mode in Procmon.

This was promised to Mark Russinovich after hours burning my eyes staring at Procmon logs
[Twitter Thread](https://x.com/PoSHYoungTeam/status/1418667570920570881)

## Features

- Renders ASCII art temple with custom colours
- Easy to use and extend

## Installation

### From PowerShell Gallery (Recommended)
Once published, install directly from PowerShell Gallery:

```powershell
Install-Module -Name Build-MarksTemple
Import-Module Build-MarksTemple
```

### From Source
Clone the repository and import the module:

```powershell
# Clone the repository
git clone https://github.com/PowerShellYoungTeam/Marks-Temple.git
cd Marks-Temple

# Import the module
Import-Module .\src\Build-MarksTemple.psd1
# Or alternatively import the .psm1 directly
Import-Module .\src\Build-MarksTemple.psm1
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

## Publishing to PowerShell Gallery

This module can be published to the PowerShell Gallery for easy installation by users worldwide.

### Getting a PowerShell Gallery API Key

To publish modules to the PowerShell Gallery, you need an API key. Here's how to get one:

1. **Create a PowerShell Gallery Account**
   - Go to [PowerShell Gallery](https://www.powershellgallery.com/)
   - Click "Sign in" and create an account using your Microsoft account

2. **Generate an API Key**
   - Once signed in, click on your username in the top-right corner
   - Select "API Keys" from the dropdown menu
   - Click "Create" to generate a new API key
   - Give your key a descriptive name (e.g., "Marks-Temple Publishing Key")
   - Set the appropriate expiration time (recommended: 1 year or less for security)
   - Choose the scope:
     - **Push new packages and package versions**: For publishing new modules and updates
     - **Push only new package versions**: If the package already exists
     - **Unlist packages**: For removing packages from search results

3. **Secure Your API Key**
   - **Never commit API keys to source control**
   - Store the key securely (password manager, environment variables, or GitHub Secrets)
   - Regenerate keys regularly for security

### Publishing Process

#### Manual Publishing
```powershell
# Test the module manifest first
Test-ModuleManifest .\src\Build-MarksTemple.psd1

# Publish to PowerShell Gallery (replace YOUR_API_KEY with your actual key)
Publish-Module -Path .\src -NuGetApiKey YOUR_API_KEY -Repository PSGallery
```

#### Automated Publishing with GitHub Actions
To set up automated publishing, add your API key as a GitHub Secret:

1. Go to your repository settings
2. Navigate to "Secrets and variables" > "Actions"
3. Click "New repository secret"
4. Name: `PSGALLERY_API_KEY`
5. Value: Your PowerShell Gallery API key

Then create a publishing workflow (`.github/workflows/publish.yml`):

```yaml
name: Publish to PowerShell Gallery
on:
  release:
    types: [published]

jobs:
  publish:
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v4
      - name: Publish to PowerShell Gallery
        run: |
          Test-ModuleManifest .\src\Build-MarksTemple.psd1
          Publish-Module -Path .\src -NuGetApiKey $env:PSGALLERY_API_KEY -Repository PSGallery
        env:
          PSGALLERY_API_KEY: ${{ secrets.PSGALLERY_API_KEY }}
        shell: powershell
```

### Installation After Publishing

Once published, users can install the module with:

```powershell
Install-Module -Name Build-MarksTemple
```

## Contributing

Pull requests are welcome. Please add tests for new features.

## License

MIT
