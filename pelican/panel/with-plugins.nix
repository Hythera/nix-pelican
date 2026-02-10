{
  buildEnv,
  pelican-panel,
  php85,
  plugins ? [ ],
  stdenv,
}:
stdenv.mkDerivation {
  inherit (pelican-panel) src version;
  pname = "${pelican-panel.pname}-with-plugins";

  combinedPluginsDrv = buildEnv {
    name = "pelican-panel-plugins";
    paths = plugins;
  };

  nativeBuildInputs = [
    php85
  ];

  postPatch = ''
    cp -r $combinedPluginsDrv/* plugins
    mkdir vendor
    cp -r ${pelican-panel}/vendor .
    for plugin_dir in plugins/*/; do
        plugin_name=$(basename "$plugin_dir")
        php artisan p:plugin:install $plugin_name > output_$plugin_name.txt
    done
  '';

  buildPhase = ''
    runHook preBuild

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp -r . $out
    runHook postInstall
  '';
}
