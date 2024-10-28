return {
  'mikavilpas/yazi.nvim',
  event = 'VeryLazy',
  keys = {
    -- 👇 in this section, choose your own keymappings!
    {
      '<leader>e',
      '<cmd>Yazi<cr>',
      desc = 'Open yazi at the current file',
    },
    -- {
    -- Open in the current working directory
    --   '<leader>cw',
    --   '<cmd>Yazi cwd<cr>',
    --   desc = "Open the file manager in nvim's working directory",
    -- },
  },
  ---@type YaziConfig
  opts = {
    -- if you want to open yazi instead of netrw, see below for more info
    open_for_directories = false,
    keymaps = {
      show_help = '?',
      open_file_in_vertical_split = '<A-v>',
      open_file_in_horizontal_split = '<A-h>',
      open_file_in_tab = '<A-t>',
      grep_in_directory = '<A-s>',
    },
  },
}
