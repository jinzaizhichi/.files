return {
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      current_line_blame_opts = {
        delay = 0,
      },
      preview_config = {
        border = 'rounded',
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Hunk Navigation
        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous Git [c]hange' })

        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next Git [c]hange' })

        -- Hunk Actions
        map('n', '<leader>gs', gitsigns.stage_hunk, { desc = '[S]tage hunk' })
        map('v', '<leader>gs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = '[S]tage hunk' })
        map(
          'n',
          '<leader>gu',
          gitsigns.undo_stage_hunk,
          { desc = '[U]nstage previous staged hunk' }
        )
        map('n', '<leader>gr', gitsigns.reset_hunk, { desc = '[R]eset hunk' })
        map('v', '<leader>gr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = '[R]eset hunk' })
        map('n', '<leader>gp', gitsigns.preview_hunk, { desc = '[P]review hunk' })

        -- Buffer Actions
        map('n', '<leader>gS', gitsigns.stage_buffer, { desc = '[S]tage buffer' })
        map('n', '<leader>gR', gitsigns.reset_buffer, { desc = '[R]eset buffer' })

        -- Diffing
        map('n', '<leader>gd', gitsigns.diffthis, { desc = '[D]iff against head' })
        map('n', '<leader>gD', function()
          gitsigns.diffthis '~'
        end, { desc = '[D]iff against previous commit' })

        -- Blame
        map('n', '<leader>gb', gitsigns.toggle_current_line_blame, { desc = 'Toggle [b]lame' })
        map('n', '<leader>gB', function()
          gitsigns.blame_line { full = true }
        end, { desc = 'Show [b]lame' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Git [h]unk' })
      end,
    },
  },
  {
    'kdheepak/lazygit.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<leader>gl', ':LazyGit<cr>', desc = 'LazyGit' },
    },
  },
  {
    'akinsho/git-conflict.nvim',
    version = '*',
    dependencies = {
      'Mofiqul/dracula.nvim',
    },
    init = function()
      local colors = require('dracula').colors()
      vim.api.nvim_set_hl(
        0,
        'GitConflictIncomingLabel',
        { fg = colors.bg, bg = colors.bright_green, bold = true, italic = true }
      )
      vim.api.nvim_set_hl(0, 'GitConflictIncoming', { fg = colors.green })
      vim.api.nvim_set_hl(0, 'GitConflictCurrent', { fg = colors.red })
      vim.api.nvim_set_hl(
        0,
        'GitConflictCurrentLabel',
        { fg = colors.bg, bg = colors.bright_red, bold = true, italic = true }
      )
    end,
    opts = true,
  },
}
