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

		-- Plugins
		-- if cword == '' or not LazyVim.has('telescope.nvim') then
		-- 	vim.cmd([[amenu disable PopUp.Find\ symbol]])
		-- end
		-- if cword == '' or not LazyVim.has_extra('editor.snacks_explorer') then
		-- 	vim.cmd([[amenu disable PopUp.Grep]])
		-- end
		-- if not LazyVim.has('trouble.nvim') then
		-- 	vim.cmd([[amenu disable PopUp.Diagnostics\ (Trouble)]])
		-- end
		-- if not LazyVim.has('todo-comments.nvim') then
		-- 	vim.cmd([[amenu disable PopUp.TODOs]])
		-- end
		-- if not LazyVim.has('bookmarks.nvim') then
		-- 	vim.cmd([[amenu disable PopUp.Bookmarks]])
		-- end
		-- if not LazyVim.has('snacks.nvim') then
		-- 	vim.cmd([[
		-- 		amenu disable PopUp.LazyGit
		-- 		amenu disable PopUp.Open\ Git\ in\ browser
		-- 	]])
		-- end
	end,
})
-- vim.cmd([[
--   aunmenu   PopUp
--   anoremenu PopUp.Inspect                 <Cmd>Inspect<CR>
--   amenu     PopUp.-1-                     <Nop>
--   anoremenu PopUp.Go\ to\ definition      <Cmd>lua vim.lsp.buf.definition()<CR>
--   anoremenu PopUp.References              <Cmd>lua Snacks.picker.lsp_references()<CR>
--   nnoremenu PopUp.Back                    <C-t>
--   amenu     PopUp.Open\ in\ web\ browser  gx
-- ]])

-- local nvim_popupmenu_augroup = vim.api.nvim_create_augroup('nvim_popupmenu', { clear = true })
-- vim.api.nvim_create_autocmd('MenuPopup', {
-- 	pattern = '*',
-- 	group = nvim_popupmenu_augroup,
-- 	desc = 'Custom Setup',
-- 	callback = function()
-- 		vim.cmd([[
--       " Urls
--       amenu disable PopUp.Open\ in\ web\ browser
--
--       " LSP
--       amenu disable PopUp.Go\ to\ definition
--       amenu disable PopUp.References
--     ]])
--
-- 		local urls = require('vim.ui')._get_urls()
-- 		if vim.startswith(urls[1], 'http') then vim.cmd([[amenu enable PopUp.Open\ in\ web\ browser]]) end
--
-- 		if vim.lsp.get_clients({ bufnr = 0 })[1] then
-- 			vim.cmd([[anoremenu enable PopUp.Go\ to\ definition]])
-- 			vim.cmd([[anoremenu enable PopUp.References]])
-- 		end
-- 	end,
-- })
