{ config, lib, pkgs, home-manager, ... }:


{
    environment.systemPackages = with pkgs; [
      ghidra
    ];
}
