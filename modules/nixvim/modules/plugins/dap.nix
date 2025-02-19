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
  };
}
