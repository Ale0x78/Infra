{ # Thank you to: https://sandstorm.de/blog/posts/my-first-steps-with-nix-on-mac-osx-as-homebrew-replacement/
  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    # devenv.url = "github:cachix/devenv/latest";
    # nixstable.url = "nixpkgs/nixos";
  };

  outputs = { self, nixpkgs }: {
    # packages.config.allowUnfree = true;
    packages."aarch64-darwin".default = let
      # pkgs = nixpkgs.legacyPackages."aarch64-darwin";
      pkgs = import nixpkgs {
        system = "aarch64-darwin";
        config.allowUnfree = true;
      };
    in pkgs.buildEnv {
      name = "home-packages";
      paths = with pkgs; [

        # general tools
        git
        curl
        wget
        nmap
        fish
        cowsay
        neovim
        binutils
        coreutils
        fortune 
        zbar
        sshuttle
        parallel
        poetry
        pyenv

        # Dev stuff
        helix
        podman
        nodejs
        rustup
        (pkgs.python313.withPackages (python-pkgs: with python-pkgs; [
          # select Python packages here
          pandas
          imageio
          brotli
          requests
          podman
          zxing-cpp
          tiktoken
          # tensorflow
          zstandard
          # pynput
          docker
          z3-solver
          pymongo
          # keyboard
          psycopg2-binary
          pyzbar
          python-dotenv
          opencv4
          matplotlib
          # hdbscan
          numpy
          pytorch
        ]))
        pgcli
        mongodb-tools
        go
        openconnect
        jdk
        mitmproxy
        ffmpeg
        ripgrep
        pandoc
        texlive.combined.scheme-full


		# ... add your tools here
      ];
    };
  };

}
