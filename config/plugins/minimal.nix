{
  waylandSupport = false;

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
    nvim-surround = {
      enable = true;
      settings.keymaps = {
        insert = "<C-g>z";
        insert_line = "<C-g>Z";
        normal = "gz";
        normal_cur = "gzz";
        normal_line = "gZ";
        normal_cur_line = "gZZ";
        visual = "Z";
        visual_line = "gZ";
        delete = "dz";
        change = "cz";
        change_line = "cZ";
      };
    };
  };
}
