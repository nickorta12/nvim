{
  lib,
  fetchFromGitHub,
  runCommand,
  buildNpmPackage,
  docify,
  testers,
  writeText,
  jq,
  basedpyright,
  pkg-config,
  libsecret,
  nix-update-script,
  versionCheckHook,
}:

buildNpmPackage rec {
  pname = "basedpyright";
  version = "1.26.0";

  src = fetchFromGitHub {
    owner = "detachhead";
    repo = "basedpyright";
    tag = "v${version}";
    hash = "sha256-USGndOqosE6+gkCow7UeqEd37R4gYo5om1QEV7iz77g=";
  };

  npmDepsHash = "sha256-lpAsDMa3yRtbORmycDh3nGpozmzHej4WORvEml/+buE=";
  npmWorkspace = "packages/pyright";

  preBuild = ''
    # Build the docstubs
    cp -r packages/pyright-internal/typeshed-fallback docstubs
    docify docstubs/stdlib --builtins-only --in-place
  '';

  nativeBuildInputs = [
    docify
    pkg-config
  ];

  buildInputs = [ libsecret ];

  postInstall = ''
    mv "$out/bin/pyright" "$out/bin/basedpyright"
    mv "$out/bin/pyright-langserver" "$out/bin/basedpyright-langserver"
    for i in {based,}pyright {based,}pyright-langserver; do
      rm "$out/lib/node_modules/pyright-root/node_modules/.bin/$i"
    done
    for i in basedpyright browser-basedpyright vscode-pyright pyright-internal; do
      rm "$out/lib/node_modules/pyright-root/node_modules/$i"
    done
  '';

  nativeInstallCheckInputs = [ versionCheckHook ];
  versionCheckProgramArg = [ "--version" ];
  doInstallCheck = true;

  passthru = {
    updateScript = nix-update-script { };
    tests = {
      # We are expecting 4 errors. Any other amount would indicate not working
      # stub files, for instance.
      simple = testers.testEqualContents {
        assertion = "simple type checking";
        expected = writeText "expected" ''
          4
        '';
        actual =
          runCommand "actual"
            {
              nativeBuildInputs = [
                jq
                basedpyright
              ];
              base = writeText "test.py" ''
                import sys
                from time import tzset

                def print_string(a_string: str):
                    a_string += 42
                    print(a_string)

                if sys.platform == "win32":
                    print_string(69)
                    this_function_does_not_exist("nice!")
                else:
                    result_of_tzset_is_None: str = tzset()
              '';
              configFile = writeText "pyproject.toml" ''
                [tool.pyright]
                typeCheckingMode = "strict"
              '';
            }
            ''
              (basedpyright --outputjson $base || true) | jq -r .summary.errorCount > $out
            '';
      };
    };
  };

  meta = {
    changelog = "https://github.com/detachhead/basedpyright/releases/tag/${src.tag}";
    description = "Type checker for the Python language";
    homepage = "https://github.com/detachhead/basedpyright";
    license = lib.licenses.mit;
    mainProgram = "basedpyright";
    maintainers = with lib.maintainers; [ kiike ];
  };
}
