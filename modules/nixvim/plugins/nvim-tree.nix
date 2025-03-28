{ ... }: {
  plugins = {
    nvim-tree = {
      enable = true;
      renderer = {
        groupEmpty = true;
        highlightOpenedFiles = "all";
        indentMarkers = { enable = true; };
      };
      diagnostics = {
        enable = true;
        showOnDirs = true;
        showOnOpenDirs = false;
      };
      git = {
        enable = true;
        showOnDirs = true;
        showOnOpenDirs = false;
      };
      updateFocusedFile = { enable = true; };
      view = { width = 50; };
      actions = { changeDir = { global = true; }; };
    };
  };
}
