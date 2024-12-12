return {
  -- Highlight todo, notes, etc in comments
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    {
      '[t',
      require('todo-comments').jump_prev,
      desc = 'Previous [t]odo comment',
    },
    {
      ']t',
      require('todo-comments').jump_next,
      desc = 'Next [t]odo comment',
    },
    {
      '<leader>st',
      ':TodoTelescope<CR>',
      desc = 'Search [T]odo',
    },
  },
  opts = { signs = true },
}
