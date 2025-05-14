{ config, lib, pkgs, home-manager, ... }:
{ # Slightly taken from https://github.com/SoraTenshi/ctf-nix-shell/blob/main/flake.nix
    environment.systemPackages = with pkgs; [
      ghidra
      nmap
      binwalk
      zap

      nikto



      masscan
      gdb
      pwndbg
      one_gadget



      pkgs.python312.withPackages (pp: [
        pp.pwntools
        pp.pycryptodome
        pp.python-lsp-server
      ]);
    ];
}
