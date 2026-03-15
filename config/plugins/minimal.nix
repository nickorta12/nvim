{
  waylandSupport = false;

  globals.nvim_surround_no_mappings = true;

  plugins = {
    # Better comments
    comment.enable = true;

    mini = {
      enable = true;
      modules = {
        ai = { };
      };
    };

    # Better surrounding of characters
    nvim-surround.enable = true;
  };
}
