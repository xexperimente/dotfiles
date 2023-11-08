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

function M.signcolumn()
	if vim.v.virtnum < 0 then return '' end

	return '%s'
end

return M
