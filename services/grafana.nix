{ pkgs, home-manager, lib, ... }:
{
  services.prometheus =
  {
    enable = true;
    listenAddress = "100.118.80.90";
    scrapeConfigs = [
        {
          job_name = "node";
          static_configs = [{
            targets = [ "localhost:9000" ];
          }];
        }
        ];
  };

  services.prometheus.exporters.node = {
    enable = true;
    port = 9000;
    # https://github.com/NixOS/nixpkgs/blob/nixos-24.05/nixos/modules/services/monitoring/prometheus/exporters.nix
    enabledCollectors = [ "systemd" ];
    # /nix/store/zgsw0yx18v10xa58psanfabmg95nl2bb-node_exporter-1.8.1/bin/node_exporter  --help
    extraFlags = [ "--collector.ethtool" "--collector.softirqs" "--collector.tcpstat" "--collector.wifi" ];
  };

  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "100.118.80.90";
        http_port = 8080;
      };
    };
  };
}
