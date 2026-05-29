{
  lib,
  stdenv,
  fetchurl,
}:
let
  inherit (stdenv.hostPlatform) system;
  suffix =
    {
      "x86_64-linux" = "linux-x86_64";
      "aarch64-linux" = "linux-arm64";
      "x86_64-darwin" = "macos-x86_64";
      "aarch64-darwin" = "macos-arm64";
    }
    .${system} or (throw "Unsupported system: ${system}");

  hashes = {
    "x86_64-linux" = "sha256-Uelw+aHnruiwqoRJB2Q3QyRtzRtAkXC862MMVf+sZdo=";
    "aarch64-linux" = "sha256-AZJlZpA0SWRXcdSn6gEiG/px7fDeBml9v4m6OQYwcWc=";
    "x86_64-darwin" = "sha256-MIED38TUny2wpqzhIGtczvucRns8YcMIV/UXFo66Mjk=";
    "aarch64-darwin" = "sha256-RReazIJyW4POwD78U6fZewmXkR0jKeCxX4yMIE1iSNw=";
  };
in
stdenv.mkDerivation (finalAttrs: {
  pname = "pyrefly";
  version = "1.1.0-dev.1";

  src = fetchurl {
    url = "https://github.com/facebook/pyrefly/releases/download/${finalAttrs.version}/pyrefly-${suffix}.tar.gz";
    hash = hashes.${system};
  };

  sourceRoot = ".";

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    install -m755 -D pyrefly $out/bin/pyrefly
    runHook postInstall
  '';

  meta = {
    description = "Fast Python type checker and language server";
    homepage = "https://github.com/facebook/pyrefly";
    changelog = "https://github.com/facebook/pyrefly/releases/tag/${finalAttrs.version}";
    license = lib.licenses.mit;
    mainProgram = "pyrefly";
  };
})
