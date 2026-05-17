local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd('MenuPopup', {
	group = augroup('popupmenu', {}),
	pattern = '*',
	callback = function()
		local cword = vim.fn.expand('<cword>')
		vim.cmd([[
			aunmenu PopUp
			autocmd! nvim.popupmenu

			anoremenu PopUp.Definition              <cmd>lua vim.lsp.buf.definition()<CR>
			anoremenu PopUp.References              <cmd>lua vim.lsp.buf.references()<CR>
			anoremenu PopUp.Implementation          <cmd>lua vim.lsp.buf.implementation()<CR>
			anoremenu PopUp.Declaration             <cmd>lua vim.lsp.buf.declaration()<CR>
			anoremenu PopUp.-1-                     <Nop>
			anoremenu PopUp.Show\ Diagnostics       <cmd>lua vim.diagnostic.open_float()<CR>
			anoremenu PopUp.Find\ symbol            <cmd>lua vim.lsp.buf.workspace_symbol(vim.fn.expand('<cword>'))<CR>
			anoremenu PopUp.-2-                     <Nop>
			anoremenu PopUp.Open\ in\ web\ browser  gx
			anoremenu PopUp.Inspect                 <cmd>Inspect<CR>
			anoremenu PopUp.-3-                     <Nop>
			vnoremenu PopUp.Cut                     "+x
			vnoremenu PopUp.Copy                    "+y
			anoremenu PopUp.Paste                   "+gP
			vnoremenu PopUp.Paste                   "+P
			vnoremenu PopUp.Delete                  "_x
			"nnoremenu PopUp.Select\ All             ggVG
			"vnoremenu PopUp.Select\ All             gg0oG$
			"inoremenu PopUp.Select\ All             <C-Home><C-O>VG
		]])

		-- LSP
		if cword == '' or not vim.lsp.get_clients({ bufnr = 0, method = 'textDocument/definition' }) then
			vim.cmd([[amenu disable PopUp.Definition]])
		end
		if cword == '' or not vim.lsp.get_clients({ bufnr = 0, method = 'textDocument/references' }) then
			vim.cmd([[amenu disable PopUp.References]])
		end
		if cword == '' or not vim.lsp.get_clients({ bufnr = 0, method = 'textDocument/implementation' }) then
			vim.cmd([[amenu disable PopUp.Implementation]])
		end
		if cword == '' or not vim.lsp.get_clients({ bufnr = 0, method = 'textDocument/declaration' }) then
			vim.cmd([[amenu disable PopUp.Declaration]])
		end
	end,
})
