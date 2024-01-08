return {
  "RRethy/vim-illuminate",
  event = "VeryLazy",
  config = function()
    require("illuminate").configure {
      filetypes_denylist = {
        "mason",
        "harpoon",
        "DressingInput",
        "NeogitCommitMessage",
        "qf",
        "dirvish",
        "minifiles",
        "fugitive",
        "alpha",
        "NvimTree",
        "lazy",
        "NeogitStatus",
        "Trouble",
        "netrw",
        "lir",
        "DiffviewFiles",
        "Outline",
        "Jaq",
        "spectre_panel",
        "toggleterm",
        "DressingSelect",
        "TelescopePrompt",
      },
    }

    vim.cmd [[
      hi! LspReferenceRead cterm=bold ctermbg=Gray guibg=#504945
      hi! LspReferenceText cterm=bold ctermbg=Gray guibg=#504945
      hi! LspReferenceWrite cterm=bold ctermbg=Gray guibg=#504945
    ]]
  end
}
