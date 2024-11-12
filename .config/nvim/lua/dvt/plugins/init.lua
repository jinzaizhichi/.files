return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = true } },
  {
    'saecki/live-rename.nvim',
    keys = {
      {
        '<leader>rl',
        function()
          require('live-rename').rename { insert = true }
        end,
        desc = 'LSP: [R]ename',
      },
    },
  },
}
