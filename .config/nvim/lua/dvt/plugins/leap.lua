return {
  'ggandor/leap.nvim',
  dependencies = {
    'tpope/vim-repeat',
  },
  config = function()
    vim.keymap.set('n', '<CR>', '<Plug>(leap)')
    vim.keymap.set('n', 'g<CR>', '<Plug>(leap-from-window)')
    vim.keymap.set({ 'x', 'o' }, '<CR>', '<Plug>(leap-forward)')
    vim.keymap.set({ 'x', 'o' }, 'g<CR>', '<Plug>(leap-backward)')

    -- Define equivalence classes for brackets and quotes, in addition to
    -- the default whitespace group.
    require('leap').opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }
  end,
}
