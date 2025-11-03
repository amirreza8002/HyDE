--- @type LazySpec
return {
  "GustavEikaas/easy-dotnet.nvim",
  -- 'nvim-telescope/telescope.nvim' or 'ibhagwan/fzf-lua' or 'folke/snacks.nvim'
  -- are highly recommended for a better experience
  dependencies = { "nvim-lua/plenary.nvim", "folke/snacks.nvim" },
  config = function()
    local function get_secret_path(secret_guid)
      local path = ""
      local home_dir = vim.fn.expand "~"
      local secret_path = home_dir .. "/.microsoft/usersecrets/" .. secret_guid .. "/secrets.json"
      path = secret_path
      return path
    end

    local dotnet = require "easy-dotnet"
    -- Options are not required
    dotnet.setup {
      lsp = {
        enabled = true,
        roslynator_enabled = true,
        analyzer_assemblies = {},
        config = {},
      },

      --Optional function to return the path for the dotnet sdk (e.g C:/ProgramFiles/dotnet/sdk/8.0.0)
      -- easy-dotnet will resolve the path automatically if this argument is omitted, for a performance improvement you can add a function that returns a hardcoded string
      -- You should define this function to return a hardcoded path for a performance improvement 🚀
      ---@type TestRunnerOptions
      test_runner = {
        ---@type "split" | "vsplit" | "float" | "buf"
        viewmode = "float",
        ---@type number|nil
        vsplit_width = nil,
        ---@type string|nil "topleft" | "topright"
        vsplit_pos = nil,
        enable_buffer_test_execution = true, --Experimental, run tests directly from buffer
        noBuild = true,
        icons = {
          passed = "",
          skipped = "",
          failed = "",
          success = "",
          reload = "",
          test = "",
          sln = "󰘐",
          project = "󰘐",
          dir = "",
          package = "",
        },
        mappings = {
          run_test_from_buffer = { lhs = "<leader>drb", desc = "run test from buffer" },
          filter_failed_tests = { lhs = "<leader>fe", desc = "filter failed tests" },
          debug_test = { lhs = "<leader>dt", desc = "debug test" },
          debug_test_from_buffer = { lhs = "<leader>dtb", desc = "run test from buffer" },
          go_to_file = { lhs = "g", desc = "go to file" },
          run_all = { lhs = "<leader>dR", desc = "run all tests" },
          run = { lhs = "<leader>dr", desc = "run test" },
          peek_stacktrace = { lhs = "<leader>p", desc = "peek stacktrace of failed test" },
          expand = { lhs = "o", desc = "expand" },
          expand_node = { lhs = "E", desc = "expand node" },
          expand_all = { lhs = "-", desc = "expand all" },
          collapse_all = { lhs = "W", desc = "collapse all" },
          close = { lhs = "q", desc = "close testrunner" },
          refresh_testrunner = { lhs = "<C-r>", desc = "refresh testrunner" },
        },
        --- Optional table of extra args e.g "--blame crash"
        additional_args = {},
      },
      new = {
        project = {
          prefix = "sln", -- "sln" | "none"
        },
      },
      ---@param action "test" | "restore" | "build" | "run"
      terminal = function(path, action, args)
        args = args or ""
        local commands = {
          run = function() return string.format("dotnet run --project %s %s", path, args) end,
          test = function() return string.format("dotnet test %s %s", path, args) end,
          restore = function() return string.format("dotnet restore %s %s", path, args) end,
          build = function() return string.format("dotnet build %s %s", path, args) end,
          watch = function() return string.format("dotnet watch --project %s %s", path, args) end,
        }
        local command = commands[action]()
        vim.cmd "vsplit"
        vim.cmd("term " .. command)
      end,
      secrets = {
        path = get_secret_path,
      },
      csproj_mappings = true,
      fsproj_mappings = true,
      auto_bootstrap_namespace = {
        --block_scoped, file_scoped
        type = "block_scoped",
        enabled = true,
        use_clipboard_json = {
          behavior = "prompt", --'auto' | 'prompt' | 'never',
          register = "+", -- which register to check
        },
      },
      server = {
        ---@type nil | "Off" | "Critical" | "Error" | "Warning" | "Information" | "Verbose" | "All"
        log_level = nil,
      },
      -- choose which picker to use with the plugin
      -- possible values are "telescope" | "fzf" | "snacks" | "basic"
      -- if no picker is specified, the plugin will determine
      -- the available one automatically with this priority:
      -- telescope -> fzf -> snacks ->  basic
      picker = "snacks",
      background_scanning = true,
      notifications = {
        --Set this to false if you have configured lualine to avoid double logging
        handler = function(start_event)
          local spinner = require("easy-dotnet.ui-modules.spinner").new()
          spinner:start_spinner(start_event.job.name)
          ---@param finished_event JobEvent
          return function(finished_event) spinner:stop_spinner(finished_event.result.text, finished_event.result.level) end
        end,
      },
      debugger = {
        bin_path = "/home/amirreza/.local/share/nvim/mason/packages/netcoredbg/netcoredbg",
        mappings = {
          open_variable_viewer = { lhs = "T", desc = "open variable viewer" },
        },
      },
      diagnostics = {
        default_severity = "error",
        setqflist = false,
      },
    }

    -- Example command
    vim.api.nvim_create_user_command("Secrets", function() dotnet.secrets() end, {})
  end,
  specs = {
    {
      "Saghen/blink.cmp",
      opts = {
        sources = {
          default = { "easy-dotnet" },
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
    },
  },
}
