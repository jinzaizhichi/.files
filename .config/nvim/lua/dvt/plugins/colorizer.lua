return {
  'NvChad/nvim-colorizer.lua',
  init = function()
    vim.g.highlighting_enabled = true
  end,
  config = function()
    require('colorizer').setup {
      filetypes = { '*' },
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        RRGGBBAA = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
        mode = 'background',
      },
    }

    vim.api.nvim_create_autocmd({ 'BufEnter' }, {
      pattern = { '*' },
      callback = function()
        vim.cmd 'ColorizerAttachToBuffer'
      end,
    })

    vim.keymap.set('n', '<leader>th', function()
      vim.cmd 'ColorizerToggle'
      vim.g.highlighting_enabled = not vim.g.highlighting_enabled

      if vim.g.highlighting_enabled then
        print 'Highlighting enabled'
      else
        print 'Highlighting disabled'
      end
    end, { desc = 'Toggle [H]ighlighting' })
  end,
}
