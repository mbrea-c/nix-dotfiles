{ ... }:
{
  plugins.noice = {
    enable = true;

    settings = {
      cmdline.enabled = false;
      popupmenu.enabled = false;
      messages.enabled = false;

      lsp = {
        progress.enabled = false;
        hover.enabled = false;
        signature.enabled = false;
        message.enabled = false;
      };

      views.confirm = {
        backend = "popup";
        relative = "editor";
        position = {
          row = "50%";
          col = "50%";
        };
        size = {
          width = 60;
          height = "auto";
        };
        border = {
          style = "rounded";
        };
      };

      routes = [
        {
          filter.event = "confirm";
          view = "confirm";
        }
        {
          filter = { };
          opts.skip = true;
        }
      ];
    };
  };
}
