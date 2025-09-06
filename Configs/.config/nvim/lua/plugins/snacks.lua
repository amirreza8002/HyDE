return {
  "folke/snacks.nvim",
  ---@type LazySpec
  opts = {
    picker = {
      sources = {
        explorer = {
          win = {
            list = {
              keys = {
                ["A"] = "explorer_add_dotnet",
              },
            },
          },
          actions = {
            explorer_add_dotnet = function(picker)
              local dir = picker:dir()
              local easydotnet = require "easy-dotnet"

              easydotnet.create_new_item(dir, function(item_path)
                local tree = require "snacks.explorer.tree"
                local actions = require "snacks.explorer.actions"
                tree:open(dir)
                tree:refresh(dir)
                actions.update(picker, { target = item_path })
                picker:focus()
              end)
            end,
          },
        },
      },
    },
  },
}
