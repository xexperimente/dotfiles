# Environment
$env.HOME = $env.USERPROFILE

$env.Path = ($env.Path | append 'c:/Program files/Sublime Text')
$env.Path = ($env.Path | append 'c:/Program Files/Microsoft Visual Studio/18/Professional/VC/Tools/Llvm/x64/bin')
$env.Path = ($env.Path | append 'c:/Program Files/Microsoft Visual Studio/18/Professional/Common7/IDE/CommonExtensions/Microsoft/CMake/Ninja')
$env.Path = ($env.Path | append 'c:/Program Files/Microsoft Visual Studio/18/Professional/Common7/IDE/CommonExtensions/Microsoft/CMake/CMake/bin')
$env.Path = ($env.Path | append 'c:/Program Files (x86)/Windows Kits/10/bin/10.0.26100.0/x64/')
$env.Path = ($env.Path | append 'c:/Program Files/Microsoft Visual Studio/18/Professional/VC/Tools/MSVC/14.51.36231/bin/Hostx64/x64')

$env.EDITOR = 'nvim'
$env.VISUAL = 'neovide'
