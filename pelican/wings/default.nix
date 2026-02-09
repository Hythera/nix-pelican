{
  buildGoModule,
  fetchFromGitHub,
  lib,
}:
buildGoModule (finalAttrs: {
  pname = "pelican-wings";
  version = "1.0.0-beta23";

  src = fetchFromGitHub {
    owner = "pelican-dev";
    repo = "wings";
    tag = "v${finalAttrs.version}";
    hash = "sha256-guvcyZ8VLEEi2osbO/yO0aFQJTIppaFRCtxnaWv1qmM=";
  };

  vendorHash = "sha256-juiJGX0wax1iIAODAgBUNLlfFg4kd14bB6IeEqohs8U=";

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
