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

    zbar-linked = pkgs.runCommand "zbar-with-home-lib" {
            buildInputs = [ pkgs.zbar ];
          } ''
            # Create the output directory structure
            mkdir -p $out/bin $out/lib $out/share
            
            # Copy everything from the original zbar
            cp -r ${pkgs.zbar}/* $out/
            
            # Create a wrapper script that ensures ~/lib exists and copies libraries there
            cat > $out/bin/zbar-copy-libs << 'EOF'
    #!/bin/bash
    # Ensure ~/lib directory exists
    mkdir -p "$HOME/lib"

    # Copy zbar libraries to ~/lib
    if [ -d "${pkgs.zbar}/lib" ]; then
        cp -r ${pkgs.zbar}/lib/* "$HOME/lib/" 2>/dev/null || true
        echo "zbar libraries copied to ~/lib"
    fi
    EOF

            chmod +x $out/bin/zbar-copy-libs
            
            # Also create a postInstall script that runs automatically
            mkdir -p $out/nix-support
            cat > $out/nix-support/setup-hook << 'EOF'
    # Post-install hook for zbar
    if [ -n "$HOME" ]; then
        mkdir -p "$HOME/lib"
        if [ -d "@out@/lib" ]; then
            cp -r @out@/lib/* "$HOME/lib/" 2>/dev/null || true
            echo "zbar libraries installed to ~/lib"
        fi
    fi
    EOF
            
            # Substitute the @out@ placeholder
            substituteInPlace $out/nix-support/setup-hook --replace "@out@" "$out"
          '';

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
        ghidra-bin
        tmux
        binutils
        coreutils
        fortune 
        zbar-linked
        sshuttle
        android-tools
        parallel
        podman-compose
        uv
        container
        kubectl

        # Dev stuff
        helix
        podman
        rustup
        (pkgs.python313.withPackages (python-pkgs: with python-pkgs; [
          # select Python packages here
          pandas
          imageio
          brotli
          beautifulsoup4
          requests
          podman
          scipy
          imagehash
          seaborn
          zxing-cpp
          tiktoken
          # tensorflow
          zstandard
          # pynput
          docker
          z3-solver
          pymongo
          # psycopg2-binary
          pyzbar
          python-dotenv
          opencv4
          matplotlib
          # hdbscan
          numpy
          pytorch
        ]))
        # pgcli
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
