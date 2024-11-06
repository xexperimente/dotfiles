# Colors
$psstyle.FileInfo.Directory = "`e[34m"
Set-PSReadLineOption -Colors @{ InlinePrediction = "DarkBlue" }

# Aliases
Remove-Item alias:nv -Force
Remove-Item alias:cd -Force

New-Alias -Name "touch" -Value "New-Item"

New-Alias -Name "which" -Value "Get-Command"

New-Alias -Name "mklink" -Value "New-SymLink"

New-Alias -Name "Remove-SymLink" -Value "Remove-Item"

New-Alias -Name "Init-dev" -Value "Enter-Dev"

New-Alias -Name "cd" -Value "z"

# Init Starship prompt

#function Invoke-Starship-TransientFunction
#{
#	&starship module character
#}
#
#Invoke-Expression (&starship init powershell)
#
#Enable-TransientPrompt

# Oh my posh
$env:Path += ";C:\Users\user\AppData\Local\Programs\oh-my-posh\bin"

oh-my-posh init pwsh --config "~\Dotfiles\oh-my-posh\zen.toml" | Invoke-Expression

# Custom functions
function New-SymLink ($link, $target)
{
	if (test-path -pathtype container $target)
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
	& nvim.exe $args
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

# Misc Backups
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
	& rclone sync C:\_Projects\KVP\data E:\_Projects_svn\KVP\data $args -P
}

function Backup-Sources
{
	& rclone sync %userprofile%/Sources e:/Projects/sources -P -v
}

function Backup-Config
{
	Write-Output "Running PowerShell profile backup..." | Green
	Backup-Powershell -P -L --human-readable $args

	Write-Output "Running Starship profile backup..." | Green
	Backup-Starship -P -L --human-readable $args
}

# Download scripts from Mega backup

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
	$path = &"C:/Program Files (x86)/Microsoft Visual Studio/Installer/vswhere.exe"  -prerelease -latest -property installationPath
	$id = &"C:/Program Files (x86)/Microsoft Visual Studio/Installer/vswhere.exe"  -prerelease -latest -property instanceid
	$dev = Join-Path $path "Common7/Tools/Microsoft.VisualStudio.DevShell.dll"

	&pwsh.exe -NoExit -Command "&{Import-Module ""$dev""; Enter-VsDevShell $id -SkipAutomaticLocation -DevCmdArguments ""-arch=x64 -host_arch=x64""}"

	# &pwsh.exe -NoExit -Command "&{Import-Module ""C:\Program Files\Microsoft Visual Studio\2022\Preview\Common7\Tools\Microsoft.VisualStudio.DevShell.dll""; Enter-VsDevShell 368fdbdb -SkipAutomaticLocation -DevCmdArguments ""-arch=x64 -host_arch=x64""}"
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

# Zoxide init
Invoke-Expression (& { (zoxide init powershell | Out-String) })










