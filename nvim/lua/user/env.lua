local M = {}

-- Place to store user configuration options

M.border = 'single'

M.cmp_border = 'rounded'

function M.use_dark_theme()
	local time = os.date('*t')
	if time.hour >= 19 or time.hour < 5 then return true end

	return false
end

return M
