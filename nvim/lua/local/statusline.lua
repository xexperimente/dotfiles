local icons = {
	--- Diagnostic severities.
	diagnostics = {
		ERROR = '',
		WARN = '',
		HINT = '',
		INFO = '',
	},

	--- For folding.
	arrows = {
		right = '',
		left = '',
		up = '',
		down = '',
	},

	--- LSP symbol kinds.
	symbol_kinds = {
		Array = '󰅪',
		Class = '',
		Color = '󰏘',
		Constant = '󰏿',
		Constructor = '',
		Enum = '',
		EnumMember = '',
		Event = '',
		Field = '󰜢',
		File = '󰈙',
		Folder = '󰉋',
		Function = '󰆧',
		Interface = '',
		Keyword = '󰌋',
		Method = '󰆧',
		Module = '',
		Operator = '󰆕',
		Property = '󰜢',
		Reference = '󰈇',
		Snippet = '',
		Struct = '',
		Text = '',
		TypeParameter = '',
		Unit = '',
		Value = '',
		Variable = '󰀫',
	},

	--- Shared icons that don't really fit into a category.
	misc = {
		bug = '',
		git = '',
		search = '',
		vertical_bar = '│',
	},
}
local colors = {}

function colors.text()
	local ok, palette = pcall(require, 'rose-pine.palette')
	local fg = ok and palette.text or '#555555'

	return fg
end

function colors.base()
	local ok, palette = pcall(require, 'rose-pine.palette')
	local fg = ok and palette.base or '#f4faed'

	return fg
end

vim.api.nvim_set_hl(0, 'StatuslineModeNormal', { fg = colors.base(), bg = '#5fb0fc' })
vim.api.nvim_set_hl(0, 'StatuslineModeInsert', { fg = colors.base(), bg = '#98bb6c' })
vim.api.nvim_set_hl(0, 'StatuslineModeReplace', { fg = colors.base(), bg = '#e46846' })
vim.api.nvim_set_hl(0, 'StatuslineModeVisual', { fg = colors.base(), bg = '#ffa066' })
vim.api.nvim_set_hl(0, 'StatuslineModeTerminal', { fg = colors.base(), bg = '#e6c384' })

local M = {}

-- Don't show the command that produced the quickfix list.
vim.g.qf_disable_statusline = 1

-- Show the mode in my custom component instead.
vim.o.showmode = false

--- Keeps track of the highlight groups I've already created.
---@type table<string, boolean>
-- local statusline_hls = {}

---@param hl string
---@return string
function M.get_or_create_hl(hl)
	local hl_name = 'Statusline' .. hl

	-- if not statusline_hls[hl] then
	-- 	-- If not in the cache, create the highlight group using the icon's foreground color
	-- 	-- and the statusline's background color.
	-- 	local bg_hl = vim.api.nvim_get_hl(0, { name = 'StatusLine' })
	-- 	local fg_hl = vim.api.nvim_get_hl(0, { name = hl })
	-- 	vim.api.nvim_set_hl(
	-- 		0,
	-- 		hl_name,
	-- 		{ bg = ('#%06x'):format(bg_hl.bg), fg = ('#%06x'):format(fg_hl.fg) }
	-- 	)
	-- 	statusline_hls[hl] = true
	-- end

	return hl_name
end

--- Current mode.
---@return string
function M.mode_component()
	-- Note that: \19 = ^S and \22 = ^V.
	local mode_to_str = {
		['n'] = 'NORMAL',
		['no'] = 'OP-PENDING',
		['nov'] = 'OP-PENDING',
		['noV'] = 'OP-PENDING',
		['no\22'] = 'OP-PENDING',
		['niI'] = 'NORMAL',
		['niR'] = 'NORMAL',
		['niV'] = 'NORMAL',
		['nt'] = 'NORMAL',
		['ntT'] = 'NORMAL',
		['v'] = 'VISUAL',
		['vs'] = 'VISUAL',
		['V'] = 'VISUAL',
		['Vs'] = 'VISUAL',
		['\22'] = 'VISUAL',
		['\22s'] = 'VISUAL',
		['s'] = 'SELECT',
		['S'] = 'SELECT',
		['\19'] = 'SELECT',
		['i'] = 'INSERT',
		['ic'] = 'INSERT',
		['ix'] = 'INSERT',
		['R'] = 'REPLACE',
		['Rc'] = 'REPLACE',
		['Rx'] = 'REPLACE',
		['Rv'] = 'VIRT REPLACE',
		['Rvc'] = 'VIRT REPLACE',
		['Rvx'] = 'VIRT REPLACE',
		['c'] = 'COMMAND',
		['cv'] = 'VIM EX',
		['ce'] = 'EX',
		['r'] = 'PROMPT',
		['rm'] = 'MORE',
		['r?'] = 'CONFIRM',
		['!'] = 'SHELL',
		['t'] = 'TERMINAL',
	}

	-- Get the respective string to display.
	local mode = mode_to_str[vim.api.nvim_get_mode().mode] or 'UNKNOWN'

	-- Set the highlight group.
	local hl = 'Other'
	if mode:find('NORMAL') then
		hl = 'Normal'
	elseif mode:find('PENDING') then
		hl = 'Pending'
	elseif mode:find('VISUAL') then
		hl = 'Visual'
	elseif mode:find('INSERT') or mode:find('SELECT') then
		hl = 'Insert'
	elseif mode:find('COMMAND') or mode:find('TERMINAL') or mode:find('EX') then
		hl = 'Command'
	end

	-- Construct the bubble-like component.
	return table.concat({
		-- string.format('%%#StatuslineModeSeparator%s# ', hl),
		string.format('%%#MiniStatuslineMode%s# %s ', hl, mode),
		-- string.format('%%#StatuslineModeSeparator%s# ', hl),
	})
end

--- Git status (if any).
---@return string
function M.git_component()
	local head = vim.b.gitsigns_head
	if not head then return '' end

	return string.format(' %s', head)
end

--- The current debugging status (if any).
---@return string?
function M.dap_component()
	if not package.loaded['dap'] or require('dap').status() == '' then return nil end

	return string.format(
		'%%#%s#%s  %s',
		M.get_or_create_hl('DapUIRestart'),
		icons.misc.bug,
		require('dap').status()
	)
end

---@type table<string, string?>
local progress_status = {
	client = nil,
	kind = nil,
	title = nil,
}

vim.api.nvim_create_autocmd('LspProgress', {
	group = vim.api.nvim_create_augroup('mariasolos/statusline', { clear = true }),
	desc = 'Update LSP progress in statusline',
	pattern = { 'begin', 'end' },
	callback = function(args)
		-- This should in theory never happen, but I've seen weird errors.
		if not args.data then return end

		progress_status = {
			client = vim.lsp.get_client_by_id(args.data.client_id).name,
			kind = args.data.result.value.kind,
			title = args.data.result.value.title,
		}

		if progress_status.kind == 'end' then
			progress_status.title = nil
			-- Wait a bit before clearing the status.
			vim.defer_fn(function() vim.cmd.redrawstatus() end, 3000)
		else
			vim.cmd.redrawstatus()
		end
	end,
})
--- The latest LSP progress message.
---@return string
function M.lsp_progress_component()
	if not progress_status.client or not progress_status.title then return '' end

	return table.concat({
		'%#StatuslineSpinner#󱥸 ',
		string.format('%%#StatuslineTitle#%s  ', progress_status.client),
		string.format('%%#StatuslineItalic#%s...', progress_status.title),
	})
end

local last_diagnostic_component = ''
--- Diagnostic counts in the current buffer.
---@return string
function M.diagnostics_component()
	-- Use the last computed value if in insert mode.
	if vim.startswith(vim.api.nvim_get_mode().mode, 'i') then return last_diagnostic_component end

	local counts = vim.iter(vim.diagnostic.get(0)):fold({
		ERROR = 0,
		WARN = 0,
		HINT = 0,
		INFO = 0,
	}, function(acc, diagnostic)
		local severity = vim.diagnostic.severity[diagnostic.severity]
		acc[severity] = acc[severity] + 1
		return acc
	end)

	local parts = vim.iter.map(function(severity, count)
		if count == 0 then return nil end

		local hl = 'Diagnostic' .. severity:sub(1, 1) .. severity:sub(2):lower()
		return string.format('%%#%s#%s %d', M.get_or_create_hl(hl), icons.diagnostics[severity], count)
	end, counts)

	return table.concat(parts, ' ')
end

--- The buffer's filetype.
---@return string
function M.filetype_component()
	local devicons = require('nvim-web-devicons')

	-- Special icons for some filetypes.
	local special_icons = {
		DressingInput = { '󰍩', 'Comment' },
		DressingSelect = { '', 'Comment' },
		OverseerForm = { '󰦬', 'Special' },
		OverseerList = { '󰦬', 'Special' },
		dapui_breakpoints = { icons.misc.bug, 'DapUIRestart' },
		dapui_scopes = { icons.misc.bug, 'DapUIRestart' },
		dapui_stacks = { icons.misc.bug, 'DapUIRestart' },
		fzf = { '', 'Special' },
		gitcommit = { icons.misc.git, 'Number' },
		gitrebase = { icons.misc.git, 'Number' },
		kitty_scrollback = { '󰄛', 'Conditional' },
		lazy = { icons.symbol_kinds.Method, 'Special' },
		lazyterm = { '', 'Special' },
		minifiles = { icons.symbol_kinds.Folder, 'Directory' },
		qf = { icons.misc.search, 'Conditional' },
		spectre_panel = { icons.misc.search, 'Constant' },
	}

	local filetype = vim.bo.filetype
	if filetype == '' then filetype = '[No Name]' end

	local icon, icon_hl
	if special_icons[filetype] then
		icon, icon_hl = unpack(special_icons[filetype])
	else
		local buf_name = vim.api.nvim_buf_get_name(0)
		local name, ext = vim.fn.fnamemodify(buf_name, ':t'), vim.fn.fnamemodify(buf_name, ':e')

		icon, icon_hl = devicons.get_icon(name, ext)
		if not icon then
			icon, icon_hl = devicons.get_icon_by_filetype(filetype, { default = true })
		end
	end
	icon_hl = M.get_or_create_hl(icon_hl)

	return string.format('%%#%s#%s %%#StatuslineTitle#%s', icon_hl, icon, filetype)
end

--- File-content encoding for the current buffer.
---@return string
function M.encoding_component()
	local encoding = vim.opt.fileencoding:get()
	return encoding ~= '' and string.format('%%#StatuslineModeSeparatorOther# %s', encoding) or ''
end

--- The current line, total line count, and column position.
---@return string
function M.position_component()
	local line = vim.fn.line('.')
	local line_count = vim.api.nvim_buf_line_count(0)
	local col = vim.fn.virtcol('.')

	return table.concat({
		'%#StatuslineItalic#l: ',
		string.format('%%#StatuslineTitle#%d', line),
		string.format('%%#StatuslineItalic#/%d c: %d', line_count, col),
	})
end

--- Renders the statusline.
---@return string
function M.render()
	---@param components string[]
	---@return string
	local function concat_components(components)
		return vim.iter(components):skip(1):fold(
			components[1],
			function(acc, component)
				return #component > 0 and string.format('%s    %s', acc, component) or acc
			end
		)
	end

	return table.concat({
		concat_components({
			M.mode_component(),
			M.git_component(),
			M.dap_component() or M.lsp_progress_component(),
		}),
		'%#StatusLine#%=',
		concat_components({
			M.diagnostics_component(),
			M.filetype_component(),
			M.encoding_component(),
			M.position_component(),
		}),
		' ',
	})
end
vim.o.statusline = "%!v:lua.require'local.statusline'.render()"

return M

-- local M = {}
-- local state = {}
--
-- local function default_hl(name, style, opts)
--   opts = opts or {}
--   local ok, hl = pcall(vim.api.nvim_get_hl_by_name, name, 1)
--   if ok and (hl.background or hl.foreground) then
--     return
--   end
--
--   if opts.link then
--     vim.api.nvim_set_hl(0, name, {link = style})
--     return
--   end
--
--   local normal = vim.api.nvim_get_hl_by_name('Normal', 1)
--   local fallback = vim.api.nvim_get_hl_by_name(style, 1)
--
--   vim.api.nvim_set_hl(0, name, {fg = normal.background, bg = fallback.foreground})
-- end
--
-- local mode_higroups = {
--   ['NORMAL'] = 'UserStatusMode_NORMAL',
--   ['VISUAL'] = 'UserStatusMode_VISUAL',
--   ['V-BLOCK'] = 'UserStatusMode_V_BLOCK',
--   ['V-LINE'] = 'UserStatusMode_V_LINE',
--   ['INSERT'] = 'UserStatusMode_INSERT',
--   ['COMMAND'] = 'UserStatusMode_COMMAND',
-- }
--
-- local function apply_hl()
--   default_hl('UserStatusBlock', 'StatusLine', {link = true})
--   default_hl('UserStatusMode_DEFAULT', 'Comment')
--
--   default_hl(mode_higroups['NORMAL'],  'Directory')
--   default_hl(mode_higroups['VISUAL'],  'Number')
--   default_hl(mode_higroups['V-BLOCK'], 'Number')
--   default_hl(mode_higroups['V-LINE'],  'Number')
--   default_hl(mode_higroups['INSERT'],  'String')
--   default_hl(mode_higroups['COMMAND'], 'Special')
-- end
--
-- -- mode_map copied from:
-- -- https://github.com/nvim-lualine/lualine.nvim/blob/5113cdb32f9d9588a2b56de6d1df6e33b06a554a/lua/lualine/utils/mode.lua
-- local mode_map = {
--   ['n']      = 'NORMAL',
--   ['no']     = 'O-PENDING',
--   ['nov']    = 'O-PENDING',
--   ['noV']    = 'O-PENDING',
--   ['no\22']  = 'O-PENDING',
--   ['niI']    = 'NORMAL',
--   ['niR']    = 'NORMAL',
--   ['niV']    = 'NORMAL',
--   ['nt']     = 'NORMAL',
--   ['v']      = 'VISUAL',
--   ['vs']     = 'VISUAL',
--   ['V']      = 'V-LINE',
--   ['Vs']     = 'V-LINE',
--   ['\22']    = 'V-BLOCK',
--   ['\22s']   = 'V-BLOCK',
--   ['s']      = 'SELECT',
--   ['S']      = 'S-LINE',
--   ['\19']    = 'S-BLOCK',
--   ['i']      = 'INSERT',
--   ['ic']     = 'INSERT',
--   ['ix']     = 'INSERT',
--   ['R']      = 'REPLACE',
--   ['Rc']     = 'REPLACE',
--   ['Rx']     = 'REPLACE',
--   ['Rv']     = 'V-REPLACE',
--   ['Rvc']    = 'V-REPLACE',
--   ['Rvx']    = 'V-REPLACE',
--   ['c']      = 'COMMAND',
--   ['cv']     = 'EX',
--   ['ce']     = 'EX',
--   ['r']      = 'REPLACE',
--   ['rm']     = 'MORE',
--   ['r?']     = 'CONFIRM',
--   ['!']      = 'SHELL',
--   ['t']      = 'TERMINAL',
-- }
--
-- local fmt = string.format
-- local hi_pattern = '%%#%s#%s%%*'
--
-- function _G._statusline_component(name)
--   return state[name]()
-- end
--
-- local function show_sign(mode)
--   local empty = ' '
--
--   -- This just checks a user defined variable
--   -- it ignores completely if there are active clients
--   if vim.b.lsp_attached == nil then
--     return empty
--   end
--
--   local ok = ' λ '
--   local ignore = {
--     ['INSERT'] = true,
--     ['COMMAND'] = true,
--     ['TERMINAL'] = true
--   }
--
--   if ignore[mode] then
--     return ok
--   end
--
--   local levels = vim.diagnostic.severity
--   local errors = #vim.diagnostic.get(0, {severity = levels.ERROR})
--   if errors > 0 then
--     return ' ✘ '
--   end
--
--   local warnings = #vim.diagnostic.get(0, {severity = levels.WARN})
--   if warnings > 0 then
--     return ' ▲ '
--   end
--
--   return ok
-- end
--
-- state.show_diagnostic = false
-- state.mode_group = mode_higroups['NORMAL']
--
-- function state.mode()
--   local mode = vim.api.nvim_get_mode().mode
--   local mode_name = mode_map[mode]
--   local text = ' '
--
--   local higroup = mode_higroups[mode_name]
--
--   if higroup then
--     state.mode_group = higroup
--     -- if state.show_diagnostic then text = show_sign(mode_name) end
--
--     return fmt(hi_pattern, higroup, text)
--   end
--
--   state.mode_group = 'UserStatusMode_DEFAULT'
--   -- text = fmt(' %s %s ', mode_name, mode)
--   -- return fmt(hi_pattern, state.mode_group, text)
--   return mode
-- end
--
-- function state.position()
--   return fmt(hi_pattern, state.mode_group, ' %3l:%-2c ')
-- end
--
-- state.percent = fmt(hi_pattern, 'UserStatusBlock', ' %2p%% ')
--
-- state.full_status = {
--   '%{%v:lua._statusline_component("mode")%} ',
--   '%t',
--   '%r',
--   '%m',
--   '%=',
--   '%{&filetype} ',
--   state.percent,
--   '%{%v:lua._statusline_component("position")%}'
-- }
--
-- state.short_status = {
--   state.full_status[1],
--   '%=',
--   state.percent,
--   state.full_status[8]
-- }
--
-- state.inactive_status = {
--   ' %t',
--   '%r',
--   '%m',
--   '%=',
--   '%{&filetype} |',
--   ' %2p%% | ',
--   '%3l:%-2c ',
-- }
--
-- function M.setup()
--   local augroup = vim.api.nvim_create_augroup('statusline_cmds', {clear = true})
--   local autocmd = vim.api.nvim_create_autocmd
--   vim.opt.showmode = false
--
--   apply_hl()
--   local pattern = M.get_status('full')
--   if pattern then
--     vim.o.statusline = pattern
--   end
--
--   autocmd('ColorScheme', {
--     group = augroup,
--     desc = 'Apply statusline highlights',
--     callback = apply_hl
--   })
--   autocmd('FileType', {
--     group = augroup,
--     pattern = {'ctrlsf', 'Neogit*'},
--     desc = 'Apply short statusline',
--     callback = function()
--       vim.w.status_style = 'short'
--       vim.wo.statusline = M.get_status('short')
--     end
--   })
--   autocmd('InsertEnter', {
--     group = augroup,
--     desc = 'Clear message area',
--     command = "echo ''"
--   })
--   autocmd('LspAttach', {
--     group = augroup,
--     once = true,
--     desc = 'Show diagnostic sign',
--     callback = function()
--       vim.b.lsp_attached = 1
--       state.show_diagnostic = true
--     end
--   })
--   autocmd('WinEnter', {
--     group = augroup,
--     desc = 'Change statusline',
--     callback = function()
--       local winconfig = vim.api.nvim_win_get_config(0)
--       if winconfig.relative ~= '' then
--         return
--       end
--
--       local style = vim.w.status_style
--       if style == nil then
--         style = 'full'
--         vim.w.status_style = style
--       end
--
--       vim.wo.statusline = M.get_status(style)
--
--       local winnr = vim.fn.winnr('#')
--       if winnr == 0 then
--         return
--       end
--
--       local curwin = vim.api.nvim_get_current_win()
--       local winid = vim.fn.win_getid(winnr)
--       if winid == 0 or winid == curwin then
--         return
--       end
--
--       if vim.api.nvim_win_is_valid(winid) then
--         vim.wo[winid].statusline = M.get_status('inactive')
--       end
--     end
--   })
-- end
--
-- function M.get_status(name)
--   return table.concat(state[fmt('%s_status', name)], '')
-- end
--
-- function M.apply(name)
--   vim.o.statusline = M.get_status(name)
-- end
--
-- function M.higroups()
--   local res = vim.deepcopy(mode_higroups)
--   res['DEFAULT'] = 'UserStatusMode_DEFAULT'
--   res['STATUS-BLOCK'] = 'UserStatusBlock'
--   return res
-- end
--
-- M.default_hl = apply_hl
--
-- return M
