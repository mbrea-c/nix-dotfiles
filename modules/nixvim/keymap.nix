{ ... }:
let
  desc = d: { desc = d; };
  lua = l: { __raw = l; };
  lu = (import ../../utils/lua-utils.nix) { };
  formatWithFilter = filterList: lua (lu.fns.lspFormatFiltered filterList);
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
      action = lua "vim.lsp.buf.hover";
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
      key = "<leader>gr";
      action = "<cmd>Telescope lsp_references<CR>";
      options = desc "References";
    }
    {
      mode = [ "n" ];
      key = "<leader>e";
      action = lua "vim.diagnostic.open_float";
      options = desc "Open diagnostics float";
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

    # Aerial (outline)
    {
      mode = [ "n" ];
      key = "<leader>a";
      action = "<cmd>AerialToggle!<CR>";
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
  ];
}
