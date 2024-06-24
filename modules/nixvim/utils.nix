{ lib, ... }: {
  setTabstopForFiletypes = { filetypes, augroup ? "TabstopForFiletypes" }:
    lib.attrsets.mapAttrsToList (lang: tabstop: {
      group = augroup;
      event = "Filetype";
      callback = {
        __raw = ''
          function() 
            vim.opt_local.tabstop = ${toString tabstop} 
          end
        '';
      };
      pattern = [ lang ];
    }) filetypes;
}
