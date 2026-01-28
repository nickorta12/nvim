{ lib, ... }:
{
  globals = {
    mapleader = " ";
  };
  opts = {
    undofile = true;
    number = true;
    relativenumber = true;

    expandtab = true;
    smarttab = true;
    smartindent = true;
    ignorecase = true;
    smartcase = true;

    signcolumn = "yes";

    hlsearch = false;
    incsearch = true;

    termguicolors = true;
    scrolloff = 8;

    wrap = lib.mkDefault false;

    tabstop = 4;
    softtabstop = 4;
    shiftwidth = 4;

    timeoutlen = 500;
    winborder = "rounded";

    title = true;
    titlestring = "%{fnamemodify(getcwd(), ':t')}/%{expand('%:.')} - nvim";
  };
}
