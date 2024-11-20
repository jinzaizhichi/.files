require 'dvt.keymaps'
require 'dvt.settings'
require 'dvt.lazy_init'
require 'dvt.health'

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Configure diagnostics
-- Change diagnostic symbols in the sign column (gutter)
local signs = { ERROR = '', WARN = '', HINT = '', INFO = '' }
local diagnostic_signs = {}
for type, icon in pairs(signs) do
  diagnostic_signs[vim.diagnostic.severity[type]] = icon
end

vim.diagnostic.config {
  float = { border = 'rounded' },
  signs = { text = diagnostic_signs },
}
