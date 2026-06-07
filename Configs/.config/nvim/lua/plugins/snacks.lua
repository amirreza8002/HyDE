return {
  "folke/snacks.nvim",
  ---@type snacks.Config
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
              easydotnet.create_item(dir)
            end,
          },
        },
      },
    },
  },
}
