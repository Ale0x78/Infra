{ config, lib, pkgs, ... }:
{
  # Thanks https://nixos.wiki/wiki/SSH and https://discourse.nixos.org/t/open-firewall-ports-only-towards-local-network/13037
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = ["alex"]; # Allows all users by default. Can be [ "user1" "user2" ]
      # UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };


  networking.firewall.extraCommands = ''
    iptables -A nixos-fw -p tcp --source 192.168.86.1/24 --dport 22:22 -j nixos-fw-accept
    iptables -A nixos-fw -p udp --source 192.168.86.1/24 --dport 22:22 -j nixos-fw-accept
  '';
}
