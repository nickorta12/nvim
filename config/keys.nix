{ keymap, ... }:
let
  inherit (keymap)
    nmap
    imap
    nlua
    mkKeyLua
    ;
in
{
  keymaps = [
    # Buffer keymaps
    (nmap "<leader>bn" ":bn<cr>" "Next Buffer")
    (nmap "<leader>bp" ":bp<cr>" "Previous Buffer")
    (nmap "<A-,>" ":bn<cr>" "Next Buffer")
    (nmap "<A-.>" ":bp<cr>" "Previous Buffer")
    (nmap "<leader>bd" ":Bdelete<cr>" "Close Buffer")
    (nmap "<leader>bw" ":Bwipeout<cr>" "Wipeout Buffers")
    (nmap "<leader>bD" ":%bd|e#<cr>" "Close all Other Buffers")
    (nmap "<leader>bk" ":BufferLinePick<cr>" "Pick Buffer")
    (nmap "<leader>bK" ":BufferLinePickClose<cr>" "Pick Buffer Delete")
    # (nmap "<leader>bl" ":Neotree buffers<cr>" "List Buffers")

    (nmap "<leader>tn" ":tabn<cr>" "Next Tab")
    (nmap "<leader>tp" ":tabp<cr>" "Previous Tab")
    (nmap "<leader>td" ":tabclose<cr>" "Close Tab")
    (nmap "<leader>tc" ":tabnew<cr>" "New Tab")
    (nmap "<leader>tt" ":wincmd T<cr>" "Open in tab")

    (nlua "<leader>T" "Snacks.terminal()" "Open terminal")

    (nmap "<C-d>" "<C-d>zz" "Scroll Down")
    (nmap "<C-u>" "<C-u>zz" "Scroll Up")

    # (nmap "<leader>e" ":Neotree<cr>" "Show Explorer")
    # (nmap "<leader>E" ":Neotree toggle<cr>" "Toggle Explorer")
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
    (nmap "<leader>xl" ":Trouble lsp toggle focus=false win.position=right<cr>"
      "LSP Definitions / References"
    )
    (nmap "<leader>xL" ":Trouble loclist toggle<cr>" "Location List")
    (nmap "<leader>xQ" ":Trouble qflist toggle<cr>" "Quickfix List")

    (nlua "<leader>F" "require('conform').format()" "Format buffer")

    (nmap "<leader>rw" "yiw:s/<c-r>\"/" "Replace word in line")
    (nmap "<leader>rW" "yiw:%s/<c-r>\"/" "Replace word in file")

    (nmap "<leader>;" "mmA;<esc>`m" "Add semicolon")
    (imap "<c-g>;" "<esc>mmA;<esc>`ma" "Add semicolon")
    (nmap "<leader>," "mmA,<esc>`m" "Add comma")
    (nmap "<C-g>," "<esc>mmA,<esc>`ma" "Add comma")

    # Snacks pickers
    # Top Pickers & Explorer
    (nlua "<leader><space>" "Snacks.picker.smart()" "Smart Find Files")
    (nlua "<leader>," "Snacks.picker.buffers()" "Buffers")
    (nlua "<leader>/" "Snacks.picker.grep()" "Grep")
    (nlua "<leader>:" "Snacks.picker.command_history()" "Command History")
    (nlua "<leader>n" "Snacks.picker.notifications()" "Notification History")
    (nlua "<leader>e" "Snacks.explorer()" "File Explorer")
    # -- find
    (nlua "<leader>fb" "Snacks.picker.buffers()" "Buffers")
    # (nlua "<leader>fc" "Snacks.picker.files({ cwd = vim.fn.stdpath("config") })" "Find Config File" )
    (nlua "<leader>ff" "Snacks.picker.files()" "Find Files")
    (nlua "<leader>fg" "Snacks.picker.git_files()" "Find Git Files")
    (nlua "<leader>fp" "Snacks.picker.projects()" "Projects")
    (nlua "<leader>fr" "Snacks.picker.recent()" "Recent")
    # -- git
    (nlua "<leader>gb" "Snacks.picker.git_branches()" "Git Branches")
    (nlua "<leader>gl" "Snacks.picker.git_log()" "Git Log")
    (nlua "<leader>gL" "Snacks.picker.git_log_line()" "Git Log Line")
    (nlua "<leader>gs" "Snacks.picker.git_status()" "Git Status")
    (nlua "<leader>gS" "Snacks.picker.git_stash()" "Git Stash")
    (nlua "<leader>gd" "Snacks.picker.git_diff()" "Git Diff (Hunks)")
    (nlua "<leader>gf" "Snacks.picker.git_log_file()" "Git Log File")
    # -- Grep
    (nlua "<leader>sb" "Snacks.picker.lines()" "Buffer Lines")
    (nlua "<leader>sB" "Snacks.picker.grep_buffers()" "Grep Open Buffers")
    (nlua "<leader>sg" "Snacks.picker.grep()" "Grep")
    # (nlua "<leader>sw" "Snacks.picker.grep_word()" "Visual selection or word" mode = { "n" "x" } )
    # -- search
    # (nlua '<leader>s"' "Snacks.picker.registers()" "Registers" )
    # (nlua '<leader>s/' "Snacks.picker.search_history()" "Search History" )
    (nlua "<leader>sa" "Snacks.picker.autocmds()" "Autocmds")
    (nlua "<leader>sb" "Snacks.picker.lines()" "Buffer Lines")
    (nlua "<leader>sc" "Snacks.picker.command_history()" "Command History")
    (nlua "<leader>sC" "Snacks.picker.commands()" "Commands")
    (nlua "<leader>sd" "Snacks.picker.diagnostics()" "Diagnostics")
    (nlua "<leader>sD" "Snacks.picker.diagnostics_buffer()" "Buffer Diagnostics")
    (nlua "<leader>sh" "Snacks.picker.help()" "Help Pages")
    (nlua "<leader>sH" "Snacks.picker.highlights()" "Highlights")
    (nlua "<leader>si" "Snacks.picker.icons()" "Icons")
    (nlua "<leader>sj" "Snacks.picker.jumps()" "Jumps")
    (nlua "<leader>sk" "Snacks.picker.keymaps()" "Keymaps")
    (nlua "<leader>sl" "Snacks.picker.loclist()" "Location List")
    (nlua "<leader>sm" "Snacks.picker.marks()" "Marks")
    # (nlua "<leader>sM" "Snacks.picker.man()" "Man Pages")
    (nlua "<leader>sp" "Snacks.picker.lazy()" "Search for Plugin Spec")
    (nlua "<leader>sq" "Snacks.picker.qflist()" "Quickfix List")
    (nlua "<leader>sR" "Snacks.picker.resume()" "Resume")
    (nlua "<leader>su" "Snacks.picker.undo()" "Undo History")
    (nlua "<leader>uC" "Snacks.picker.colorschemes()" "Colorschemes")
    # -- LSP
    (nlua "gd" "Snacks.picker.lsp_definitions()" "Goto Definition")
    (nlua "gD" "Snacks.picker.lsp_declarations()" "Goto Declaration")
    # (nlua "gr" "Snacks.picker.lsp_references()" nowait = true "References" )
    (nlua "gI" "Snacks.picker.lsp_implementations()" "Goto Implementation")
    (nlua "gy" "Snacks.picker.lsp_type_definitions()" "Goto T[y]pe Definition")
    (nlua "<leader>ss" "Snacks.picker.lsp_symbols()" "LSP Symbols")
    (nlua "<leader>sS" "Snacks.picker.lsp_workspace_symbols()" "LSP Workspace Symbols")

    # Flash keybindings
    # https://github.com/folke/flash.nvim?tab=readme-ov-file#-installation
    (mkKeyLua [ "n" "x" "o" ] "s" "require('flash').jump()" "Flash")
    (mkKeyLua [ "n" "x" "o" ] "S" "require('flash').treesitter()" "Flash Treesitter")
    (mkKeyLua [ "o" ] "r" "require('flash').remote()" "Remote Flash")
    (mkKeyLua [ "o" "x" ] "R" "require('flash').treesitter_search()" "Treesitter Search")
    (mkKeyLua [ "c" ] "<c-s>" "require('flash').toggle()" "Toggle Flash Search")

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
