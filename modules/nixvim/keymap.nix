{ config, ... }:
let
  desc = d: { desc = d; };
  lua = l: { __raw = l; };
  lu = (import ../../utils/lua-utils.nix) { };
  formatWithFilter = lst: lua (lu.fns.lspFormatFiltered lst);
in {
  keymaps = [
    {
      key = "<C-n>";
      action = "<cmd>NvimTreeToggle<CR>";
    }
    {
      key = "<C-h>";
      action = "<cmd>Inspect<CR>";
    }
    {
      key = "<C-t>";
      action = "<cmd>ToggleTerm<CR>";
      mode = [ "n" "t" ];
    }

    # LSP stuff
    {
      mode = [ "n" "v" ];
      key = "<leader>f";
      action = formatWithFilter [ "kotlin_language_server" "jdtls" ];
      options = desc "Format buffer (5s timeout)";
    }
    {
      mode = [ "n" ];
      key = "gD";
      action = lua "vim.lsp.buf.declaration";
      options = desc "Go to declaration";
    }
    {
      mode = [ "n" ];
      key = "gd";
      action = lua "vim.lsp.buf.definition";
      options = desc "Go to definition";
    }
    {
      mode = [ "n" ];
      key = "gT";
      action = lua "vim.lsp.buf.type_definition";
      options = desc "Go to type definition";
    }
    {
      mode = [ "n" ];
      key = "K";
      action = lua # lua
        ''
          function()
            vim.lsp.buf.hover({
              border = ${lu.nixToLua config.custom.border}
            })
          end
        '';
      options = desc "Hover";
    }
    {
      mode = [ "n" ];
      key = "gi";
      action = lua "vim.lsp.buf.implementation";
      options = desc "Go to implementation";
    }
    {
      mode = [ "n" "i" ];
      key = "<C-k>";
      action = lua "vim.lsp.buf.signature_help";
      options = desc "Signature help";
    }
    {
      mode = [ "n" ];
      key = "<leader>rn";
      action = lua "vim.lsp.buf.rename";
      options = desc "Rename";
    }
    {
      mode = [ "n" ];
      key = "<leader>ca";
      action = lua "vim.lsp.buf.code_action";
      options = desc "Code actions";
    }
    {
      mode = [ "n" ];
      key = "gr";
      action = "<cmd>Telescope lsp_references<CR>";
      options = desc "References";
    }
    {
      mode = [ "n" ];
      key = "<leader>e";
      action = lua # lua
        ''
          function()
            local current_config = vim.diagnostic.config()
            local new_lines = nil
            if current_config.virtual_lines == nil or current_config.virtual_lines == false then
              new_lines = true
            else
              new_lines = false
            end
            vim.diagnostic.config({virtual_lines = new_lines})
          end
        '';
      options = desc "Open diagnostics float";
    }
    {
      mode = [ "n" ];
      key = "<leader>[";
      action = lua "vim.diagnostic.goto_prev";
      options = desc "Go to previous diagnostic";
    }
    {
      mode = [ "n" ];
      key = "<leader>]";
      action = lua "vim.diagnostic.goto_next";
      options = desc "Go to next diagnostic";
    }
    {
      mode = [ "n" ];
      key = "<leader>i";
      action = lua # lua
        ''
          function() 
            vim.lsp.inlay_hint.enable(
              not vim.lsp.inlay_hint.is_enabled()
            ) 
          end
        '';
      options = desc "Toggle inlay hints";
    }

    # Git stuff
    {
      mode = [ "n" ];
      key = "<leader>gb";
      action = "<cmd>Gitsigns blame<CR>";
      options = desc "Open git blame sidebar";
    }
    {
      mode = [ "n" ];
      key = "<leader>gdc";
      action = lua # lua
        ''
          function()
            vim.ui.input({prompt = "Commit hash:"}, function(input)
              vim.cmd("DiffviewOpen " .. input .. "^!")
            end)
          end
        ''

      ;
      options = desc "Open the provided commit hash in Diffview";
    }

    # Aerial (outline)
    {
      mode = [ "n" ];
      key = "<leader>a";
      action = "<cmd>AerialToggle float<CR>";
      options = desc "Toggle Aerial overview";
    }

    # Telescope
    {
      mode = [ "n" ];
      key = "<leader>tg";
      action = "<cmd>Telescope live_grep_args<CR>";
      options = desc "Live grep in workspace";
    }
    {
      mode = [ "n" ];
      key = "<leader>tf";
      action = "<cmd>Telescope find_files<CR>";
      options = desc "Find files in workspace";
    }

    # Paste in macos
    {
      mode = [ "n" "i" "v" ];
      key = "<D-v>";
      action = ''"+p'';
      options = desc "Paste from system clipboard";
    }
  ];
}
