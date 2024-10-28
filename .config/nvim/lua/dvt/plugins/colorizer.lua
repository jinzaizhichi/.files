return {
  'norcalli/nvim-colorizer.lua',
  config = function()
    require('colorizer').setup({ '*' }, {
      RGB = true,
      RRGGBB = true,
      RRGGBBAA = true,
      rgb_fn = true,
      hsl_fn = true,
      css = true,
      css_fn = true,
      mode = 'background',
    })

    vim.api.nvim_create_autocmd({ 'BufEnter' }, {
      pattern = { '*' },
      callback = function()
        vim.cmd 'ColorizerAttachToBuffer'
      end,
    })

    vim.keymap.set('n', '<leader>th', function()
      vim.cmd 'ColorizerToggle'
    end, { desc = 'Toggle [H]ighlighting' })
  end,
}
