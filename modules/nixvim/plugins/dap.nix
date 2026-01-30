{ pkgs, lib, ... }:
let
  lldb-config = {
    name = "Launch (LLDB)";
    type = "lldb";
    request = "launch";
    program.__raw = ''
      function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. '/', "file")
      end'';
    cwd = "\${workspaceFolder}";
    stopOnEntry = false;
  };

  lldb-config-animedit = {
    name = "Debug bevy animation graph editor (LLDB)";
    type = "lldb";
    request = "launch";
    program = "target/debug/bevy_animation_graph_editor";
    cwd = "\${workspaceFolder}";
    stopOnEntry = false;
    args = [
      "--asset-source"
      "assets"
    ];
    initCommands.__raw = ''
      function()
        -- Find out where to look for the pretty printer Python module.
        local rustc_sysroot = vim.fn.trim(vim.fn.system 'rustc --print sysroot')
        assert(
          vim.v.shell_error == 0,
          'failed to get rust sysroot using `rustc --print sysroot`: '
            .. rustc_sysroot
        )
        local script_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py'
        local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

        -- The following is a table/list of lldb commands, which have a syntax
        -- similar to shell commands.
        --
        -- To see which command options are supported, you can run these commands
        -- in a shell:
        --
        --   * lldb --batch -o 'help command script import'
        --   * lldb --batch -o 'help command source'
        --
        -- Commands prefixed with `?` are quiet on success (nothing is written to
        -- debugger console if the command succeeds).
        --
        -- Prefixing a command with `!` enables error checking (if a command
        -- prefixed with `!` fails, subsequent commands will not be run).
        --
        -- NOTE: it is possible to put these commands inside the ~/.lldbinit
        -- config file instead, which would enable rust types globally for ALL
        -- lldb sessions (i.e. including those run outside of nvim). However,
        -- that may lead to conflicts when debugging other languages, as the type
        -- formatters are merely regex-matched against type names. Also note that
        -- .lldbinit doesn't support the `!` and `?` prefix shorthands.
        return {
          ([[!command script import '%s']]):format(script_file),
          ([[command source '%s']]):format(commands_file),
        }
      end
    '';
  };

  sh-config = {
    type = "bashdb";
    request = "launch";
    name = "Launch (BashDB)";
    showDebugOutput = true;
    pathBashdb = "${lib.getExe pkgs.bashdb}";
    pathBashdbLib = "${pkgs.bashdb}/share/basdhb/lib/";
    trace = true;
    file = "\${file}";
    program = "\${file}";
    cwd = "\${workspaceFolder}";
    pathCat = "cat";
    pathBash = "${lib.getExe pkgs.bash}";
    pathMkfifo = "mkfifo";
    pathPkill = "pkill";
    args = { };
    env = { };
    terminalKind = "integrated";
  };
in
{
  extraPackages = [
    # pkgs.bashdb
  ];
  plugins = {
    dap = {
      enable = true;
      adapters = {
        executables = {
          # bashdb = { command = lib.getExe pkgs.bashdb; };
          lldb = {
            command = lib.getExe' pkgs.lldb "lldb-dap";
          };
        };
      };
      configurations = {
        sh = [
          # sh-config
        ];
        rust = [
          lldb-config
          lldb-config-animedit
        ];

        # kotlin = [{
        #   type = "kotlin";
        #   request = "launch";
        #   name = "This file";
        #   mainClass = lua # lua
        #     ''
        #       function()
        #           local root = vim.fs.find("src", { path = vim.uv.cwd(), upward = true, stop = vim.env.HOME })[1] or ""
        #           local fname = vim.api.nvim_buf_get_name(0)
        #           -- src/main/kotlin/websearch/Main.kt -> websearch.MainKt
        #           return fname:gsub(root, ""):gsub("main/kotlin/", ""):gsub(".kt", "Kt"):gsub("/", "."):sub(2, -1)
        #       end
        #     '';
        #   projectRoot = "\${workspaceFolder}";
        #   jsonLogFile = "";
        #   enableJsonLogging = false;
        # }];
      };
    };
    dap-view = {
      enable = true;
      settings = {
        winbar = {
          controls = {
            enabled = true;
          };
        };
      };
    };
    dap-virtual-text = {
      enable = true;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>db";
      action.__raw = ''
        function()
          require("dap").toggle_breakpoint()
        end
      '';
      options = {
        desc = "Breakpoint toggle";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>dc";
      action.__raw = ''
        function()
          require("dap").continue()
        end
      '';
      options = {
        desc = "Continue Debugging (Start)";
        silent = true;
      };
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>de";
      action.__raw = ''
        function() require("dap-view").add_expr() end
      '';
      options = {
        desc = "Evaluate Input";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>dE";
      action.__raw = ''
        function()
          vim.ui.input({ prompt = "Expression: " }, function(expr)
            if expr then require("dap-view").add_expr(expr) end
          end)
        end
      '';
      options = {
        desc = "Evaluate Input";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>dh";
      action.__raw = ''
        function() require("dap.ui.widgets").hover() end
      '';
      options = {
        desc = "Debugger Hover";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>do";
      action.__raw = ''
        function()
          require("dap").step_out()
        end
      '';
      options = {
        desc = "Step Out";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>ds";
      action.__raw = ''
        function()
          require("dap").step_over()
        end
      '';
      options = {
        desc = "Step Over";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>dS";
      action.__raw = ''
        function()
          require("dap").step_into()
        end
      '';
      options = {
        desc = "Step Into";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>dt";
      action.__raw = ''
        function() require("dap").terminate() end
      '';
      options = {
        desc = "Terminate Debugging";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>du";
      action.__raw = ''
        function()
          require('dap.ext.vscode').load_launchjs(nil, {})
          require("dap-view").toggle()
        end
      '';
      options = {
        desc = "Toggle Debugger UI";
        silent = true;
      };
    }
  ];
}
