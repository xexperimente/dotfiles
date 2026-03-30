
# Transfer files needed for homeoffice
def backup [] {
	print $"\n(ansi reset)Syncing (ansi blue)c:/_projects/kvp/src(ansi reset) with exclude list\n(ansi grey58)"

	rclone sync C:\_Projects\KVP\src E:\_Projects_svn\KVP\src --exclude-from=$"($env.USERPROFILE)/kovoprog.rclone.exclude" --stats-one-line -v
	
	print $"\n(ansi reset)Syncing (ansi blue)c:/_projects/kvp/data\n(ansi grey58)"
	rclone sync C:\_Projects\KVP\data E:\_Projects_svn\KVP\data --stats-one-line -v
	
	print $"\n(ansi reset)Syncing (ansi blue)$HOME/Sources\n(ansi grey58)"
	rclone sync $"($env.USERPROFILE)/Sources" e:/Projects/sources --stats-one-line -v --delete-excluded --exclude="*/.zig-cache/**" --skip-links
	
    print $"\n(ansi reset)Syncing (ansi blue)D:/Dev/libs\n(ansi grey58)"
	rclone sync D:/Dev/Libs E:/Dev/Libs --stats-one-line -v
}

# Start nvim in Notes directory
def notes [] {
  nvim -c $"cd ($env.USERPROFILE)/Documents/Notes" $"($env.USERPROFILE)/Documents/Notes" 
}

# Sync notes folder to Mega
def sync_notes [] {
  print --no-newline $"\n(ansi reset)Syncing (ansi blue)$HOME/Documents/Notes(ansi grey58) ..."

  rclone sync $"($env.USERPROFILE)/Documents/Notes/" Mega:Documents/Notes

  print "Done\n"
}

# Kill all running git processes
def kill_git [] {
  ps | grep git | each {|x| kill --force $x.pid }
}

