{ config, pkgs, ... }:

{
  # Set up the host entry
  networking.extraHosts = ''
    192.58.122.107 registry.k3s.kapravelos.com
  '';
}
