{
  description = "Nix implementation of Pelican";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    {
      nixosModules.default = {
        imports = [
          ./pelican/panel/module.nix
          ./pelican/wings/module.nix
        ];
      };

      overlays.default = final: prev: {
        pelican-panel = prev.callPackage ./pelican/panel/default.nix { };
        pelican-panel-plugins = prev.callPackage ./pelican/panel/plugins { };
        pelican-panel-with-plugins = prev.callPackage ./pelican/panel/with-plugins.nix {
          plugins = with final.pelican-panel-plugins; [
            billing
            fluffy-theme
            tickets
          ]; # DEVELOPMENT ONLY
        };
        pelican-wings = prev.callPackage ./pelican/wings/default.nix { };
      };
    }
    // (inputs.flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        };
      in
      {
        packages = {
          pelican-panel = pkgs.pelican-panel;
          pelican-panel-plugins = pkgs.pelican-panel-plugins;
          pelican-panel-with-plugins = pkgs.pelican-panel-with-plugins;
          pelican-wings = pkgs.pelican-wings;
        };
      }
    ));
}
