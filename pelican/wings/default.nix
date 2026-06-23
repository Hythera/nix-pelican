{
  buildGoModule,
  fetchFromGitHub,
  lib,
}:
buildGoModule (finalAttrs: {
  pname = "pelican-wings";
  version = "1.0.0-beta26";

  src = fetchFromGitHub {
    owner = "pelican-dev";
    repo = "wings";
    tag = "v${finalAttrs.version}";
    hash = "sha256-Jh/Iga8ymuYhRTzqPjjLPPuE9RtURsOdjEaQOSp+q+M=";
  };

  vendorHash = "sha256-TCTlA+yvfxi0RH0etWJl7B6fbrKVuWZFRFvf7ejrfnA=";

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
