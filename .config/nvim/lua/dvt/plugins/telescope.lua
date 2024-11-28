return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'echasnovski/mini.nvim' },
  },
  init = function()
    vim.g.is_inside_work_tree = {}
    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
  end,
  keys = {
    {
      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      '<leader>s/',
      function()
        require('telescope.builtin').live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end,
      desc = '[S]earch [/] in Open Files',
    },
    {
      -- Shortcut for searching your Neovim configuration files
      '<leader>sc',
      function()
        require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = '[S]earch [C]onfig files',
    },
    {
      -- Slightly advanced example of overriding default behavior and theme
      '<leader>/',
      function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end,
      desc = '[/] Fuzzily search in current buffer',
    },

    { '<leader>sb', require('telescope.builtin').buffers, desc = '[S]earch Existing [B]uffers' },
    { '<leader>so', require('telescope.builtin').oldfiles, desc = '[S]earch [O]ld Files' },
    { '<leader>sr', require('telescope.builtin').resume, desc = '[S]earch [R]esume' },
    { '<leader>sd', require('telescope.builtin').diagnostics, desc = '[S]earch [D]iagnostics' },
    { '<leader>sg', require('telescope.builtin').live_grep, desc = '[S]earch by [G]rep' },
    { '<leader>sw', require('telescope.builtin').grep_string, desc = '[S]earch current [W]ord' },
    { '<leader>ss', require('telescope.builtin').builtin, desc = '[S]earch [S]elect Telescope' },
    {
      -- Search git files if within git project, otherwise do entire system
      -- Gotten from: https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#falling-back-to-find_files-if-git_files-cant-find-a-git-directory
      '<leader>sf',
      function()
        local cwd = vim.fn.getcwd()
        if vim.g.is_inside_work_tree[cwd] == nil then
          local result = vim.system({ 'git', 'rev-parse', '--is-inside-work-tree' }, { text = true }):wait()
          vim.g.is_inside_work_tree[cwd] = result.code == 0
        end

        if vim.g.is_inside_work_tree[cwd] then
          require('telescope.builtin').git_files { no_ignore = true, no_ignore_parent = true, hidden = true }
        else
          require('telescope.builtin').find_files { no_ignore = true, no_ignore_parent = true, hidden = true }
        end
      end,
      desc = '[S]earch [F]iles',
    },
    {
      '<leader>sk',
      require('telescope.builtin').keymaps,
      desc = '[S]earch [K]eymaps',
    },
    {
      '<leader>sh',
      require('telescope.builtin').help_tags,
      desc = '[S]earch [H]elp',
    },
  },
  opts = {
    defaults = {
      layout_strategy = 'center',
      sorting_strategy = 'ascending',
      layout_config = {
        horizontal = {
          prompt_position = 'top',
        },
        center = {
          width = 0.8,
          height = 0.3,
        },
      },
      -- Disable all default mappings
      default_mappings = {},
      mappings = {
        i = {
          -- Basically disable normal mode when using telescope
          ['<ESC>'] = require('telescope.actions').close,
          ['<CR>'] = require('telescope.actions').select_default,
          ['<C-h>'] = require('telescope.actions').select_horizontal,
          ['<C-v>'] = require('telescope.actions').select_vertical,
          ['<UP>'] = require('telescope.actions').move_selection_previous,
          ['<DOWN>'] = require('telescope.actions').move_selection_next,
          ['<C-u>'] = require('telescope.actions').preview_scrolling_up,
          ['<C-d>'] = require('telescope.actions').preview_scrolling_down,
          ['<C-q>'] = require('telescope.actions').send_to_qflist,
          ['<C-/>'] = require('telescope.actions').which_key,
        },
      },
    },
    pickers = {
      help_tags = {
        mappings = {
          i = {
            ['<CR>'] = require('telescope.actions').select_vertical,
          },
        },
      },
    },
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown(),
      },
    },
  },
}
