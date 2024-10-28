return {
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

    vim.keymap.set('n', '<A-n>', function()
      harpoon:list():select(1)
    end)
    vim.keymap.set('n', '<A-e>', function()
      harpoon:list():select(2)
    end)
    vim.keymap.set('n', '<A-i>', function()
      harpoon:list():select(3)
    end)
    vim.keymap.set('n', '<A-o>', function()
      harpoon:list():select(4)
    end)
  end,
}
