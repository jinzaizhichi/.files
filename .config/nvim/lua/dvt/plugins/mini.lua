return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup {
      mappings = {
        goto_left = nil,
        goto_right = nil,
      },
      n_lines = 500,
      search_method = 'cover_or_nearest',
    }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup {
      -- Use Ctrl-s for all things surround
      mappings = {
        add = '<C-s>a',
        delete = '<C-s>d',
        find = '<C-s>f',
        find_left = '<C-s>F',
        highlight = '<C-s>h',
        replace = '<C-s>r',
        update_n_lines = '<C-s>n',
      },
      -- 1 second long duration
      highlight_duration = 1000,
      search_method = 'cover_or_nearest',
    }

    local function statuslineActive()
      local section_fileinfo = function(args)
        local filetype = vim.bo.filetype

        -- Don't show anything if there is no filetype
        if filetype == '' then
          return ''
        end

        -- Add filetype icon
        -- Try falling back to 'nvim-web-devicons'
        local has_devicons, devicons = pcall(require, 'nvim-web-devicons')
        if not has_devicons then
          return
        end
        local get_icon = function()
          return (devicons.get_icon(vim.fn.expand '%:t', nil, { default = true }))
        end
        filetype = get_icon() .. ' ' .. filetype

        -- Construct output string if truncated or buffer is not normal
        if MiniStatusline.is_truncated(args.trunc_width) or vim.bo.buftype ~= '' then
          return filetype
        end

        local get_filesize = function()
          local size = vim.fn.getfsize(vim.fn.getreg '%')
          if size < 1024 then
            return string.format('%dB', size)
          elseif size < 1048576 then
            return string.format('%.2fKB', size / 1024)
          else
            return string.format('%.2fMB', size / 1048576)
          end
        end

        -- Construct output string with extra file info
        local size = get_filesize()

        return string.format('%s %s', filetype, size)
      end

      local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
      local git = MiniStatusline.section_git { trunc_width = 40 }
      local diff = MiniStatusline.section_diff { trunc_width = 75 }
      local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
      local lsp = MiniStatusline.section_lsp { trunc_width = 75 }
      local filename = MiniStatusline.section_filename { trunc_width = 140 }

      local fileinfo = section_fileinfo { trunc_width = 120 }
      local location = '%2l:%-2v'
      local search = MiniStatusline.section_searchcount { trunc_width = 75 }

      local combine_groups = function(groups)
        local parts = vim.tbl_map(function(s)
          if type(s) == 'string' then
            return s
          end
          if type(s) ~= 'table' then
            return ''
          end

          local string_arr = vim.tbl_filter(function(x)
            return type(x) == 'string' and x ~= ''
          end, s.strings or {})
          local str = table.concat(string_arr, ' ')

          -- Use previous highlight group
          if s.hl == nil then
            return ' ' .. str .. ' '
          end

          -- Allow using this highlight group later
          if str:len() == 0 then
            return '%#' .. s.hl .. '#'
          end

          return string.format('%%#%s#%s', s.hl, str)
        end, groups)

        return table.concat(parts, '')
      end

      local invertHighlightGroup = function(hl_name, hl_colors)
        local hl_name_inverted = hl_name .. 'Invert'

        if hl_colors.reverse then
          vim.api.nvim_set_hl(0, hl_name_inverted, {})
        elseif hl_colors.bg and not hl_colors.fg then
          vim.api.nvim_set_hl(0, hl_name_inverted, { fg = hl_colors.bg, bg = 'bg' })
        elseif hl_colors.fg and not hl_colors.bg then
          vim.api.nvim_set_hl(0, hl_name_inverted, { fg = 'bg', bg = 'bg' })
        else
          vim.api.nvim_set_hl(0, hl_name_inverted, { fg = hl_colors.bg, bg = 'bg' })
        end
        return hl_name_inverted
      end

      -- Invert colors
      local mode_hl_colors = vim.api.nvim_get_hl(0, { name = mode_hl, link = false })
      local mode_hl_invert = invertHighlightGroup(mode_hl, mode_hl_colors)

      local dev_hl_colors = vim.api.nvim_get_hl(0, { name = 'MiniStatuslineDevinfo', link = false })
      local dev_hl_invert = invertHighlightGroup('MiniStatuslineDevinfo', dev_hl_colors)

      return combine_groups {
        { hl = mode_hl_invert, strings = { '' } },
        { hl = mode_hl, strings = { mode } },
        { hl = mode_hl_invert, strings = { '' } },
        ' ',
        { hl = dev_hl_invert, strings = { '' } },
        { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
        { hl = dev_hl_invert, strings = { '' } },
        '%<', -- Mark general truncate point
        ' ',
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=', -- End left alignment
        { hl = dev_hl_invert, strings = { '' } },
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = dev_hl_invert, strings = { '' } },
        ' ',
        { hl = mode_hl_invert, strings = { '' } },
        { hl = mode_hl, strings = { search, location } },
        { hl = mode_hl_invert, strings = { '' } },
      }
    end

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require 'mini.statusline'
    -- set use_icons to true if you have a Nerd Font
    statusline.setup { content = { active = statuslineActive }, use_icons = true }

    -- DVT additions
    -- Comment out lines using Ctrl-/ since I'm used to it from Jetbrains
    require('mini.comment').setup {
      mappings = {
        comment = '',
        comment_line = '<C-/>',
        comment_visual = '<C-/>',
        textobject = '<C-/>',
      },
    }

    local starter = require 'mini.starter'
    starter.setup {
      items = {
        starter.sections.recent_files(10, false, false),
        starter.sections.telescope(),
        starter.sections.builtin_actions(),
      },
      content_hooks = {
        starter.gen_hook.adding_bullet '┃ ',
        starter.gen_hook.aligning('center', 'center'),
      },
    }

    require('mini.jump').setup {
      delay = {
        highlight = -1,
      },
    }
  end,
}
