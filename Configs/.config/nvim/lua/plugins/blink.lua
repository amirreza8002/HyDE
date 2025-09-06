return {
  "saghen/blink.cmp",
  version = "*",
  opt = {
    fuzzy = { implementation = "prefer_rust_with_warning" },
    sources = {
      default = { "lsp", "easy-dotnet", "path" },
      providers = {
        ["easy-dotnet"] = {
          name = "easy-dotnet",
          enabled = true,
          module = "easy-dotnet.completion.blink",
          score_offset = 10000,
          async = true,
        },
      },
    },
  },
}
