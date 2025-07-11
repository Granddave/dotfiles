return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "gd",         "<Cmd>ObsidianFollowLink<CR>", desc = "Follow link" },
    { "<Leader>ob", "<Cmd>ObsidianBacklinks<CR>",  desc = "Show backlinks" },
    { "<Leader>od", "<Cmd>ObsidianToday<CR>",      desc = "Go to today's file" },
    { "<Leader>ot", "<Cmd>ObsidianTemplate<CR>",   desc = "Insert template" },
  },
  opts = {
    workspaces = {
      {
        name = "life",
        path = "~/sync/Life",
      },
    },

    daily_notes = {
      -- folder = "Daily",
      date_format = "%Y-%m-%d"
    },

    templates = {
      subdir = "Templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      -- A map for custom variables, the key should be the variable and the value a function
      substitutions = {},
    },

    -- Where to put new notes created from completion. Valid options are
    --  * "current_dir" - put new notes in same directory as the current buffer.
    --  * "notes_subdir" - put new notes in the default notes subdirectory.
    new_notes_location = "current_dir",

    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },

    -- Where to put new notes created from completion. Valid options are
    --  * "current_dir" - put new notes in same directory as the current buffer.
    --  * "notes_subdir" - put new notes in the default notes subdirectory.
    new_notes_location = "current_dir",

    -- Disable the default mappings
    mappings = {},
    ui = {
      enable = true,
      checkboxes = {
        [" "] = { char = "☐", hl_group = "ObsidianTodo" },
        ["x"] = { char = "✔", hl_group = "ObsidianDone" },
        [">"] = { char = "", hl_group = "ObsidianRightArrow" },
        ["~"] = { char = "~", hl_group = "ObsidianTilde" },
      },
      external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
    },

    disable_frontmatter = true,
    note_frontmatter_func = function(note)
      -- This is equivalent to the default frontmatter function.
      local out = { id = note.id, aliases = note.aliases, tags = note.tags }
      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end
      return out
    end,

    -- Optional, customize how names/IDs for new notes are created.
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. "-" .. suffix
    end,

    -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
    -- URL it will be ignored but you can customize this behavior here.
    follow_url_func = function(url)
      vim.fn.jobstart({ "xdg-open", url })
    end,

    -- Optional, set to true if you use the Obsidian Advanced URI plugin.
    -- https://github.com/Vinzent03/obsidian-advanced-uri
    use_advanced_uri = true,

    -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
    open_app_foreground = false,

    -- -- Optional, by default commands like `:ObsidianSearch` will attempt to use
    -- -- telescope.nvim, fzf-lua, and fzf.nvim (in that order), and use the
    -- -- first one they find. By setting this option to your preferred
    -- -- finder you can attempt it first. Note that if the specified finder
    -- -- is not installed, or if it the command does not support it, the
    -- -- remaining finders will be attempted in the original order.
    -- finder = "telescope.nvim",
  },
}
