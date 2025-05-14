{ config, lib, pkgs, home-manager, ... }:
{
  environment.systemPackages = with pkgs; [
      binutils
      coreutils
      apfs-fuse
      usbutils
      nodenv
      tmux
      btop
      cowsay
      fortune
    ];
  fonts.packages = with pkgs; [
    noto-fonts
    # noto-fonts-cjk
    # noto-fonts-emoji
    liberation_ttf
    fira-code
    nerd-fonts.fira-code
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    jetbrains-mono
  ];

}
