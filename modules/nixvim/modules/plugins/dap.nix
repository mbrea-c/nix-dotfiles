{ pkgs, lib, ... }:
let inherit ((import ../../../../utils/lua-utils.nix) { }) lua;
in {
  extraPackages = with pkgs; [ bashdb ];

  plugins = {
    dap = {
      enable = true;
      adapters = {
        executables = { bashdb = { command = "${lib.getExe pkgs.bashdb}"; }; };
      };
      configurations = {
        sh = [{
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
        }];

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
    dap-ui = { enable = true; };
    dap-virtual-text = { enable = true; };
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
      mode = "v";
      key = "<leader>de";
      action.__raw = ''
        function() require("dapui").eval() end
      '';
      options = {
        desc = "Evaluate Input";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>de";
      action.__raw = ''
        function()
          vim.ui.input({ prompt = "Expression: " }, function(expr)
            if expr then require("dapui").eval(expr, { enter = true }) end
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
          require("dapui").toggle()
        end
      '';
      options = {
        desc = "Toggle Debugger UI";
        silent = true;
      };
    }
  ];
}
