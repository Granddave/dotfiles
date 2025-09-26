return {
  {
    "akinsho/bufferline.nvim",
    lazy = false,
    opts = {},
    keys = {
      { "<Leader>n",  function() require("bufferline").cycle(1) end,     desc = "Next buffer" },
      { "<Leader>p",  function() require("bufferline").cycle(-1) end,    desc = "Previous buffer" },
      { "<c-n>",      function() require("bufferline").move(1) end,      desc = "Move buffer next" },
      { "<c-p>",      function() require("bufferline").move(-1) end,     desc = "Move buffer previous" },
      { "<Leader>bp", function() require("bufferline").toggle_pin() end, desc = "Toggle pin buffer" },
    }
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
      },
      extensions = {
        "lazy",
        "man",
        "mason",
        "nvim-dap-ui",
        "nvim-tree",
        "quickfix",
        "trouble",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          {
            "filename",
            path = 1 -- Relative filepath
          }
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = { -- Use bufferline instead
        -- lualine_a = {
        --   {
        --     'buffers',
        --     symbols = {
        --       alternate_file = '',
        --       modified = ' ',
        --     },
        --   }
        -- },
        -- lualine_b = {},
        -- lualine_c = {},
        -- lualine_x = {},
        -- lualine_y = {},
        -- lualine_z = { 'tabs' }
      },
    },
  },
}
