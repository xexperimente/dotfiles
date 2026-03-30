# config.nu
#
# Installed by:
# version = "0.103.0"
#
# This file is loaded after env.nu and before login.nu

source aliases.nu
source env.nu
source functions.nu

# Nu configuration
$env.config = {
	buffer_editor: "nvim"
	show_banner: false

	# VIM mode settings
	edit_mode: "vi"
	cursor_shape : {
		vi_insert: "line"
	    vi_normal: "block"
	}
	
	# Colors
	color_config: {
		separator: { fg: "#f2e9e1"}
		hints: { fg: "#dfdad9"}
	}
}


# Prompt
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = ""
source starship.nu

# Load zoxide module
source zoxide.nu
