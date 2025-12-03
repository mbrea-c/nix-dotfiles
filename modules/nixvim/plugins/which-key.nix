{ lib, config, ... }: {
  options = {
    custom.which-key.spec = lib.mkOption {
      type = with lib.types; listOf (attrsOf anything);
      default = [ ];
      description = "Configuration for which-key.settings.spec";
    };
  };
  config = {
    plugins = {
      which-key = {
        enable = true;
        settings = { spec = config.custom.which-key.spec; };
      };
    };
  };
}
