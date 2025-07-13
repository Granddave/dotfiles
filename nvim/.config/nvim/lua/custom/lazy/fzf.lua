return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      winopts = {
        fullscreen = true,
      },
    },
    keys = {
      { "<Leader>tr", function() require("fzf-lua").resume() end,    desc = "Resume FZF" },
      { "<Leader>ff", function() require("fzf-lua").files() end,     desc = "Find Files" },
      { "<Leader>fg", function() require("fzf-lua").git_files() end, desc = "Find Git Files" },
      { "<Leader>fr", function() require("fzf-lua").live_grep() end, desc = "Live Grep" },
      { "<Leader>fb", function() require("fzf-lua").buffers() end,   desc = "Buffers" },
      { "<Leader>fh", function() require("fzf-lua").helptags() end,  desc = "helptags" },
      {
        "<Leader>ss",
        function()
          require("fzf-lua").spell_suggest({
            winopts = {
              backdrop = 100,
              fullscreen = false,
            },
          })
        end,
        desc = "Spell Suggest"
      },
      {
        "<Leader>sft",
        function()
          require("fzf-lua").filetypes({
            winopts = {
              height = 20,
              width = 50,
              fullscreen = false,
            },
          })
        end,
        desc = "Filetypes",
      },
    },
  }
}
