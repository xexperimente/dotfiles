# Colors
$psstyle.FileInfo.Directory = "`e[31m"
Set-PSReadLineOption -Colors @{ InlinePrediction = "DarkBlue" }

$env:POWERSHELL_TELEMETRY_OPTOUT = "true"

# Aliases
Remove-Item alias:nv -Force
Remove-Item alias:cd -Force

New-Alias -Force -Name "touch" -Value "New-Item"
New-Alias -Force -Name "which" -Value "Get-Command"
New-Alias -Force -Name "mklink" -Value "New-SymLink"
New-Alias -Force -Name "Remove-SymLink" -Value "Remove-Item"
New-Alias -Force -Name "Init-dev" -Value "Enter-Dev"
New-Alias -Force -Name "subl" -Value "C:/Program files/Sublime Text/sublime_text.exe"
New-Alias -Force -Name "nv" -Value "nvim.exe"
New-Alias -Force -Name "cd" -Value "z"

# Init Starship prompt
starship init powershell | Out-String | Invoke-Expression

# Zoxide init
zoxide init powershell | Out-String | Invoke-Expression

# Custom functions
function New-SymLink ($link, $target)
{
	if (test-path -pathtype container $target)
	{ 
		$directory = "/d" 
	}
	
	Invoke-Expression "cmd /c mklink $directory $link $target"
}

# Update vcpkg manager
function Update-Vcpkg
{
	Push-Location d:\dev\applications\vcpkg

	& git pull
	& ./bootstrap-vcpkg.bat

	Pop-Location

	& vcpkg upgrade
}

function Backup-Homeoffice
{
	& rclone sync C:\_Projects\KVP\src E:\_Projects_svn\KVP\src --exclude-from="$env:USERPROFILE\kovoprog.rclone.exclude" $args --stats-one-line -v
	& rclone sync C:\_Projects\KVP\data E:\_Projects_svn\KVP\data $args --stats-one-line -v
}

function Backup-Sources
{
	& rclone sync %userprofile%/Sources e:/Projects/sources -P -v
}

# Utils

function Enter-Dev
{
	$path = &"C:/Program Files (x86)/Microsoft Visual Studio/Installer/vswhere.exe"  -prerelease -latest -property installationPath
	$id = &"C:/Program Files (x86)/Microsoft Visual Studio/Installer/vswhere.exe"  -prerelease -latest -property instanceid
	$dev = Join-Path $path "Common7/Tools/Microsoft.VisualStudio.DevShell.dll"

	&pwsh.exe -NoExit -Command "&{Import-Module ""$dev""; Enter-VsDevShell $id -SkipAutomaticLocation -DevCmdArguments ""-arch=x64 -host_arch=x64""}"
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

function grep
{
	$input | out-string -stream | select-string $args 
}

# Completions

function Register-LazyCompleter($CommandName, $CompletionScript)
{
	$Context = $script:Context
	$NativeProp = $script:NativeProp

	Register-ArgumentCompleter -CommandName $CommandName -ScriptBlock {
		try
		{
			. $CompletionScript
		} catch
		{
			throw "Failed to run the autocompleter for '$CommandName'"
		}
		$Completer = $NativeProp.GetValue($Context)[$CommandName]
		return & $Completer @Args
	}.GetNewClosure()
}

# Init Rclone completion
Register-LazyCompleter rclone {
	rclone completion powershell | Out-String | Invoke-Expression
}

# rust completer
Register-LazyCompleter rustup {
	rustup completions powershell rustup | Out-String | Invoke-Expression
}

Register-LazyCompleter winget {
	Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
		param($wordToComplete, $commandAst, $cursorPosition)

		[Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
		$Local:word = $wordToComplete.Replace('"', '""')
		$Local:ast = $commandAst.ToString().Replace('"', '""')

		winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
			[System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
		}
	}
}

Import-Module 'D:\Dev\Applications\vcpkg\scripts\posh-vcpkg' # Init vcpkg completion

