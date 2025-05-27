{ lib, config, inputs, colorscheme, ... }:
let
  utils = (import ./utils.nix) { inherit lib; };
  tabstopsAugroup = "TabstopForFiletypes";
  formattingEnablerAugroup = "FormatOnSaveForFiletypesEnabler";
  formattingFormatterAugroup = "FormatOnSaveForFiletypesFormatter";
  highlightUnderCursorAugroup = "HighlightSymbolUnderCursor";
  highlights = (import ./colorscheme.nix) { inherit lib colorscheme inputs; };
in {
  imports = [ ./plugins.nix ./keymap.nix ./opts.nix ./packages.nix ];

  options = {
    custom.border = with lib;
      mkOption {
        type = types.either types.str (types.listOf types.str);
        # default = "rounded";

        # To look like this:
        # 🬕🬂🬂🬂🬂🬂🬂🬂🬂🬂🬂🬂🬂🬨
        # ▌  Testing   ▐
        # 🬲🬭🬭🬭🬭🬭🬭🬭🬭🬭🬭🬭🬭🬷
        #      vvv
        default = [ "🬕" "🬂" "🬨" "▐" "🬷" "🬭" "🬲" "▌" ];
        description =
          "Border used for nvim_open_win throughout my config (for consistency)";
      };
  };
  config = {

    highlightOverride = highlights;

    autoCmd = utils.setTabstopForFiletypes {
      filetypes = {
        java = 4;
        solidity = 4;
        html = 2;
        javascript = 2;
        javascriptreact = 2;
        typescript = 2;
        json = 2;
        python = 2;
        lua = 2;
        agda = 2;
        markdown = 2;
        latex = 2;
        c = 4;
        cpp = 4;
        nix = 2;
      };
      augroup = tabstopsAugroup;
    } ++ utils.setFormatOnSaveForFiletypes {
      filetypes = {
        nix = true;
        rust = true;
        toml = true;
      };
      augroupEnabler = formattingEnablerAugroup;
      augroupFormatter = formattingFormatterAugroup;
    } ++ [
      {
        # TODO: should this be per-buffer?
        group = highlightUnderCursorAugroup;
        event = [ "CursorHold" "CursorHoldI" ];
        callback = {
          __raw = # lua
            ''
              function(ev) 
                local clients = vim.lsp.get_clients({ bufnr = ev.buf })
                local can_highlight = false

                for _, client in ipairs(clients) do
                  if client.supports_method("textDocument/documentHighlight") then
                    can_highlight = true
                  end
                end

                if can_highlight then
                  vim.lsp.buf.document_highlight()
                end
              end
            '';
        };
      }
      {
        event = [ "ColorScheme" ];
        command = "IBLEnable";
      }
      {
        # TODO: should this be per-buffer?
        group = highlightUnderCursorAugroup;
        event = [ "CursorMoved" ];
        callback = {
          __raw = # lua
            ''
              function(ev) 
                local clients = vim.lsp.get_clients({ bufnr = ev.buf })
                local can_highlight = false

                for _, client in ipairs(clients) do
                  if client.supports_method("textDocument/documentHighlight") then
                    can_highlight = true
                  end
                end

                if can_highlight then
                  vim.lsp.buf.clear_references()
                end
              end
            '';
        };
      }
    ];

    autoGroups = {
      "${tabstopsAugroup}" = { clear = true; };
      "${formattingEnablerAugroup}" = { clear = true; };
      "${formattingFormatterAugroup}" = { clear = true; };
      "${highlightUnderCursorAugroup}" = { clear = true; };
    };

    extraConfigLuaPre = let
      border = config.custom.border;
      lu = (import ../../utils/lua-utils.nix) { };
      # lua
    in ''
      ${builtins.readFile ./configLuaPre.lua}
      local is_in = ${lu.fns.is_in}

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = ${
        lu.nixToLua border
      }})
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = ${
        lu.nixToLua border
      }})

      vim.o.guifont = "monospace:h10"
      vim.g.neovide_floating_blur_amount_x = 5.0
      vim.g.neovide_floating_blur_amount_y = 5.0
    '';
  };
}
