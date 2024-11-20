return {
  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  init = function()
    vim.diagnostic.config { virtual_text = false, update_in_insert = true }
  end,
  opts = {},
}
