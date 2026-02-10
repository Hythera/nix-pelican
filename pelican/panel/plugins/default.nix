{
  callPackage,
}:
let
  basePlugins = {
    billing = callPackage ./billing { };
    fluffy-theme = callPackage ./fluffy-theme { };
    tickets = callPackage ./tickets { };
  };
in
basePlugins
