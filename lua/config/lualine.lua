local M = {
	setup = function ()
		local lualine = require('lualine')
		lualine.setup({
			options = {
				theme = 'iceberg',
				icons_enabled = true,
				component_separators = '|',
				section_separators = '',
			}
		})
	end
}

return M
