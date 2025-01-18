lib: {
  keymap =
    let
      mkKeyBasic = key: action: desc: {
        inherit key action;
        options.desc = desc;
      };

      mkKeyBasicLua = key: action: desc: {
        inherit key;
        action.__raw = "function() ${action} end";
        options.desc = desc;
      };

      mkKey =
        mode: key: action: desc:
        lib.recursiveUpdate (mkKeyBasic key action desc) {
          inherit mode;
          options.silent = true;
        };

      mkKeyLua =
        mode: key: action: desc:
        lib.recursiveUpdate (mkKeyBasicLua key action desc) {
          inherit mode;
          options.silent = true;
        };

      keysToAttrs =
        let
          inherit (lib) listToAttrs map removeAttrs;
        in
        list:
        listToAttrs (
          map (x: {
            name = x.key;
            value = removeAttrs x [ "key" ];
          }) list
        );
    in
    {
      inherit
        mkKey
        mkKeyBasic
        mkKeyLua
        mkKeyBasicLua
        keysToAttrs
        ;
      nmap = mkKey "n";
      imap = mkKey "i";
      tmap = mkKey "t";
      nlua = mkKeyLua "n";
      ilua = mkKeyLua "i";
      tlua = mkKeyLua "t";
    };
}
