{ config, lib, pkgs, ... }:

## Thanks to https://www.reddit.com/r/NixOS/comments/1aq58xv/jupyter_and_python_on_nixos/
{
  environment.systemPackages = with pkgs; [
    (python312.withPackages (ps: with ps; [
      numpy # these two are
      scipy # probably redundant to pandas
      jupyterlab
      pandas
      statsmodels
      scikitlearn
      pymongo
      psycopg2
      plotly
      torch
      torchvision
      torchaudio
      python-dotenv
      notebook
      matplotlib
    ]))
    ];
}
