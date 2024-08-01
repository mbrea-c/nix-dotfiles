{ ... }:
let
  desc = d: { desc = d; };
  lua = l: { __raw = l; };
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
      key = "<leader>f";
      action = lua "vim.lsp.buf.format";
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
      action = lua "vim.lsp.buf.references";
      options = desc "References";
    }
    {
      mode = [ "n" ];
      key = "<leader>e";
      action = lua "vim.diagnostic.open_float";
      options = desc "Open diagnostics float";
    }

    # Aerial (outline)
    {
      mode = [ "n" ];
      key = "<leader>a";
      action = "<cmd>AerialToggle!<CR>";
      options = desc "Toggle Aerial overview";
    }
  ];
}
