return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "LazyFile",
    opts = {
      indent = {
        char = "│",
        -- char = "▏",
        -- char = "▕",
        tab_char = "│",
        -- tab_char = "▏",
        -- tab_char = "▕",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
          "starter",
        },
      },
    },
  },

  {
    "echasnovski/mini.indentscope",
    event = "LazyFile",
    opts = {
      -- symbol = "▏",
      -- symbol = "▕",
      symbol = "│",
      options = { try_as_border = true },
    },
  },
}
