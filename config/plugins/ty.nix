{
  lib,
  stdenv,
  fetchurl,
  installShellFiles,
}:
let
  inherit (stdenv.hostPlatform) system;
  suffix =
    {
      "x86_64-linux" = "x86_64-unknown-linux-gnu.tar.gz";
      "aarch64-darwin" = "aarch64-apple-darwin.tar.gz";
    }
    .${system} or (throw "Unsupported system: ${system}");

  hashes = {
    "x86_64-linux" = "sha256-BUH3BmGnJEBeLVDn6a3dOPkOVf2b5OyAQVPW5ieXlYw=";
    "aarch64-darwin" = "sha256-/hc7SVvo+WPSFkgFhsubyqb7CTAl0OrSsRx6QyO2zzE=";
  };
in
stdenv.mkDerivation (finalAttrs: {
  pname = "ty";
  version = "0.0.8";

  src = fetchurl {
    url = "https://github.com/astral-sh/ty/releases/download/${finalAttrs.version}/ty-${suffix}";
    hash = hashes.${system};
  };

  dontBuild = true;

  nativeBuildInputs = [ installShellFiles ];

  installPhase = ''
    runHook preInstall
    install -m755 -D ty $out/bin/ty
    runHook postInstall
  '';

  meta = {
    description = "Extremely fast Python type checker and language server, written in Rust";
    homepage = "https://github.com/astral-sh/ty";
    changelog = "https://github.com/astral-sh/ty/blob/${finalAttrs.version}/CHANGELOG.md";
    license = lib.licenses.mit;
    mainProgram = "ty";
    maintainers = with lib.maintainers; [
      bengsparks
      GaetanLepage
    ];
  };
})
