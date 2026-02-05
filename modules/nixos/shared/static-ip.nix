{ config, lib, ... }:
{
  imports = [ ];

  options = {
    staticIp = {
      staticIpv4 = lib.mkOption {
        type = lib.types.str;
        default = "192.168.1.42";
      };
      gatewayIpv4 = lib.mkOption {
        type = lib.types.str;
        default = "192.168.1.254";
      };
    };
  };
  config = {

    networking.useNetworkd = true;
    networking.firewall = {
      enable = false;
    };
    systemd.network = {
      enable = true;
      networks."myvmnetwork" = {
        enable = true;
        matchConfig = {
          Type = "ether";
          Driver = "virtio_net";
        };
        networkConfig = {
          Address = "${config.staticIp.staticIpv4}/24";
          Gateway = config.staticIp.gatewayIpv4;
        };
        linkConfig = {
          RequiredForOnline = "routable";
        };
      };
    };
  };
}
