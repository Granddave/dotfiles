return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  lazy = true,
  keys = {
    { "<Leader>aa", function() require("harpoon"):list():add() end,                                    desc = "Add Harpoon Mark" },
    { "<Leader>at", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Toggle Harpoon Menu" },
    { "<Leader>h",  function() require("harpoon"):list():select(1) end,                                desc = "Select Harpoon 1" },
    { "<Leader>j",  function() require("harpoon"):list():select(2) end,                                desc = "Select Harpoon 2" },
    { "<Leader>k",  function() require("harpoon"):list():select(3) end,                                desc = "Select Harpoon 3" },
    { "<Leader>l",  function() require("harpoon"):list():select(4) end,                                desc = "Select Harpoon 4" },
  },
}
