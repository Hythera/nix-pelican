{
  buildGoModule,
  fetchFromGitHub,
  lib,
}:
buildGoModule (finalAttrs: {
  pname = "pelican-wings";
  version = "1.0.0-beta25";

  src = fetchFromGitHub {
    owner = "pelican-dev";
    repo = "wings";
    tag = "v${finalAttrs.version}";
    hash = "sha256-EFWK8VYYMw1rU7ktAdEL7XRO3dFYW/2hPgOlsfWInHA=";
  };

  vendorHash = "sha256-q1dcgf+F5MI5cV9Z6ZQDGnqxWsaT8XCWJO0Co81rKo8=";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/pelican-dev/wings/system.Version=${finalAttrs.version}"
  ];

  meta = {
    description = "Game server control panel backend offering high flying security";
    changelog = "https://github.com/pelican-dev/wings/releases/tag/v${finalAttrs.version}";
    homepage = "https://pelican.dev";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ hythera ];
    platforms = lib.platforms.linux;
  };
})
