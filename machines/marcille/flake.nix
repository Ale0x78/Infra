{ # Thank you to: https://sandstorm.de/blog/posts/my-first-steps-with-nix-on-mac-osx-as-homebrew-replacement/
  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    # devenv.url = "github:cachix/devenv/latest";
    nixstable.url = "nixpkgs/25.05";
  };

  outputs = { self, nixpkgs, nixstable }: {
    # packages.config.allowUnfree = true;
    packages."aarch64-darwin".default = let
      # pkgs = nixpkgs.legacyPackages."aarch64-darwin";
      pkgs = import nixpkgs {
        system = "aarch64-darwin";
        config.allowUnfree = true;
      };
      sbpkgs = import nixstable {
        system = "aarch64-darwin";
        config.allowUnfree = true;
      };

    zbar = pkgs.zbar.overrideAttrs (oldAttrs: {
      postInstall = "mkdir -p $out/lib/; ln -nsf $lib/lib/libzbar.dylib $out/lib/";
    });

    in pkgs.buildEnv {
      name = "home-packages";
      paths = with pkgs; [

        # general tools
        git
        curl
        envsubst
        wget
        nmap
        sbpkgs.fish
        cowsay
        neovim
        ghidra-bin
        tmux
        binutils
        coreutils
        nixd
        nil
        zellij
        fortune

        sshuttle
        android-tools
        parallel
        codeql
        rbenv

        podman-compose
        uv
        container
        kubectl

        # Dev stuff
        helix
        podman
        rustup
        # (pkgs.python313.withPackages (python-pkgs: with python-pkgs; [
        #   # select Python packages here
        #   pandas
        #   imageio
        #   brotli
        #   beautifulsoup4
        #   requests
        #   podman
        #   scipy
        #   rich
        #   imagehash
        #   seaborn
        #   zxing-cpp
        #   tiktoken
        #   # tensorflow
        #   zstandard
        #   # pynput
        #   docker
        #   z3-solver
        #   pymongo
        #   psycopg2-binary

        #   python-dotenv
        #   opencv4
        #   matplotlib
        #   # hdbscan
        #   numpy

        # ]))
        pgcli
        mongodb-tools
        go
        openconnect
        jdk
        nodejs_24
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
