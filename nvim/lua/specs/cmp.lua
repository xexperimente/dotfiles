-- Autocompletion

local Plugin = { 'hrsh7th/nvim-cmp' }
local user = { autocomplete = true }

Plugin.dependencies = {
	-- Sources
	-- { 'hrsh7th/cmp-buffer' },
	{ 'hrsh7th/cmp-path', lazy = true },
	{ 'saadparwaiz1/cmp_luasnip', lazy = true },
	{ 'hrsh7th/cmp-nvim-lsp', lazy = true },
	{ 'hrsh7th/cmp-nvim-lua', lazy = true },
	{ 'hrsh7th/cmp-cmdline', lazy = true },
	{ 'dmitmel/cmp-cmdline-history', lazy = true },

	-- Snippets
	{ 'L3MON4D3/LuaSnip', lazy = true },

	-- Icons
	{ 'onsails/lspkind.nvim', lazy = true },

	-- fzf paths
	-- {
	-- 	'tzachar/cmp-fuzzy-path',
	-- 	lazy = true,
	-- 	dependencies = {
	-- 		{ 'tzachar/fuzzy.nvim', lazy = true },
	-- 		--{ 'natecraddock/telescope-zf-native.nvim', lazy = true },
	-- 		{ 'romgrk/fzy-lua-native', lazy = true },
	-- 	},
	-- },
}

Plugin.event = { 'InsertEnter', 'VeryLazy' }

function Plugin.config()
	vim.api.nvim_create_user_command('UserCmpEnable', user.enable_cmd, {})

	local cmp = require('cmp')
	local luasnip = require('luasnip')
	local lspkind = require('lspkind')

	local cmp_enable = cmp.get_config().enabled
	local select_opts = { behavior = cmp.SelectBehavior.Select }

	user.config = {
		enabled = function()
			if user.autocomplete then return cmp_enable() end

			return false
		end,
		completion = {
			completeopt = 'menu,menuone',
		},
		snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
		sources = {
			{ name = 'nvim_lsp', keyword_length = 3 },
			-- { name = 'buffer', keyword_length = 3 },
			{ name = 'luasnip', keyword_length = 2 },
			{ name = 'lazydev' },
			{ name = 'path' },
		},
		view = {
			docs = {
				auto_open = false,
			},
		},
		window = {
			documentation = {
				border = require('user.env').cmp_border,
				max_height = 15,
				max_width = 50,
				zindex = 50,
			},
			completion = {
				border = require('user.env').cmp_border,
			},
		},
		formatting = {
			format = lspkind.cmp_format({
				mode = 'symbol',
				maxwidth = 50,
				ellipsis_char = '...',
				-- symbol_map = { Text = '' },
				symbol_map = { Snippet = '' },
				preset = vim.g.nvy == 1 and 'codicons' or 'default',
			}),
		},
		mapping = {
			['<C-k>'] = cmp.mapping.scroll_docs(-5),
			['<C-j>'] = cmp.mapping.scroll_docs(5),
			['<C-g>'] = cmp.mapping(function(fallback)
				if cmp.visible_docs() then
					cmp.close_docs()
				elseif cmp.visible() then
					cmp.open_docs()
				else
					fallback()
				end
			end),

			['<Up>'] = cmp.mapping.select_prev_item(select_opts),
			['<Down>'] = cmp.mapping.select_next_item(select_opts),
			['<M-k>'] = cmp.mapping.select_prev_item(select_opts),
			['<M-j>'] = cmp.mapping.select_next_item(select_opts),
			['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
			['<C-n>'] = cmp.mapping.select_next_item(select_opts),

			['<C-a>'] = cmp.mapping(function(fallback)
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { 'i', 's' }),

			['<C-d>'] = cmp.mapping(function(fallback)
				if luasnip.jumpable(1) then
					luasnip.jump(1)
				else
					fallback()
				end
			end, { 'i', 's' }),

			['<M-u>'] = cmp.mapping(function()
				if cmp.visible() then
					user.set_autocomplete(false)
					cmp.abort()
				else
					user.set_autocomplete(true)
					cmp.complete()
				end
			end),

			['<Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.confirm({ select = true })
				elseif luasnip.jumpable(1) then
					luasnip.jump(1)
				elseif user.check_back_space() then
					fallback()
				else
					user.set_autocomplete(true)
					cmp.complete()
				end
			end, { 'i', 's' }),

			['<S-Tab>'] = cmp.mapping(function()
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					user.insert_tab()
				end
			end, { 'i', 's' }),
		},
	}

	cmp.setup(user.config)

	cmp.setup.cmdline(':', {
		sources = cmp.config.sources({
			{ name = 'cmdline', option = { ignore_cmds = { 'Man', '!' } } },
			{ name = 'path', option = { get_cwd = function() return vim.env.PWD end } },
			-- { name = 'cmdline_history' },
		}),
		mapping = cmp.mapping.preset.cmdline({
			['<Down>'] = {
				c = function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end,
			},
			['<Up>'] = {
				c = function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end,
			},
			['<Tab>'] = {
				c = function()
					if cmp.visible() then
						cmp.confirm({ select = false })
					else
						cmp.complete()
					end
				end,
			},
		}),
	})
end

function user.set_autocomplete(new_value)
	local augroup = vim.api.nvim_create_augroup('UserCmpCmds', { clear = true })
	local autocmd = vim.api.nvim_create_autocmd
	local old_value = user.autocomplete

	if new_value == old_value then return end

	if new_value == false then
		-- restore autocomplete in the next word
		vim.api.nvim_buf_set_keymap(
			0,
			'i',
			'<space>',
			'<cmd>UserCmpEnable<cr><space>',
			{ noremap = true }
		)

		-- restore when leaving insert mode
		autocmd('InsertLeave', {
			group = augroup,
			command = 'UserCmpEnable',
			once = true,
		})
	end

	user.autocomplete = new_value
end

function user.check_back_space()
	local col = vim.fn.col('.') - 1
	if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
		return true
	else
		return false
	end
end

function user.enable_cmd()
	if user.autocomplete then return end

	pcall(vim.api.nvim_buf_del_keymap, 0, 'i', '<Space>')
	user.set_autocomplete(true)
end

function user.insert_tab()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, true, true), 'n', true)
end

return Plugin
