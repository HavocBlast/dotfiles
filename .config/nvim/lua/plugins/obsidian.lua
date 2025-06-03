local notes_path = "~/workspace/github.com/havocblast/notes/"
return{
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  event = {
    "BufReadPre " .. vim.fn.expand "~" .. "/workspace/github.com/havocblast/notes/*.md",
    "BufNewFile " .. vim.fn.expand "~" .. "/workspace/github.com/havocblast/notes/*.md"
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "programming",
        path = notes_path .. "programming",
      },
      {
        name = "learning",
        path = notes_path .. "learning",
      },
    },
  },
}
