{
  buildGoModule,
  fetchFromGitHub,
  lib,
}:
buildGoModule (finalAttrs: {
  pname = "pelican-wings";
  version = "1.0.0-beta22";

  src = fetchFromGitHub {
    owner = "pelican-dev";
    repo = "wings";
    tag = "v${finalAttrs.version}";
    hash = "sha256-CVH3oiqDa/kLEstvLwO45/jetKI/V1wlrXK1C+CVzgs=";
  };

  vendorHash = "sha256-Nkz9qz8rh+1dO9lGrTLLO0mOXLtcQmxi1R1jGxWiKic=";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/pelican-dev/wings/system.Version=${finalAttrs.version}"
  ];

  meta = {
    description = "Free game server control panel backend offering high flying security"; # HYTHERA: To be changed?
    changelog = "https://github.com/pelican-dev/wings/releases/tag/v${finalAttrs.version}";
    homepage = "https://pelican.dev";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ hythera ];
    platforms = lib.platforms.all;
  };
})
