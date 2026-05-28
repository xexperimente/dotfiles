vim.schedule(function()
	if vim.fn.executable('zls') then vim.lsp.enable('zls') end
end)
