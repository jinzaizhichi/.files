return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  opts = {
    preset = 'helix',
  },
  config = function(_, opts) -- This is the function that runs, AFTER loading
    require('which-key').setup(opts)

    -- Document existing key chains
    require('which-key').add {
      { '<leader>r', group = '[R]ename' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>h', group = '[H]arpoon' },
      { '<leader>g', group = '[G]it' },
    }
  end,
}
