{ config, lib, pkgs, ... }:

## Thanks to https://www.reddit.com/r/NixOS/comments/1aq58xv/jupyter_and_python_on_nixos/
{
  # nixpkgs.config.cudaSupport = true;
  environment.systemPackages = with pkgs; [
    (python313.withPackages (ps: with ps; [
      numpy # these two are
      scipy # probably redundant to pandas
      pandas
      statsmodels
      scikit-learn
      pynput
      # hdbscan
      pymongo
      psycopg2
      # plotly
      # torch
      # torchvision
      # torchaudio
      python-dotenv
      notebook
      jupyter-core
      matplotlib
      seaborn
    ]))
    ];
}
