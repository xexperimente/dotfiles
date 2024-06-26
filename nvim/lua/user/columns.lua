local M = {}

-- To display the `number` in the `statuscolumn` according to
-- the `number` and `relativenumber` options and their combinations
function M.number()
	if vim.v.virtnum < 0 then return '' end

	local nu = vim.opt.number:get()
	local rnu = vim.opt.relativenumber:get()
	local cur_line = vim.fn.line('.') == vim.v.lnum and vim.v.lnum or vim.v.relnum

	-- Repeats the behavior for `vim.opt.numberwidth`
	local width = vim.opt.numberwidth:get()
	local l_count_width = #tostring(vim.api.nvim_buf_line_count(0))
	-- If buffer have more lines than `vim.opt.numberwidth` then use width of line count
	width = width >= l_count_width and width or l_count_width

	local function pad_start(n)
		local len = width - #tostring(n)
		return len < 1 and n or (' '):rep(len) .. n
	end

	if nu and rnu then
		return pad_start(cur_line)
	elseif nu then
		return pad_start(vim.v.lnum)
	elseif rnu then
		return pad_start(vim.v.relnum)
	end

	return ''
end

-- To display pretty fold's icons in `statuscolumn` and show it according to `fillchars`
function M.foldcolumn()
	if vim.v.virtnum < 0 then return '' end

	local chars = vim.opt.fillchars:get()
	local fc = '%#FoldColumn#'
	local clf = '%#CursorLineFold#'
	local hl = vim.fn.line('.') == vim.v.lnum and clf or fc

	if vim.fn.foldlevel(vim.v.lnum) > vim.fn.foldlevel(vim.v.lnum - 1) then
		if vim.fn.foldclosed(vim.v.lnum) == -1 then
			return hl .. (chars.foldopen or ' ')
		else
			return hl .. (chars.foldclose or ' ')
		end
	elseif vim.fn.foldlevel(vim.v.lnum) == 0 then
		return hl .. ' '
	else
		return hl .. (chars.foldsep or ' ')
	end
end

-- vim.treesitter.foldtext() is deprecated .. this is its implementation from core
function M.foldtext()
	local api = vim.api
	local ts = vim.treesitter
	local foldstart = vim.v.foldstart
	local bufnr = api.nvim_get_current_buf()

	-- @type boolean, LanguageTree
	local ok, parser = pcall(ts.get_parser, bufnr)
	if not ok then return vim.fn.foldtext() end

	local query = ts.query.get(parser:lang(), 'highlights')
	if not query then return vim.fn.foldtext() end

	local tree = parser:parse({ foldstart - 1, foldstart })[1]

	local line = api.nvim_buf_get_lines(bufnr, foldstart - 1, foldstart, false)[1]
	if not line then return vim.fn.foldtext() end

	---@type { [1]: string, [2]: string[], range: { [1]: integer, [2]: integer } }[] | { [1]: string, [2]: string[] }[]
	local result = {}

	local line_pos = 0

	for id, node, metadata in query:iter_captures(tree:root(), 0, foldstart - 1, foldstart) do
		local name = query.captures[id]
		local start_row, start_col, end_row, end_col = node:range()

		local priority = tonumber(metadata.priority or vim.highlight.priorities.treesitter)

		if start_row == foldstart - 1 and end_row == foldstart - 1 then
			-- check for characters ignored by treesitter
			if start_col > line_pos then
				table.insert(result, {
					line:sub(line_pos + 1, start_col),
					{ { 'Folded', priority } },
					range = { line_pos, start_col },
				})
			end
			line_pos = end_col

			local text = line:sub(start_col + 1, end_col)
			table.insert(result, { text, { { '@' .. name, priority } }, range = { start_col, end_col } })
		end
	end

	local i = 1
	while i <= #result do
		-- find first capture that is not in current range and apply highlights on the way
		local j = i + 1
		while
			j <= #result
			and result[j].range[1] >= result[i].range[1]
			and result[j].range[2] <= result[i].range[2]
		do
			for k, v in ipairs(result[i][2]) do
				if not vim.tbl_contains(result[j][2], v) then table.insert(result[j][2], k, v) end
			end
			j = j + 1
		end

		-- remove the parent capture if it is split into children
		if j > i + 1 then
			table.remove(result, i)
		else
			-- highlights need to be sorted by priority, on equal prio, the deeper nested capture (earlier
			-- in list) should be considered higher prio
			if #result[i][2] > 1 then table.sort(result[i][2], function(a, b) return a[2] < b[2] end) end

			result[i][2] = vim.tbl_map(function(tbl) return tbl[1] end, result[i][2])
			result[i] = { result[i][1], result[i][2] }

			i = i + 1
		end
	end

	table.insert(
		result,
		{ ' {  }  -- ' .. vim.v.foldend - vim.v.foldstart .. ' lines', 'Comment' }
	)

	return result
end

function M.signcolumn()
	if vim.v.virtnum < 0 then return '' end

	return '%s'
end

return M
