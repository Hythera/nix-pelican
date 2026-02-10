{
  fetchFromGitHub,
  lib,
  stdenv,
}:

stdenv.mkDerivation (finalAttrs: {
  name = "fluffy-theme";

  src = fetchFromGitHub {
    owner = "pelican-dev";
    repo = "plugins";
    rev = "d9a53e336f992dbfb022af766b17f69d46250f30";
    hash = "sha256-pd7n8/7ufOgN8mo7/6IsHT5AVzpqJtHt9Kf6glz5LOc=";
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    mv fluffy-theme $out/fluffy-theme
    runHook postInstall
  '';

  meta = {
    description = "Super nice and super fluffy theme";
    homepage = "https://pelican.dev";
    license = lib.licenses.gpl3Only;
  };
})
