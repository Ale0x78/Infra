{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.05";
    nixpkgs.follows = "nixos-cosmic/nixpkgs"; # NOTE: change "nixpkgs" to "nixpkgs-stable" to use stable NixOS release
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self
    , nixpkgs
    , nixpkgs-stable
    , nixos-cosmic
    , home-manager
    , ... }:
  let

    # lib = inputs.nixpkgs.lib;
    inherit (nixpkgs) lib;
    inherit (builtins) readDir attrNames mapAttrs;
    inherit (lib) const fileContents filterAttrs hasAttr mkIf recursiveUpdate;


    machines = let
      getProps = name: let
        dirPath = ./machines + "/${name}";
        dirContents = readDir dirPath;
      in recursiveUpdate {
        system = "x86_64-linux";
        files = mapAttrs (file: _: dirPath + "/${file}") dirContents;
      } (if hasAttr "default.nix" dirContents
          then import dirPath
          else {});
    in mapAttrs (name: _: getProps name) (filterAttrs (k: v: v == "directory") (readDir ./machines));

    mkConfig = name: props: rec {
      inherit (props) system;

      # Make inputs available as needed
      specialArgs = {
        inherit self
          nixpkgs
          nixpkgs-stable
          home-manager;
      };

      modules = [
        # Make processed inputs and variables available as needed
        {
          _module.args = {
            hostname = name;
            upkgs = nixpkgs-stable.legacyPackages.${system};
          };
        }
        nixpkgs.nixosModules.notDetected
        nixos-cosmic.nixosModules.default
        {
          nix.settings = {
            substituters = [ "https://cosmic.cachix.org/" ];
            trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
          };
        }

        # Config we want to apply to all systems
        ({ ... }: {
          system.configurationRevision = mkIf (self ? rev) self.rev;

          networking.hostName = name;
        })


        # Import this machine's config
        props.files."configuration.nix"
      ];
    };

    nixosConfigurationsRaw = mapAttrs mkConfig (filterAttrs (_: props: hasAttr "configuration.nix" props.files) machines);
  in {
    nixosConfigurations = mapAttrs (const lib.nixosSystem) nixosConfigurationsRaw;

    devShell.x86_64-linux = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in pkgs.mkShell {
      shellHook = ''
        nix --extra-experimental-features "nix-command flakes" \
          build -L ".#nixosConfigurations.\"$(hostname)\".config.system.build.toplevel"
        nix --extra-experimental-features "nix-command flakes" \
          build --profile /nix/var/nix/profiles/system "$(readlink -f "./result")"
        nix --extra-experimental-features "nix-command flakes" \
          shell -vv "$(readlink -f "./result")" -c switch-to-configuration switch
        [[ -e "./result" ]] && rm result
      '';
    };
  };
}
