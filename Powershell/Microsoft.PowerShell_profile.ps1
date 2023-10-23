# Colors
$psstyle.FileInfo.Directory = "`e[34m"

# Aliases
New-Alias -Name "touch" -Value "New-Item"

New-Alias -Name "which" -Value "Get-Command"

Remove-Item alias:nv -Force

# Completions

# Import-Module 'D:\Dev\vcpkg\scripts\posh-vcpkg' # Init vcpkg completion
# rclone completion powershell | Out-String | Invoke-Expression # Init rclone completion

# Init Starship prompt
Invoke-Expression (&starship init powershell)

# Custom functions
function New-SymLink ($link, $target) {
    if (test-path -pathtype container $target) {
        $command = "cmd /c mklink /d"
    }
    else {
        $command = "cmd /c mklink"
    }

    invoke-expression "$command $link $target"
}

function Remove-SymLink ($link) {
    if (test-path -pathtype container $link) {
        $command = "cmd /c rmdir"
    }
    else {
        $command = "cmd /c del"
    }

    invoke-expression "$command $link"
}

# Run neovim classic
function vim {
    #$env:NVIM_APPNAME = 'nvim'
    Set-Item -Path Env:NVIM_APPNAME -Value nvim
    & vim.cmd $args
}

# Run neovim test
function nv {
    $env:NVIM_APPNAME = 'nvim-test'
    & d:\Dev\Applications\nvim\0.10\bin\nvim.exe $args
}

# Run neovim nightly
function nvn {
    $env:NVIM_APPNAME = 'nvim-nightly'
    & d:\Dev\Applications\nvim\0.10\bin\nvim.exe $args
}

# Update vcpkg manager
function Update-Vcpkg {
    Push-Location d:\dev\applications\vcpkg

    & git pull
    & ./bootstrap-vcpkg.bat

    Pop-Location

    & vcpkg upgrade
}

# Backup .config files to Mega

function Backup-Nvim-Nightly {
    & rclone sync %localappdata%/nvim-nightly Mega:dotfiles/nvim-nightly $args
}

function Backup-Nvim-Test {
    & rclone sync %localappdata%/nvim-test Mega:dotfiles/nvim-test $args
}

function Backup-Nvim {
    & rclone sync %localappdata%/nvim Mega:dotfiles/nvim $args
}

function Backup-Powershell {
    & rclone copyto "$PROFILE" Mega:dotfiles\Powershell\Microsoft.PowerShell_profile.ps1 $args
}

function Backup-Starship {
    & rclone copyto "$env:USERPROFILE/.config/starship.toml" Mega:dotfiles\starship.toml $args
}

function Backup-Homeoffice {
    & rclone sync C:\_Projects\KVP\src E:\_Projects_svn\KVP\src --exclude-from="$env:USERPROFILE\kovoprog.rclone.exclude" $args -P
}

function Backup-Config {
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

function Update-Nvim-Test {
    & rclone sync Mega:dotfiles/nvim-test %localappdata%/nvim-test -P
}

function Update-Nvim {
    & rclone sync Mega:dotfiles/nvim %localappdata%/nvim -P
}

function Update-Nvim-Nightly {
    & rclone sync Mega:dotfiles/nvim-nightly %localappdata%/nvim-nightly -P
}

function Update-Powershell {
    & rclone copyto Mega:dotfiles\profile.ps1 "$PROFILE" -P
}

function Update-Starship {
    & rclone copyto Mega:dotfiles\starship.toml "$env:USERPROFILE/.config/starship.toml" -v
}

# Utils

function Stop-Git {
    & Stop-Process -Name "git"
}

function Green {
    process { Write-Host $PSItem -ForegroundColor Green }
}

function Red {
    process { Write-Host $PSItem -ForegroundColor Red }
}
