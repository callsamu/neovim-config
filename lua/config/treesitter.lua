local M =  {
	setup =  function ()
		local treesitter = require('nvim-treesitter.configs')
		treesitter.setup({
			highlight = {
				enable = true,
			},
			ensure_installed = {
				'javascript',
				'typescript',
				'tsx',
				'html',
				'css',
				'json',
				'yaml',
				'lua',
			}
		})
	end
}

return M
