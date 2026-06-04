vim.schedule(function()
	vim.pack.add({ 'https://github.com/lewis6991/satellite.nvim' })

	-- '🭶','🭷','🭸','🭹','🭺','🭻'
	-- '🬂','🬋','🬭'
	-- '▀', '▄'

	local opts = {
		handlers = {
			cursor = { enable = true, symbols = { '▀', '▄' } },
			marks = { enable = false },
			gitsigns = { enable = false },
			minidiff = { enable = true },
			quickfix = { enable = false },
		},
	}
	require('satellite').setup(opts --[[@as SatelliteConfig]])

	-- Register custom handler for Mini.diff
	local api = vim.api
	local util = require('satellite.util')
	local augroup = vim.api.nvim_create_augroup('xexperimente/satellite', {})

	local handler = {
		name = 'minidiff',
	}

	local config = {
		enable = true,
		overlap = false,
		priority = 20,
		symbol = '┃',
	}

	function handler.setup(config0, update)
		config = vim.tbl_deep_extend('force', config, config0)
		handler.config = config

		api.nvim_create_autocmd('User', {
			pattern = 'MiniDiffUpdated',
			group = augroup,
			callback = function() update() end,
		})
	end

	function handler.update(bufnr, winid)
		local marks = {} --- @type Satellite.Mark[]

		local summary = vim.b[bufnr].minidiff_summary
		if not summary then return marks end

		local hunks = require('mini.diff').get_buf_data(bufnr).hunks or {}

		for _, hunk in ipairs(hunks) do
			local highlight = 'MiniDiffSignChange'
			if hunk.type == 'add' then
				highlight = 'MiniDiffSignAdd'
			elseif hunk.type == 'delete' then
				highlight = 'MiniDiffSignDelete'
			end

			-- mini.diff používá 1-indexed řádky
			-- satellite.nvim potřebuje rozsah (počáteční řádek je inkluzivní, koncový exkluzivní)
			-- local start_row = hunk.buf_start
			-- local end_row = hunk.buf_start + hunk.buf_count
			--
			-- -- Ošetření pro smazané řádky (buf_count může být 0)
			-- if start_row == end_row then end_row = start_row + 1 end

			-- local min_lnum = math.max(1, start_row)
			-- local min_pos = util.row_to_barpos(winid, start_row - 1)
			--
			-- -- local max_lnum = math.max(1, end_row)
			-- local max_pos = util.row_to_barpos(winid, end_row - 1)

			local min_lnum = math.max(1, hunk.buf_start)
			local min_pos = util.row_to_barpos(winid, min_lnum - 1)

			local max_lnum = math.max(1, hunk.buf_start + math.max(0, hunk.buf_count - 1))
			local max_pos = util.row_to_barpos(winid, max_lnum - 1)

			for pos = min_pos, max_pos do
				marks[#marks + 1] = {
					pos = pos,
					symbol = '┃',
					highlight = highlight,
				}
			end
		end
		return marks
	end

	require('satellite.handlers').register(handler)
end)
