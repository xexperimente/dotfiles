local M = {}

-- https://www.reddit.com/r/neovim/comments/1fzn1zt/custom_fold_text_function_with_treesitter_syntax
function M.fold_virt_text(result, s, lnum, coloff)
	if not coloff then coloff = 0 end
	local text = ''
	local hl
	for i = 1, #s do
		local char = s:sub(i, i)
		local hls = vim.treesitter.get_captures_at_pos(0, lnum, coloff + i - 1)
		local _hl = hls[#hls]
		if _hl then
			local new_hl = '@' .. _hl.capture
			if new_hl ~= hl then
				table.insert(result, { text, hl })
				text = ''
				hl = nil
			end
			text = text .. char
			hl = new_hl
		else
			text = text .. char
		end
	end
	table.insert(result, { text, hl })
end

function M.custom_foldtext()
	local start = vim.fn.getline(vim.v.foldstart):gsub('\t', string.rep(' ', vim.o.tabstop))
	local end_str = vim.fn.getline(vim.v.foldend)
	local end_ = vim.trim(end_str)
	local result = {}
	M.fold_virt_text(result, start, vim.v.foldstart - 1)
	table.insert(result, { ' ... ', 'Delimiter' })
	M.fold_virt_text(result, end_, vim.v.foldend - 1, #(end_str:match('^(%s+)') or ''))
	return result
end

return M
