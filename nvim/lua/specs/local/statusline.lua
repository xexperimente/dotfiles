local path =  vim.fn.stdpath('config')

local Plugin = {}

Plugin.name = 'statusline'
Plugin.dir = vim.fs.joinpath(path, 'pack', Plugin.name)
Plugin.config = false
Plugin.lazy = false

return Plugin

