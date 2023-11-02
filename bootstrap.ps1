<#
.SYNOPSIS
    Install dotfiles
.DESCRIPTION
    Install symlinks to files inside this folder to expected locations
.PARAMETER Force
    Overwrite existing symlinks or files. Default is False.
.PARAMETER Backup
    Rename existing file to .BAK. Only for files, not folders. Default is False.
.EXAMPLE
    .\bootstrap.ps1 -Force -Backup
#>
Param (
	[Parameter(HelpMessage="Overwrite existing symlinks")]
	[Switch]$Force = $False,
	
	[Parameter(HelpMessage="Rename existing files to .BAK")]
	[Switch]$Backup = $False
)

Write-Host "Installing symlinks for dotfiles ...`n"

# Create symlink for single configuration file
function Install-File
{
	param (
		[Parameter(Mandatory)]
		[string]$Name,

		[Parameter(Mandatory)]
		[string]$Target,
		
		[Parameter(Mandatory)]
		[string]$Source,

		[Parameter()]
		[Switch]$Backup = $False,

		[Parameter()]
		[Switch]$Force = $False
	)

	Write-Host "$($Name):" -ForegroundColor Blue

	$symlinkPresent = $false;
	if (Test-Path $Target)
	{
		if ((Get-item $Target).LinkType -eq "SymbolicLink")
		{
			Write-Host "  Symlink present"
			$symlinkPresent = $true
		} elseif ($Backup)
		{
			Write-Host "  Profile exists, renaming to .bak"
			Rename-item -Path $Target -NewName "$($Target).bak"
		}

	}

	if ((-not $symlinkPresent) -or $Force)
	{
		$err = @{}

		Write-Host "  Creating symlink"
		New-Item -ItemType SymbolicLink -Path $Target -Value $Source -Force:$Force -EA SilentlyContinue -EV err | Out-Null

		if ($err)
		{
			Write-Host "  Error: $($err) " -ForegroundColor Red 
		}
	}

	Write-Host "  Done`n" -ForegroundColor Green
}

# Install folder
function Install-Folder
{
	param (
		[Parameter(Mandatory)]
		[string]$Name,

		[Parameter(Mandatory)]
		[string]$Target,
		
		[Parameter(Mandatory)]
		[string]$Source,

		[Parameter()]
		[Switch]$Force = $False
	)

	Write-Host "$($Name):" -ForegroundColor Blue

	$symlinkPresent = $false;
	if (Test-Path $Target)
	{
		if ((Get-item $Target).LinkType -eq "SymbolicLink")
		{
			Write-Host "  Symlink present"
			$symlinkPresent = $true
		} elseif ($Force)
		{
			Write-Host "  Target present and -Force, removing"
			Remove-Item $Target -Recurse -Confirm
		}
	}

	if ((-not $symlinkPresent) -or $Force)
	{
		$err = @{}

		Write-Host "  Creating symlink"
		New-Item -ItemType SymbolicLink -Path $Target -Value $Source -Force:$Force -EA SilentlyContinue -EV err | Out-Null

		if ($err)
		{
			Write-Host "  Error: $($err) " -ForegroundColor Red 
		}

	}

	Write-Host "  Done`n" -ForegroundColor Green
}

# Install each dotfiles

Install-File -Name "Powershell" -Target $profile -Source "$env:USERPROFILE/Dotfiles/Powershell/Microsoft.PowerShell_profile.ps1" -Backup:$Backup -Force:$Force

Install-File -Name "Starship" -Target "$env:USERPROFILE/.config/starship.toml" -Source "$env:USERPROFILE/Dotfiles/Starship/starship.toml" -Backup:$Backup -Force:$Force

Install-Folder -Name "wezterm" -Target "$env:USERPROFILE/.config/wezterm" -Source "$env:USERPROFILE/Dotfiles/wezterm" -Force:$Force
















