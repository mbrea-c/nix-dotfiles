{ lib, ... }: {
  setTabstopForFiletypes = ftypes:
    lib.attrsets.mapAttrsToList (lang: tabstop: {
      group = "TabstopForFiletypes";
      event = "Filetype";
      callback = ''
        function() 
          vim.opt_local.tabstop = ${toString tabstop} 
        end
      '';
      pattern = [ lang ];
    }) ftypes;
}
