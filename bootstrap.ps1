<#
.SYNOPSIS
    Install dotfiles
.DESCRIPTION
    Install symlinks to files inside this folder to expected locations
.PARAMETER OverwriteFiles
    Overwrite existing symlinks or files
#>
Param (
	[Parameter(HelpMessage="Overwrite existing symlinks")]
	[Switch]$OverwriteFiles = $False
)

Write-Host "Installing symlinks for dotfiles ...`n"

# Install symlink 
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
		[Switch]$NoBackup
	)

	Write-Host "$($Name):" -ForegroundColor Blue

	$create_symlink = $true
	if (Test-Path $Target)
	{
		if ((Get-item $Target).LinkType -eq "SymbolicLink")
		{
			Write-Host "  Symlink present"
			# $create_symlink = $false
		} elseif (-not $NoBackup)
		{
			Write-Host "  Profile exists, renaming to .bak"
			Rename-item -Path $Target -NewName "$($Target).bak"
		}

	}

	if ($create_symlink)
	{
		$err = @{}

		Write-Host "  Creating symlink"
		New-Item -ItemType SymbolicLink -Path $Target -Value $Source -Force:$NoBackup -EA SilentlyContinue -EV err | Out-Null

		if ($err)
		{
			Write-Host "  Error: $($err) " -ForegroundColor Red
		}

	}

	Write-Host "  Done`n" -ForegroundColor Green
}


Install-File -Name "Powershell" -Target $profile -Source "$env:USERPROFILE/Dotfiles/Powershell/Microsoft.PowerShell_profile.ps1" -NoBackup:$OverwriteFiles

Install-File -Name "Starship" -Target "$env:USERPROFILE/.config/starship.toml" -Source "$env:USERPROFILE/Dotfiles/Starship/starship.toml" -NoBackup:$OverwriteFiles

























