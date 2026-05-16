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
    "x86_64-linux" = "sha256-izUxi6c3emIf+dnvd6RDtq088GW+VmyE9a6cgxjfVFk=";
    "aarch64-linux" = "sha256-D0oHW1EMVgifZyxyg1KDmGVv0KVBENaDaRnONNvxXAs=";
    "x86_64-darwin" = "sha256-oVLHp3WqMIjnr1JXMwujfX2FM3oOhYI7TcLbVWt8Oc8=";
    "aarch64-darwin" = "sha256-88InckVnewEoCZ9Jca4RycSk2aOarXBETC95qdZLaJM=";
  };
in
stdenv.mkDerivation (finalAttrs: {
  pname = "pyrefly";
  version = "1.0.0";

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
