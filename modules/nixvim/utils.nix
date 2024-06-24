{ lib, ... }: {
  setTabstopForFiletypes = { filetypes, augroup ? "TabstopForFiletypes" }:
    lib.attrsets.mapAttrsToList (lang: tabstop: {
      group = augroup;
      event = "Filetype";
      callback = ''
        function() 
          vim.opt_local.tabstop = ${toString tabstop} 
        end
      '';
      pattern = [ lang ];
    }) filetypes;
}
