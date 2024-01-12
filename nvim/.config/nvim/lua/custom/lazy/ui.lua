return {
  {
    "petertriho/nvim-scrollbar",
    dependencies = {
      "lewis6991/gitsigns.nvim"
    },
    config = function()
      require("scrollbar").setup({
        handlers = {
          cursor = false,
          diagnostic = true,
          gitsigns = true, -- Requires gitsigns
          handle = true,
          search = false,  -- Requires hlslens
        },
      })
    end
  },
  {
    "akinsho/bufferline.nvim",
    config = function()
      vim.opt.termguicolors = true
      require("bufferline").setup()
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }
      map("n", "<Leader>n", "<Cmd>:BufferLineCycleNext<CR>", opts)
      map("n", "<Leader>p", "<Cmd>:BufferLineCyclePrev<CR>", opts)
      map("n", "<c-n>", "<Cmd>:BufferLineMoveNext<CR>", opts)
      map("n", "<c-p>", "<Cmd>:BufferLineMovePrev<CR>", opts)
      map("n", "<Leader>bp", "<Cmd>:BufferLineTogglePin<CR>", opts)
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = true,
      },
      extensions = {
        "trouble",
        "nvim-tree",
        "mason",
        "lazy",
        "nvim-dap-ui",
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
