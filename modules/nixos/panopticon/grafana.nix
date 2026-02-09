{ config, ... }:
{
  services.nginx.virtualHosts.${config.services.grafana.domain} = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString config.services.grafana.http_port}";
      proxyWebsockets = true;
    };
  };

  services.grafana = {
    enable = true;
    settings = {
      server = {
        protocol = "http";
        http_addr = "127.0.0.1";
        http_port = 1337;
        domain = config.staticIp.staticIpv4;
      };
    };
  };

  services.prometheus = {
    enable = true;
    port = 9001;

    # Export metrics for own node
    exporters = {
      node = {
        enable = true;
        enabledCollectors = [ "systemd" ];
        port = 9002;
      };
    };

    # Collect metrics
    scrapeConfigs = [
      # From this node
      {
        job_name = "panopticon";
        static_configs = [
          {
            targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.node.port}" ];
          }
        ];
      }
    ];

  };
}
