{ config, pkgs, ... }:

{
  # Set up the host entry
  networking.extraHosts = ''
    192.58.122.107 registry.k3s.kapravelos.com
  '';
  environment.systemPackages = with pkgs; [
    obsidian
    zotero-beta
    slack
    jetbrains.datagrip
    jetbrains.dataspell
    neovide
    jetbrains.idea-ultimate
    jetbrains.goland
    jetbrains.datagrip
    jetbrains.dataspell
    sshuttle
    vscode
  ];
  # virtualisation.lxd.enable = true;

  # users.users.alex = {
    # extraGroups = [ "lxd" ];
  # };
  # virtualisation.lxd.ui.enable = true;
  # virtualisation.lxd.zfsSupport = true;
  # virtualisation.lxc.unprivilegedContainers = true;
}
