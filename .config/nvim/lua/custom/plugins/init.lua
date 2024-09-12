-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Custom themes
  {
    'Mofiqul/dracula.nvim',
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'dracula'

      -- You can configure highlights by doing something like:
      --vim.cmd.hi 'Comment gui=none'
    end,
    opts = {
      italic_comment = true,
    },
  },
  { 'rose-pine/neovim', name = 'rose-pine' },
  { 'ellisonleao/gruvbox.nvim', priority = 1000, config = true },
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gf', vim.cmd.Git, { desc = '[G]it [F]ugitive' })
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  },
  {
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
      end, { desc = '[T]oggle [H]ighlighting' })
    end,
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()

      vim.keymap.set('n', '<leader>ha', function()
        harpoon:list():add()
      end, { desc = 'Harpoon [a]ppend' })

      vim.keymap.set('n', '<leader>hu', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Harpoon [U]I' })

      vim.keymap.set('n', '<C-S-n>', function()
        harpoon:list():select(1)
      end)
      vim.keymap.set('n', '<C-S-e>', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '<C-S-i>', function()
        harpoon:list():select(3)
      end)
      vim.keymap.set('n', '<C-S-o>', function()
        harpoon:list():select(4)
      end)
    end,
  },
}
