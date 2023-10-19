
Write-Host "Installing symlinks for dotfiles ...`n"

# Install symlink 
function Install-File($name, $path, $dotfiles)
{
	Write-Host "$($name):" -ForegroundColor Blue

	$create_symlink = $true
	if (Test-Path $path)
	{
		if ((Get-item $path).LinkType -eq "SymbolicLink")
		{
			Write-Host "  Symlink present"
			$create_symlink = $false
		} else {
			Write-Host "  Profile exists, renaming to .bak"
			Rename-item -Path $path -NewName "$($path).bak"
		}
	}

	if ($create_symlink) {
		Write-Host "  Creating symlink"
		$item = New-Item -ItemType SymbolicLink -Path $path -Value $dotfiles
	}

	Write-Host "  Done`n" -ForegroundColor Green
}


Install-File "Powershell" $profile "$env:USERPROFILE/Dotfiles/Powershell/Microsoft.PowerShell_profile.ps1"

Install-File "Starship" "$env:USERPROFILE/.config/starship.toml" "$env:USERPROFILE/Dotfiles/Starship/starship.toml"
