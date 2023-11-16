local Plugin = { 'hrsh7th/nvim-cmp' }
local utils = {}

Plugin.dependencies = {
	-- Sources
	{ 'hrsh7th/cmp-buffer' },
	{ 'hrsh7th/cmp-path' },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/cmp-nvim-lua' },
	{ 'dcampos/cmp-snippy' },

	-- Snippets
	{ 'dcampos/nvim-snippy' },
}

Plugin.event = 'InsertEnter'

function Plugin.config()
	local cmp = require('cmp')
	local select_opts = { behavior = cmp.SelectBehavior.Select }

	local kind_icons = {
		Text = '',
		Method = '',
		Function = '',
		Constructor = '',
		Snippet = '',
		Folder = 'ﱮ',
		File = '',
		Enum = '練',
		Field = '',
	}

	local sources = {
		buffer = '[buf]',
		nvim_lsp = '[lsp]',
		luasnip = '[sni]',
		nvim_lua = '[lua]',
	}

	local opts = {
		enabled = function()
			local buftype = vim.api.nvim_get_option_value('buftype', { buf = 0 })

			if buftype == 'prompt' then return false end
			return true
		end,
		snippet = {
			expand = function(args) require('snippy').expand_snippet(args.body) end,
		},
		preselect = cmp.PreselectMode.Item,
		completion = {
			completeopt = 'menu,menuone,noinsert',
		},
		sources = {
			{ name = 'path' },
			{ name = 'nvim_lsp', keyword_length = 3 },
			{ name = 'buffer', keyword_length = 3 },
			{ name = 'snippy' },
		},
		view = {
			docs = {
				auto_open = false,
			},
		},
		window = {
			documentation = {
				border = 'single',
				max_height = 16,
				max_width = 50,
				zindex = 50,
				title = 'Docs:',
			},
		},
		formatting = {
			fields = { 'kind', 'abbr', 'menu' },
			format = function(entry, vim_item)
				local show_source = (entry.source.name == 'nvim_lsp') or (entry.source.name == 'buffer')

				vim_item.menu = utils.lpad('  (' .. vim_item.kind .. ') ', 15)
					.. (show_source and sources[entry.source.name] or '')

				vim_item.kind = kind_icons[vim_item.kind] or ' ' --[[vim_item.kind]]

				return vim_item
			end,
		},
		mapping = {
			['<Up>'] = cmp.mapping.select_prev_item(select_opts),
			['<Down>'] = cmp.mapping.select_next_item(select_opts),
			['<CR>'] = cmp.mapping.confirm(),
			-- ["<tab>"] = cmp.mapping.confirm(),
			['<tab>'] = cmp.mapping.select_next_item(select_opts),
			['<s-tab>'] = cmp.mapping.select_prev_item(select_opts),
			['<C-k>'] = cmp.mapping.scroll_docs(-5),
			['<C-j>'] = cmp.mapping.scroll_docs(5),
			['<C-e>'] = cmp.mapping.abort(),
			['<C-g>'] = cmp.mapping(function(fallback)
				if cmp.visible_docs() then
					cmp.close_docs()
				elseif cmp.visible() then
					cmp.open_docs()
				else
					fallback()
				end
			end),
		},
	}

	cmp.setup(opts)
end

function utils.lpad(str, len, char)
	if char == nil then char = ' ' end
	return str .. string.rep(char, len - #str)
end

return Plugin

-- local cmp_enable = cmp.get_config().enabled
-- local icon = {
-- 	nvim_lsp = 'λ',
-- 	luasnip = '⋗',
-- 	buffer = 'Ω',
-- 	path = '🖫',
-- 	nvim_lua = 'Π',
-- 	omni = 'Π',
-- 	tags = 't',
-- }

-- "method": "  ",
-- "function": "  ",
-- "variable": "[]",
-- "field": "  ",
-- "typeParameter": "<>",
-- "constant": "  ",
-- "class": " פּ ",
-- "interface": " 蘒",
-- "struct": "  ",
-- "event": "  ",
-- "operator": "  ",
-- "module": "  ",
-- "property": "  ",
-- "enum": " 練",
-- "reference": "  ",
-- "keyword": "  ",
-- "file": "  ",
-- "folder": " ﱮ ",
-- "color": "  ",
-- "unit": " 塞 ",
-- "snippet": "  ",
-- "text": "  ",
-- "constructor": "  ",
-- "value": "  ",
-- "enumMember": "  "

-- mapping = {
-- 	['<C-k>'] = cmp.mapping.scroll_docs(-5),
-- 	['<C-j>'] = cmp.mapping.scroll_docs(5),
-- 	['<C-g>'] = cmp.mapping(function(fallback)
-- 		if cmp.visible_docs() then
-- 			cmp.close_docs()
-- 		elseif cmp.visible() then
-- 			cmp.open_docs()
-- 		else
-- 			fallback()
-- 		end
-- 	end),
--
-- ['<C-a>'] = cmp.mapping(function(fallback)
-- 	if luasnip.jumpable(-1) then
-- 		luasnip.jump(-1)
-- 	else
-- 		fallback()
-- 	end
-- end, { 'i', 's' }),
--
-- ['<C-d>'] = cmp.mapping(function(fallback)
-- 	if luasnip.jumpable(1) then
-- 		luasnip.jump(1)
-- 	else
-- 		fallback()
-- 	end
-- end, { 'i', 's' }),

-- ['<M-u>'] = cmp.mapping(function()
-- 	if cmp.visible() then
-- 		user.set_autocomplete(false)
-- 		cmp.abort()
-- 	else
-- 		user.set_autocomplete(true)
-- 		cmp.complete()
-- 	end
-- end),

-- ['<Tab>'] = cmp.mapping(function(fallback)
-- 	if cmp.visible() then
-- 		cmp.confirm({ select = true })
-- 	elseif luasnip.jumpable(1) then
-- 		luasnip.jump(1)
-- 		-- elseif user.check_back_space() then
-- 		-- 	fallback()
-- 	else
-- 		-- 	user.set_autocomplete(true)
-- 		cmp.complete()
-- 	end
-- end, { 'i', 's' }),
--
-- ['<S-Tab>'] = cmp.mapping(function()
-- 	if luasnip.jumpable(-1) then
-- 		luasnip.jump(-1)
-- 		-- else
-- 		-- 	user.insert_tab()
-- 	end
-- end, { 'i', 's' }),
-- },
