{keymap, ...}: let
  inherit (keymap) nmap imap nlua mkKeyLua;
in {
  keymaps = [
    (nmap "<leader>bn" ":bn<cr>" "Next Buffer")
    (nmap "<leader>bp" ":bp<cr>" "Previous Buffer")
    (nmap "<A-,>" ":bn<cr>" "Next Buffer")
    (nmap "<A-.>" ":bp<cr>" "Previous Buffer")
    (nmap "<leader>bd" ":Bdelete<cr>" "Close Buffer")
    (nmap "<leader>bw" ":Bwipeout<cr>" "Wipeout Buffers")
    (nmap "<leader>bD" ":%bd|e#<cr>" "Close all Other Buffers")
    (nmap "<leader>bk" ":BufferLinePick<cr>" "Pick Buffer")
    (nmap "<leader>bK" ":BufferLinePickClose<cr>" "Pick Buffer Delete")
    (nmap "<leader>bl" ":Neotree buffers<cr>" "List Buffers")

    (nmap "<leader>tn" ":tabn<cr>" "Next Tab")
    (nmap "<leader>tp" ":tabp<cr>" "Previous Tab")
    (nmap "<leader>td" ":tabclose<cr>" "Close Tab")
    (nmap "<leader>tc" ":tabnew<cr>" "New Tab")

    (nlua "<leader>T" "Snacks.terminal()" "Open terminal")

    (nmap "<C-d>" "<C-d>zz" "Scroll Down")
    (nmap "<C-u>" "<C-u>zz" "Scroll Up")

    (nmap "<leader>e" ":Neotree<cr>" "Show Explorer")
    (nmap "<leader>E" ":Neotree toggle<cr>" "Toggle Explorer")
    (nmap "<leader>u" ":UndotreeToggle<cr>" "Toggle UndoTree")
    (nmap "<leader>y" ":Yazi<cr>" "Open File Browser (Yazi)")

    (nlua "<leader>gg" "Snacks.lazygit()" "Open LazyGit")
    (nlua "<leader>gl" "Snacks.lazygit.log()" "LazyGit Log")
    (nlua "<leader>gL" "Snacks.lazygit.log_file()" "LazyGit Log File")
    (nmap "<leader>gb" ":Git blame<CR>" "Git Blame")
    (nmap "<leader>gs" ":Git status<CR>" "Git Status")
    (nmap "<leader>gd" ":Gitsigns diffthis<CR>" "Git Diff")

    (nmap "<c-w>s" ":split<cr><c-w>j" "Split window")
    (nmap "<c-w>v" ":vsplit<cr><c-w>l" "Split window vertically")
    (nmap "<leader>ws" ":split<cr><c-w>j" "Split window")
    (nmap "<leader>wv" ":vsplit<cr><c-w>l" "Split window vertically")

    (nmap "<leader>wk" "<c-w>k" "Window Up")
    (nmap "<leader>wj" "<c-w>j" "Window Down")
    (nmap "<leader>wh" "<c-w>h" "Window Left")
    (nmap "<leader>wl" "<c-w>l" "Window Right")
    (nmap "<leader>wp" "<c-w>p" "Window Previous")
    (nmap "<leader>ww" "<c-w>w" "Window Down/Right")
    (nmap "<leader>wW" "<c-w>W" "Window Up/Left")
    (nmap "<leader>wt" "<c-w>t" "Window Top-Left")
    (nmap "<leader>wb" "<c-w>b" "Window Bottom-Right")
    (nmap "<leader>wq" "<c-w>q" "Window Delete")

    (nmap "<leader>xx" ":Trouble diagnostics toggle<cr>" "Diagnostics")
    (nmap "<leader>xX" ":Trouble diagnostics toggle filter.buf=0<cr>" "Buffer Diagnostics")
    (nmap "<leader>xs" ":Trouble symbols toggle focus=false<cr>" "Symbols")
    (nmap "<leader>xl" ":Trouble lsp toggle focus=false win.position=right<cr>" "LSP Definitions / References")
    (nmap "<leader>xL" ":Trouble loclist toggle<cr>" "Location List")
    (nmap "<leader>xQ" ":Trouble qflist toggle<cr>" "Quickfix List")

    (nlua "<leader>f" "require('conform').format()" "Format buffer")

    (nmap "<leader>rw" "yiw:s/<c-r>\"/" "Replace word in line")
    (nmap "<leader>rW" "yiw:%s/<c-r>\"/" "Replace word in file")

    (nmap "<leader>;" "mmA;<esc>`m" "Add semicolon")
    (imap "<c-g>;" "<esc>mmA;<esc>`ma" "Add semicolon")
    (nmap "<leader>," "mmA,<esc>`m" "Add comma")
    (nmap "<C-g>," "<esc>mmA,<esc>`ma" "Add comma")

    # Flash keybindings
    # https://github.com/folke/flash.nvim?tab=readme-ov-file#-installation
    (mkKeyLua ["n" "x" "o"] "s" "require('flash').jump()" "Flash")
    (mkKeyLua ["n" "x" "o"] "S" "require('flash').treesitter()" "Flash Treesitter")
    (mkKeyLua ["o"] "r" "require('flash').remote()" "Remote Flash")
    (mkKeyLua ["o" "x"] "R" "require('flash').treesitter_search()" "Treesitter Search")
    (mkKeyLua ["c"] "<c-s>" "require('flash').toggle()" "Toggle Flash Search")

    # (tmap "<esc><esc>" "<C-\\><C-n>" "Exit Terminal")
  ];
  plugins = {
    which-key = {
      enable = true;
      settings = {
        spec = [
          {
            __unkeyed-1 = "<leader>b";
            group = "Buffers";
          }
          {
            __unkeyed-1 = "<leader>s";
            group = "Search";
          }
          {
            __unkeyed-1 = "<leader>h";
            group = "GitGutter";
          }
          {
            __unkeyed-1 = "<leader>g";
            group = "Git";
          }
          {
            __unkeyed-1 = "<leader>w";
            group = "Window";
          }
          {
            __unkeyed-1 = "<leader>t";
            group = "Tab";
          }
          {
            __unkeyed-1 = "<leader>x";
            group = "Diagnostics";
          }
          {
            __unkeyed-1 = "<leader>v";
            group = "LSP";
          }
        ];
      };
    };
  };
}
