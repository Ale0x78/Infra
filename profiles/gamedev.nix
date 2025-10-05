{ config, lib, pkgs, home-manager, ... }:
{
## Special thanks to: https://wiki.nixos.org/wiki/Godot-Mono
programs.vscode = {
  enable = true;
  # `pkgs.vscodium` is unsupported by "C# Dev Kit" VSCode extension which demands Microsoft license compliance.
  package = pkgs.vscode;
  profiles.default = {
    "csharp.toolsDotnetPath" = "${pkgs.dotnet-sdk_9}/bin/dotnet";
    "dotnetAcquisitionExtension.sharedExistingDotnetPath" = "${pkgs.dotnet-sdk_9}/bin/dotnet";
    "dotnetAcquisitionExtension.existingDotnetPath" = [
      {
        "extensionId" = "ms-dotnettools.csharp";
        "path" = "${pkgs.dotnet-sdk_9}/bin/dotnet";
      }
      {
        "extensionId" = "ms-dotnettools.csdevkit";
        "path" = "${pkgs.dotnet-sdk_9}/bin/dotnet";
      }
      {
        "extensionId" = "woberg.godot-dotnet-tools";
        "path" = "${pkgs.dotnet-sdk_8}/bin/dotnet"; # Godot-Mono uses DotNet8 version.
      }
    ];
    "godotTools.lsp.serverPort" = 6005; # port should match your Godot configuration
    "omnisharp" = { # OminiSharp is a custom LSP for C#
      "path" = "${pkgs.omnisharp-roslyn}/bin/OmniSharp";
      "sdkPath" = "${pkgs.dotnet-sdk_9}";
      "dotnetPath" = "${pkgs.dotnet-sdk_9}/bin/dotnet";
    };
  extensions = with pkgs.vscode-extensions; [
    geequlim.godot-tools # For Godot GDScript support
    woberg.godot-dotnet-tools # For Godot C# support
    ms-dotnettools.csdevkit
    ms-dotnettools.csharp
    ms-dotnettools.vscode-dotnet-runtime
  ];
};

home.packages = [
  dotnetCorePackages.dotnet_9.sdk # For Godot-Mono VSCode-Extension CSharp
  godot-mono
];



};
}
