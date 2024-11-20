return {
  'NvChad/nvim-colorizer.lua',
  event = 'BufEnter',
  init = function()
    vim.g.highlighting_enabled = true

    -- Automatically attach to buffer (aka automatically enable it)
    vim.api.nvim_create_autocmd({ 'BufEnter' }, {
      pattern = { '*' },
      callback = function()
        vim.cmd 'ColorizerAttachToBuffer'
      end,
    })
  end,
  keys = {
    {
      '<leader>th',
      function()
        vim.cmd 'ColorizerToggle'
        vim.g.highlighting_enabled = not vim.g.highlighting_enabled

        if vim.g.highlighting_enabled then
          require('fidget').notify('Highlighting enabled', nil, { key = 'toggle_highlight' })
        else
          require('fidget').notify('Highlighting disabled', nil, { key = 'toggle_highlight' })
        end
      end,
      desc = 'Toggle [H]ighlighting',
    },
  },
  opts = {
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
  },
}
