{
  fetchFromGitHub,
  fetchYarnDeps,
  lib,
  nodejs,
  php84,
  php84Packages,
  stdenvNoCC,
  yarnConfigHook,
  dataDir ? "/var/lib/pelican-panel", # HYTHERA: Fix proper variable?
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "pelican-panel";
  version = "1.0.0-beta31";

  src = fetchFromGitHub {
    owner = "pelican-dev";
    repo = "panel";
    tag = "v${finalAttrs.version}";
    hash = "sha256-3cLx18u6xo8qPERZW33AyGeCiIX+vPWrs/d22HwZ7is=";
  };

  buildInputs = [ php84 ];

  nativeBuildInputs = [
    nodejs
    php84.composerHooks2.composerInstallHook
    php84Packages.composer
    yarnConfigHook
  ];

  composerVendor = php84.mkComposerVendor {
    inherit (finalAttrs) pname src version;
    composerNoDev = true;
    composerNoPlugins = true;
    composerNoScripts = true;
    composerStrictValidation = true;
    strictDeps = true;
    vendorHash = "sha256-e9L0wUsfGQpJ109yST9vBFyaxMC5v5emU2rE9pKWeuo=";
  };

  offlineCache = fetchYarnDeps {
    yarnLock = "${finalAttrs.src}/yarn.lock";
    hash = "sha256-VLero9gHqkh6svauRSwZf2ASpEBu9iQcPUx+J77SR+o=";
  };

  installPhase = ''
    runHook preInstall

    yarn run build

    cp -r public/build $out/share/php/pelican-panel/public

    chmod -R u+w $out/share
    mv $out/share/php/pelican-panel/* $out/

    rm -rf $out/share $out/plugins $out/storage $out/bootstrap/cache
    ln -s ${dataDir}/.env $out/.env
    ln -s ${dataDir}/plugins $out/plugins
    ln -s ${dataDir}/bootstrap/cache $out/bootstrap/cache
    ln -s ${dataDir}/storage $out/storage

    runHook postInstall
  '';

  meta = {
    description = "Free game server control panel offering high flying security";
    changelog = "https://github.com/pelican-dev/panel/releases/tag/v${finalAttrs.version}";
    homepage = "https://pelican.dev";
    license = lib.licenses.agpl3Plus; # HYTHERA: To be checked?
    maintainers = with lib.maintainers; [ hythera ];
    platforms = lib.platforms.all;
  };
})
