return {
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#181825",
    },
  },

  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      local logo = [[
╔══╗╔══╗╔═════╗╔══════██╗   ██╗██╗██╗╔═══╗╔═══╗
║  \║  ║║  ╔══╝║  ╔═╗ ██║   ██║██║██║║   \/   ║
║   \  ║║  ╚══╗║  ║ ║ ██║   ██║██║██║║  \  /  ║
║  \   ║║  ╔══╝║  ║ ║ ╚██╗ ██╔╝██║██║║  ║\/║  ║
║  ║\  ║║  ╚══╗║  ╚═╝  ║████╔╝ ██║██║║  ║  ║  ║
╚══╝╚══╝╚═════╝╚═══════╝╚═══╝  ╚═╝╚═╝╚══╝  ╚══╝
      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
          -- stylua: ignore
          center = {
            { action = "Telescope find_files",                                     desc = " Find file",       icon = " ", key = "f" },
            { action = "ene | startinsert",                                        desc = " New file",        icon = " ", key = "n" },
            { action = "Telescope oldfiles",                                       desc = " Recent files",    icon = " ", key = "r" },
            { action = "Telescope live_grep",                                      desc = " Find text",       icon = " ", key = "g" },
            { action = [[lua require("lazyvim.util").telescope.config_files()()]], desc = " Config",          icon = " ", key = "c" },
            { action = 'lua require("persistence").load()',                        desc = " Restore Session", icon = " ", key = "s" },
            { action = "LazyExtras",                                               desc = " Lazy Extras",     icon = " ", key = "x" },
            { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
            { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
  },
  { "goolord/alpha-nvim", enabled = false },
  { "nvimdev/dashboard-nvim", enabled = false },

  -- enable mini.starter
  {
    "echasnovski/mini.starter",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "VimEnter",
    opts = function()
      local logo = [[
   ╔══╗╔══╗╔═════╗╔══════██╗   ██╗██╗██╗╔═══╗╔═══╗
   ║  \║  ║║  ╔══╝║  ╔═╗ ██║   ██║██║██║║   \/   ║
   ║   \  ║║  ╚══╗║  ║ ║ ██║   ██║██║██║║  \  /  ║
   ║  \   ║║  ╔══╝║  ║ ║ ╚██╗ ██╔╝██║██║║  ║\/║  ║
   ║  ║\  ║║  ╚══╗║  ╚═╝  ║████╔╝ ██║██║║  ║  ║  ║
   ╚══╝╚══╝╚═════╝╚═══════╝╚═══╝  ╚═╝╚═╝╚══╝  ╚══╝
]]
      local pad = string.rep(" ", 20)
      local new_section = function(name, action, section)
        return { name = name, action = action, section = pad .. section }
      end

      local starter = require("mini.starter")
      --stylua: ignore
      local config = {
        evaluate_single = true,
        header = logo,
        items = {
          new_section("Find file",       "Telescope find_files",                                   "Telescope"),
          new_section("Recent files",    "Telescope oldfiles",                                     "Telescope"),
          new_section("Grep text",       "Telescope live_grep",                                    "Telescope"),
          new_section("Config",          "lua require('lazyvim.util').telescope.config_files()()", "Config"),
          new_section("Extras",          "LazyExtras",                                             "Config"),
          new_section("Lazy",            "Lazy",                                                   "Config"),
          new_section("New file",        "ene | startinsert",                                      "Built-in"),
          new_section("Quit",            "qa",                                                     "Built-in"),
          new_section("Session restore", [[lua require("persistence").load()]],                    "Session"),
        },
        content_hooks = {
          starter.gen_hook.adding_bullet(pad .. "░ ", false),
          starter.gen_hook.aligning("center", "center"),
        },
      }
      return config
    end,
    config = function(_, config)
      -- close Lazy and re-open when starter is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "MiniStarterOpened",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      local starter = require("mini.starter")
      starter.setup(config)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          local pad_footer = string.rep(" ", 8)
          starter.config.footer = pad_footer .. "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(starter.refresh)
        end,
      })
    end,
  },
}
