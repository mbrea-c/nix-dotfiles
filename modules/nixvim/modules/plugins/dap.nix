{ ... }:
let inherit (import ../../../../utils/lua-utils.nix) lua;
in {
  plugins = {
    dap = {
      enable = true;
      adapters = {
        executables = {
          kotlin = {
            command = "kotlin-debug-adapter";
            options = {
              # TODO: open a nixvim ticket as this option shoulf be supported
              #auto_continue_if_many_stopped = false;
            };
          };
        };
      };
      configurations = {
        kotlin = [{
          type = "kotlin";
          request = "launch";
          name = "This file";
          mainClass = lua # lua
            ''
              function()
                  local root = vim.fs.find("src", { path = vim.uv.cwd(), upward = true, stop = vim.env.HOME })[1] or ""
                  local fname = vim.api.nvim_buf_get_name(0)
                  -- src/main/kotlin/websearch/Main.kt -> websearch.MainKt
                  return fname:gsub(root, ""):gsub("main/kotlin/", ""):gsub(".kt", "Kt"):gsub("/", "."):sub(2, -1)
              end,
            '';
          projectRoot = "\${workspaceFolder}";
          jsonLogFile = "";
          enableJsonLogging = false;
        }];
      };
    };
  };
}
