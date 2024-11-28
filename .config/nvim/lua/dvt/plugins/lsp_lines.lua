return {
  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  -- For some reason, I can't lazy load this plugin whenever I use the keys item from lazy
  lazy = false,
  init = function()
    vim.g.lsp_lines_enabled = true
    vim.diagnostic.config {
      virtual_text = false,
      virtual_lines = true,
    }
  end,
  keys = {
    {
      -- Toggles diagnostics between this plugin and default
      '<leader>td',
      function()
        vim.g.lsp_lines_enabled = not vim.g.lsp_lines_enabled
        vim.diagnostic.config {
          virtual_text = not vim.g.lsp_lines_enabled,
          virtual_lines = vim.g.lsp_lines_enabled,
        }
      end,
      desc = 'Toggle [d]iagnostic',
    },
  },
  opts = {},
}
