{ config, lib, pkgs, ... }:
{

  fileSystems."/media" =
    { device = "zpool/media";
      fsType = "zfs";
      options = [
                "zfsutil"
                "users"
                "nofail"
      ];
    };
  systemd.tmpfiles.rules = [
    "d /media 1777 root root -"
  ];
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    dataDir = "/media";
    configDir = "/homelab/vault/jellyfin";
    cacheDir = "/homelab/vault/jellyfin_cache";
  };
  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];
}
