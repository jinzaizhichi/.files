return {
  'saghen/blink.cmp',
  lazy = false, -- lazy loading handled internally
  dependencies = 'rafamadriz/friendly-snippets',
  version = 'v0.*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      ['<C-CR>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-h>'] = { 'hide' },
      ['<CR>'] = { 'select_and_accept', 'fallback' },
      ['<UP>'] = { 'select_prev', 'snippet_backward', 'fallback' },
      ['<DOWN>'] = { 'select_next', 'snippet_forward', 'fallback' },
      ['C-u'] = { 'scroll_documentation_up', 'fallback' },
      ['C-d'] = { 'scroll_documentation_down', 'fallback' },
    },

    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 0,
        update_delay_ms = 0,
      },
    },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    -- default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, via `opts_extend`
    sources = {
      completion = {
        enabled_providers = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    },

    -- experimental auto-brackets support
    -- completion = { accept = { auto_brackets = { enabled = true } } }

    -- experimental signature help support
    signature = {
      enabled = true,
    },
  },
  -- allows extending the enabled_providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = { 'sources.completion.enabled_providers' },
}
