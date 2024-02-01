# Colors
$psstyle.FileInfo.Directory = "`e[34m"
Set-PSReadLineOption -Colors @{ InlinePrediction = "DarkBlue" }

# Aliases
Remove-Item alias:nv -Force

New-Alias -Name "touch" -Value "New-Item"

New-Alias -Name "which" -Value "Get-Command"

New-Alias -Name "mklink" -Value "New-SymLink"

New-Alias -Name "Remove-SymLink" -Value "Remove-Item"

New-Alias -Name "Init-dev" -Value "Enter-Dev"

# Init Starship prompt
Invoke-Expression (&starship init powershell)

# Custom functions
function New-SymLink ($link, $target)
{
	if (test-path -pathtype container $link)
	{ 
		$directory = "/d" 
	}
	
	Invoke-Expression "cmd /c mklink $directory $link $target"
}

#region neovim

# Run neovim classic
function Invoke-Nvim
{
	param (
		[Parameter()]
		$AppName = "nvim"
	)

	#$env:NVIM_APPNAME = 'nvim'
	Set-Item -Path Env:NVIM_APPNAME -Value $AppName
	& d:\Dev\Applications\nvim\0.10\bin\nvim.exe $args
}

# Run neovim test
function nv
{
	Invoke-Nvim -AppName 'nvim'
}


#endregion Neovim

# Update vcpkg manager
function Update-Vcpkg
{
	Push-Location d:\dev\applications\vcpkg

	& git pull
	& ./bootstrap-vcpkg.bat

	Pop-Location

	& vcpkg upgrade
}

# Backup .config files to Mega

function Backup-Nvim-Nightly
{
	& rclone sync %localappdata%/nvim-nightly Mega:dotfiles/nvim-nightly $args
}

function Backup-Nvim-Test
{
	& rclone sync %localappdata%/nvim-test Mega:dotfiles/nvim-test $args
}

function Backup-Nvim
{
	& rclone sync %localappdata%/nvim Mega:dotfiles/nvim $args
}

function Backup-Powershell
{
	& rclone copyto "$PROFILE" Mega:dotfiles\Powershell\Microsoft.PowerShell_profile.ps1 $args
}

function Backup-Starship
{
	& rclone copyto "$env:USERPROFILE/.config/starship.toml" Mega:dotfiles\starship.toml $args
}

function Backup-Homeoffice
{
	& rclone sync C:\_Projects\KVP\src E:\_Projects_svn\KVP\src --exclude-from="$env:USERPROFILE\kovoprog.rclone.exclude" $args -P
}

function Backup-Sources
{
	& rclone sync %userprofile%/source/repos e:/Projects/sources -P
}

function Backup-Config
{
	Write-Output "Running nvim backup..." | Green
	Backup-Nvim -P -L --human-readable $args

	Write-Output "Running nvim-test backup..." | Green
	Backup-Nvim-Test -P -L --human-readable $args

	Write-Output "Running nvim-nightly backup..." | Green
	Backup-Nvim-Nightly -P -L --human-readable $args

	Write-Output "Running PowerShell profile backup..." | Green
	Backup-Powershell -P -L --human-readable $args

	Write-Output "Running Starship profile backup..." | Green
	Backup-Starship -P -L --human-readable $args
}

# Download scripts from Mega backup

function Update-Nvim-Test
{
	& rclone sync Mega:dotfiles/nvim-test %localappdata%/nvim-test -P
}

function Update-Nvim
{
	& rclone sync Mega:dotfiles/nvim %localappdata%/nvim -P
}

function Update-Nvim-Nightly
{
	& rclone sync Mega:dotfiles/nvim-nightly %localappdata%/nvim-nightly -P
}

function Update-Powershell
{
	& rclone copyto Mega:dotfiles\profile.ps1 "$PROFILE" -P
}

function Update-Starship
{
	& rclone copyto Mega:dotfiles\starship.toml "$env:USERPROFILE/.config/starship.toml" -v
}

# Utils

function Enter-Dev
{
	$installPath = &"C:/Program Files (x86)/Microsoft Visual Studio/Installer/vswhere.exe"  -prerelease -latest -property installationPath
	Import-Module (Join-Path $installPath "Common7/Tools/Microsoft.VisualStudio.DevShell.dll")
	Enter-VsDevShell -VsInstallPath $installPath -SkipAutomaticLocation
}

function Stop-Git
{
	& Stop-Process -Name "git"
}

function Green
{
	process
	{ Write-Host $PSItem -ForegroundColor Green 
	}
}

function Red
{
	process
	{ Write-Host $PSItem -ForegroundColor Red 
	}
}


# Completions

# Import-Module 'D:\Dev\vcpkg\scripts\posh-vcpkg' # Init vcpkg completion
# rclone completion powershell | Out-String | Invoke-Expression # Init rclone completion














