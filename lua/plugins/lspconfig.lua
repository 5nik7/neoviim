return {
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim", opts = {} },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        globals = { "vim" },
        underline = true,
      },
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {},
              completion = {},
            },
          },
        },
      },
    },
  },
}
