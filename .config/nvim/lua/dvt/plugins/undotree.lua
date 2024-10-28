return {
  'mbbill/undotree',
  config = function()
    vim.keymap.set('n', '<leader>tu', vim.cmd.UndotreeToggle, { desc = 'Toggle [u]ndo tree' })
  end,
}
