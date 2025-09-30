
# Transfer files needed for homeoffice

# Backup work data to external drive
def backup [] {
	print $"\n(ansi reset)Syncing (ansi blue)c:/_projects/kvp/src(ansi reset) with exclude list\n(ansi grey58)"

	rclone sync C:\_Projects\KVP\src E:\_Projects_svn\KVP\src --exclude-from=$"($env.USERPROFILE)/kovoprog.rclone.exclude" --stats-one-line -v
	
	print $"\n(ansi reset)Syncing (ansi blue)c:/_projects/kvp/data\n(ansi grey58)"
	rclone sync C:\_Projects\KVP\data E:\_Projects_svn\KVP\data --stats-one-line -v
	
	print $"\n(ansi reset)Syncing (ansi blue)$HOME/Sources\n(ansi grey58)"
	rclone sync $"($env.USERPROFILE)/Sources" e:/Projects/sources --stats-one-line -v
}

# Set neovim to use nightly config
def --env use_nvim_nightly [] {
	$env.NVIM_APPNAME = 'nvim-nightly'
	$env.NVIM_PATH = 'c:\Program Files\Neovim.Nightly\bin'
}

# Set neovim to use stable config
def --env use_nvim_stable [] {
	$env.NVIM_APPNAME = 'nvim'
	$env.NVIM_PATH = 'c:\Program Files\Neovim\bin'
}

# Launch neovim with set config
def nv --wrapped [...rest] {
	let cmd = $'($env.NVIM_PATH)\nvim.exe'
	^$cmd ...$rest
}
