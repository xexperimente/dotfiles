vim.pack.add({ "https://github.com/folke/snacks.nvim" })

require("snacks").setup({
	explorer = {
		replace_netrw = true,
	},
	notifier = {
		enabled = true,
		style = "compact",
	},
	statuscolumn = {
		left = { "mark", "sign" },
		right = { "fold", "git" },
		folds = {
			open = true, -- show open fold icons
			git_hl = true, -- use Git Signs hl for fold icons
		},
		git = {
			-- patterns to match Git signs
			patterns = { "GitSign", "MiniDiffSign" },
		},
		refresh = 50, -- refresh at most every 50ms
	},
	terminal = {
		win = {
			position = "float",
			border = "single",
			keys = {
				term_hide = {
					"<c-t>",
					function(self)
						self:hide()
					end,
					mode = "t",
					expr = true,
				},
			},
			wo = {
				winbar = "",
				statusline = "",
			},
		},
		interactive = true,
	},
	picker = {
		sources = {
			explorer = {
				tree = true,
				auto_close = true,
				layout = { preset = "vertical", preview = false },
			},
		},
	},
})

vim.keymap.set("n", "<leader>ff", "<cmd>lua Snacks.picker.files()<cr>", {})
vim.keymap.set("n", "<leader>fe", "<cmd>lua Snacks.explorer()<cr>", {})
vim.keymap.set("n", "<leader>bd", "<cmd>lua Snacks.bufdelete()<cr>", {})
vim.keymap.set("n", "<leader>fc", "<cmd>lua Snacks.picker.highlights()<cr>", {})
vim.keymap.set("n", "<leader>fh", "<cmd>lua Snacks.picker.help()<cr>", {})

vim.keymap.set("n", "<leader>lp", "<cmd>lua Snacks.picker.diagnostics_buffer()<cr>", {})
vim.keymap.set("n", "<leader>lP", "<cmd>lua Snacks.picker.diagnostics()<cr>", {})

-- Terminal
vim.keymap.set("n", "<leader>t", "<cmd>lua Snacks.terminal.toggle()<cr>", {})
vim.keymap.set("n", "<c-t>", "<cmd>lua Snacks.terminal.toggle()<cr>", {})
