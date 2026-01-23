<p align="center">
    <a href="https://pelican.dev/"><img src=".github/assets/nix-pelican.png" alt="Nix Pelican" height=170></a>
</p>
<h1 align="center">Nix Pelican</h1>

<p align="center">
<a href="https://pelican.dev/docs/panel/getting-started" target="_blank"><img height=20 src="https://img.shields.io/badge/version-1.0.0_beta31-blue" /></a>
<img src="https://img.shields.io/github/stars/Hythera/nix-pelican" alt="stars">
</p>

<div align="center">
  <a href="https://pelican.dev/">Pelican</a>
  <span>&nbsp;&nbsp;•&nbsp;&nbsp;</span>
  <a href="https://github.com/Hythera/nix-pelican/issues/new">Issues</a>
  <span>&nbsp;&nbsp;•&nbsp;&nbsp;</span>
  <a href="https://github.com/pelican-dev/panel/releases">Changelog</a>
  <br />
</div>

## What is Nix Pelican?

Pelican is an open-source game server management tool, forked from Pterodactyl. This module brings this panel to Nix by implementing its own module for both frontend and backend service. This build is heavily based off of [PadowYT2's Implementation](https://github.com/PadowYT2/pterodactyl.nix), so be sure to check him and his work out.

## Install

Pelican should work on all operating systems, as the frontend uses PHP and the backend uses Docker. It is mostly recommendet though, to run Pelican on either `x86_64-linux` or `aarch64-linux`.

### Default installation

The default way of installing Pelican, is by using this flake as the input for your flake and adding the module to your configuration.

```nix
# flake.nix
{
  inputs = {
    pelican.url = "github:Hythera/nix-pelican";
    ...
  };
  outputs = {
    nixpkgs,
    home-manager,
    pelican,
  }: let
    system = "...";
    pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations."..." = nixpkgs.lib.nixosSystem {
        system = "...";
        modules = [
          pelican.nixosModules.default # enable the NixOS moduel
          { nixpkgs.overlays = [ pelican.overlays.default ]; }
          ...
        ];
      };
    }
}

```

To use the module, you also have to configure it in your configuration.

```nix
# configuration.nix
{
  pkgs,
  ...
}: {
  # PANEL
  services.pelican.panel = {
    enable = true;
    app = {
      url = "https://panel.example.com";
      # echo "base64:$(openssl rand -base64 32)"
      keyFile = "/path/to/app.key";
    };
    # you can use *.password = "password_here";
    database.passwordFile = "/path/to/db/password";
    redis.passwordFile = "/path/to/redis/password";
    mail.passwordFile = "/path/to/mail/password";
  };

  # WINGS
  services.pelican.wings = {
    enable = true;
    openFirewall = true;
    uuid = "your-node-uuid";
    remote = "https://panel.example.com";
    tokenIdFile = "/path/to/token/id";
    tokenFile = "/path/to/token";
    api.ssl.enable = true;
    api.ssl.certFile = "/path/to/cert";
    api.ssl.keyFile = "/path/to/key";
  };

  virtualisation.docker.enable = true;
}
