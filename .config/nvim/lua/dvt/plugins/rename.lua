return {
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
}
