return {

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
      close_if_last_window = true,
      filesystem = {
        follow_current_file = { enabled = true },
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = true,
      },
    },
  },
}
