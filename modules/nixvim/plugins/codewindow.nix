{ ... }:
{
  plugins = {
    codewindow = {
      enable = true;
      settings = {

        events = [
          "TextChanged"
          "InsertLeave"
          "DiagnosticChanged"
          "FileWritePost"
          "VimResized"
        ];
      };
    };
  };
  keymaps = [
    {
      action.__raw = ''require("codewindow").toggle_minimap'';
      key = "<leader>m";
      options = {
        desc = "Toggle minimap";
      };
    }
  ];
}
