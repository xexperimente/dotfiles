local M = {}

-- -- https://www.reddit.com/r/neovim/comments/1fzn1zt/custom_fold_text_function_with_treesitter_syntax
-- function M.fold_virt_text(result, s, lnum, coloff)
-- 	if not coloff then coloff = 0 end
-- 	local text = ''
-- 	local hl
-- 	for i = 1, #s do
-- 		local char = s:sub(i, i)
-- 		local hls = vim.treesitter.get_captures_at_pos(0, lnum, coloff + i - 1)
-- 		local _hl = hls[#hls]
-- 		if _hl then
-- 			local new_hl = '@' .. _hl.capture
-- 			if new_hl ~= hl then
-- 				table.insert(result, { text, hl })
-- 				text = ''
-- 				hl = nil
-- 			end
-- 			text = text .. char
-- 			hl = new_hl
-- 		else
-- 			text = text .. char
-- 		end
-- 	end
-- 	table.insert(result, { text, hl })
-- end

-- function M.custom_foldtext()
-- 	local start = vim.fn.getline(vim.v.foldstart):gsub('\t', string.rep(' ', vim.o.tabstop))
-- 	local end_str = vim.fn.getline(vim.v.foldend)
-- 	local end_ = vim.trim(end_str)
-- 	local result = {}
-- 	M.fold_virt_text(result, start, vim.v.foldstart - 1)
-- 	table.insert(result, { ' ... ', 'Delimiter' })
-- 	M.fold_virt_text(result, end_, vim.v.foldend - 1, #(end_str:match('^(%s+)') or ''))
-- 	return result
-- end

-- Borrowed from https://github.com/OXY2DEV/foldtext.nvim because my solution has sometimes glitches
function M.custom_foldtext()
	local window = vim.api.nvim_get_current_win()
	local buffer = vim.api.nvim_win_get_buf(window)

	local start = vim.fn.getbufline(buffer, vim.v.foldstart)[1] or ''
	local stop = vim.fn.getbufline(buffer, vim.v.foldend)[1] or ''
	local fragments = {}
	local virtcol = -1

	local d = 0

	local delimiter = ' ... '

	for p, part in ipairs(vim.fn.split(start, '\\zs')) do
		-- Start line of fold

		local hl_captures = vim.treesitter.get_captures_at_pos(buffer, vim.v.foldstart - 1, p - 1)

		if d <= virtcol then goto continue end

		if #hl_captures > 0 then
			local last = hl_captures[#hl_captures]

			--- @diagnostic disable-next-line: need-check-nil
			table.insert(fragments, { part, '@' .. last.capture .. '.' .. last.lang })
		else
			table.insert(fragments, { part })
		end

		::continue::
		d = d + vim.fn.strdisplaywidth(part)
	end

	local match = string.match(stop, '^%s*') or ''
	local whitespace = vim.fn.strchars(match)

	for _, part in ipairs(vim.fn.split(delimiter, '\\zs')) do
		if d <= virtcol then goto continue end

		table.insert(fragments, { part, 'comment' })

		::continue::
		d = d + vim.fn.strdisplaywidth(part)
	end

	for p, part in ipairs(vim.fn.split(stop, '\\zs')) do
		-- End line of fold

		local hl_captures = vim.treesitter.get_captures_at_pos(buffer, vim.v.foldend - 1, p - 1)

		if p <= whitespace or d <= virtcol then goto continue end

		if #hl_captures > 0 then
			local last = hl_captures[#hl_captures]

			--- @diagnostic disable-next-line: need-check-nil
			table.insert(fragments, { part, '@' .. last.capture .. '.' .. last.lang })
		else
			table.insert(fragments, { part })
		end

		::continue::
		d = d + vim.fn.strdisplaywidth(part)
	end

	return fragments
end

return M
