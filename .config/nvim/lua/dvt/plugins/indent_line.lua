return {
  -- Add indentation guides even on blank lines
  'lukas-reineke/indent-blankline.nvim',
  enabled = false,
  -- Enable `lukas-reineke/indent-blankline.nvim`
  -- See `:help ibl`
  main = 'ibl',
  opts = {
    indent = {
      char = '│',
      tab_char = '│',
    },
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
    },
  },
}
