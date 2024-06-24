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

  setFormatOnSaveForFiletypes = { filetypes, augroupEnabler, augroupFormatter }:
    lib.attrsets.mapAttrsToList (lang: enable: {
      group = augroupEnabler;
      event = "Filetype";
      callback = {
        __raw = if enable then # lua
        ''
          function(ev) 
            local augroup = vim.api.nvim_create_augroup("${augroupFormatter}${lang}" .. ev.buf, { clear = true })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = ev.buf,
              callback = function()
                vim.lsp.buf.format()
              end,
            })
          end
        '' else # lua
        ''
          function(ev)
            vim.api.nvim_clear_autocmds({
              group = "${augroupFormatter}${lang}" .. ev.buf,
            })
          end
        '';
      };
      pattern = [ lang ];
    }) filetypes;
}
