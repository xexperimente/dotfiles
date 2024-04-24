-- Autocompletion
local Plugin = { 'hrsh7th/nvim-cmp' }
local user = { autocomplete = true }

Plugin.dependencies = {
	-- Sources
	{ 'hrsh7th/cmp-buffer' },
	{ 'hrsh7th/cmp-path' },
	{ 'saadparwaiz1/cmp_luasnip' },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/cmp-nvim-lua' },
	{ 'hrsh7th/cmp-omni' },
	-- { 'quangnguyen30192/cmp-nvim-tags' },

	-- Snippets
	{ 'L3MON4D3/LuaSnip' },
}

Plugin.event = 'InsertEnter'

function Plugin.config()
	user.augroup = vim.api.nvim_create_augroup('compe_cmds', { clear = true })
	vim.api.nvim_create_user_command('UserCmpEnable', user.enable_cmd, {})

	local cmp = require('cmp')
	local luasnip = require('luasnip')

	local select_opts = { behavior = cmp.SelectBehavior.Select }
	local cmp_enable = cmp.get_config().enabled

	local icon = {
		nvim_lsp = '',
		luasnip = '',
		buffer = '',
		path = 'ﱮ',
		nvim_lua = ' ',
		omni = ' ',
		tags = 't',
	}

	user.config = {
		enabled = function()
			if user.autocomplete then return cmp_enable() end

			return false
		end,
		completion = {
			completeopt = 'menu,menuone',
		},
		snippet = {
			expand = function(args) luasnip.lsp_expand(args.body) end,
		},
		sources = {
			{ name = 'path' },
			{ name = 'nvim_lsp', keyword_length = 3 },
			{ name = 'buffer', keyword_length = 3 },
			{ name = 'luasnip', keyword_length = 2 },
		},
		view = {
			docs = {
				auto_open = false,
			},
		},
		window = {
			documentation = {
				border = 'single',
				max_height = 15,
				max_width = 50,
				zindex = 50,
			},
		},
		formatting = {
			fields = { 'menu', 'abbr', 'kind' },
			format = function(entry, item)
				item.menu = icon[entry.source.name]
				return item
			end,
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
end

function user.set_autocomplete(new_value)
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
		vim.api.nvim_create_autocmd('InsertLeave', {
			group = user.augroup,
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

-- 	{ 'dcampos/cmp-snippy' },
-- 	{ 'dcampos/nvim-snippy' },

-- function Plugin.config()
-- 	local cmp = require('cmp')
-- 	local select_opts = { behavior = cmp.SelectBehavior.Select }
--
-- 	local kind_icons = {
-- 		Text = '',
-- 		Method = '',
-- 		Function = '',
-- 		Constructor = '',
-- 		Snippet = '',
-- 		Folder = 'ﱮ',
-- 		File = '',
-- 		Enum = '練',
-- 		Field = '',
-- 	}
--
-- 	local sources = {
-- 		buffer = '[buf]',
-- 		nvim_lsp = '[lsp]',
-- 		luasnip = '[sni]',
-- 		nvim_lua = '[lua]',
-- 	}
--
-- 	local opts = {
-- 		enabled = function()
-- 			local buftype = vim.api.nvim_get_option_value('buftype', { buf = 0 })
--
-- 			if buftype == 'prompt' then return false end
-- 			return true
-- 		end,
-- 		formatting = {
-- 			fields = { 'kind', 'abbr', 'menu' },
-- 			format = function(entry, vim_item)
-- 				local show_source = (entry.source.name == 'nvim_lsp') or (entry.source.name == 'buffer')
--
-- 				vim_item.menu = utils.lpad('  (' .. vim_item.kind .. ') ', 15)
-- 					.. (show_source and sources[entry.source.name] or '')
--
-- 				vim_item.kind = kind_icons[vim_item.kind] or ' ' --[[vim_item.kind]]
--
-- 				return vim_item
-- 			end,
-- 		},
-- 		mapping = {
-- 			['<Up>'] = cmp.mapping.select_prev_item(select_opts),
-- 			['<Down>'] = cmp.mapping.select_next_item(select_opts),
-- 			['<CR>'] = cmp.mapping.confirm(),
-- 			-- ["<tab>"] = cmp.mapping.confirm(),
-- 			['<tab>'] = cmp.mapping.select_next_item(select_opts),
-- 			['<s-tab>'] = cmp.mapping.select_prev_item(select_opts),
-- 			['<C-k>'] = cmp.mapping.scroll_docs(-5),
-- 			['<C-j>'] = cmp.mapping.scroll_docs(5),
-- 			['<C-e>'] = cmp.mapping.abort(),
-- 			['<C-g>'] = cmp.mapping(function(fallback)
-- 				if cmp.visible_docs() then
-- 					cmp.close_docs()
-- 				elseif cmp.visible() then
-- 					cmp.open_docs()
-- 				else
-- 					fallback()
-- 				end
-- 			end),
-- 		},
-- 	}
--
-- 	cmp.setup(opts)
-- end
--
-- function utils.lpad(str, len, char)
-- 	if char == nil then char = ' ' end
-- 	return str .. string.rep(char, len - #str)
-- end
--
-- return Plugin
