{ keymap, ... }:
let
  inherit (keymap)
    nmap
    imap
    nlua
    mkKeyLua
    ;

  # https://github.com/folke/snacks.nvim/issues/1628#issuecomment-2748889194
  smartExplorer = /* lua */ ''
    if Snacks.picker.get({ source = "explorer" })[1] == nil then
      Snacks.picker.explorer()
    elseif Snacks.picker.get({ source = "explorer" })[1]:is_focused() == true then
      Snacks.picker.explorer()
    elseif Snacks.picker.get({ source = "explorer" })[1]:is_focused() == false then
      Snacks.picker.get({ source = "explorer" })[1]:focus()
    end
  '';
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

    (nmap "<leader>tn" ":tabn<cr>" "Next Tab")
    (nmap "<leader>tp" ":tabp<cr>" "Previous Tab")
    (nmap "<leader>t]" ":tabn<cr>" "Next Tab")
    (nmap "<leader>t[" ":tabp<cr>" "Previous Tab")
    (nmap "<leader>td" ":tabclose<cr>" "Close Tab")
    (nmap "<leader>tc" ":tabnew<cr>" "New Tab")
    (nmap "<leader>tt" ":wincmd T<cr>" "Open in tab")
    (nmap "<leader>tf" ":tabfirst<cr>" "First tab")
    (nmap "<leader>tl" ":tablast<cr>" "Last tab")

    (nmap "<C-d>" "<C-d>zz" "Scroll Down")
    (nmap "<C-u>" "<C-u>zz" "Scroll Up")

    (nmap "<leader>y" ":Yazi<cr>" "Open File Browser (Yazi)")

    (nlua "<leader>gg" /* lua */ "Snacks.lazygit()" "Open LazyGit")
    (nlua "<c-g>" /* lua */ "Snacks.lazygit()" "Open LazyGit")
    (nlua "<leader>gl" /* lua */ "Snacks.lazygit.log()" "LazyGit Log")
    (nlua "<leader>gL" /* lua */ "Snacks.lazygit.log_file()" "LazyGit Log File")
    (nmap "<leader>gB" ":Git blame<CR>" "Git Blame")
    (nmap "<leader>gs" ":Git status<CR>" "Git Status")
    (nmap "<leader>gd" ":Gitsigns diffthis<CR>" "Git Diff")

    (nmap "<c-w>s" ":split<cr><c-w>j" "Split window")
    (nmap "<c-w>v" ":vsplit<cr><c-w>l" "Split window vertically")
    (nmap "<leader>ws" ":split<cr><c-w>j" "Split window")
    (nmap "<leader>wv" ":vsplit<cr><c-w>l" "Split window vertically")

    (nmap "<c-h>" "<c-w>h" "Go to Left Window")
    (nmap "<c-j>" "<c-w>j" "Go to Lower Window")
    (nmap "<c-k>" "<c-w>k" "Go to Upper Window")
    (nmap "<c-l>" "<c-w>l" "Go to Right Window")

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

    (nlua "<leader>F" /* lua */ "require('conform').format()" "Format buffer")

    (nmap "<leader>rw" "yiw:s/<c-r>\"/" "Replace word in line")
    (nmap "<leader>rW" "yiw:%s/<c-r>\"/" "Replace word in file")

    (nmap "<leader>;" "mmA;<esc>`m" "Add semicolon")
    (imap "<c-g>;" "<esc>mmA;<esc>`ma" "Add semicolon")
    (nmap "<leader>," "mmA,<esc>`m" "Add comma")
    (imap "<C-g>," "<esc>mmA,<esc>`ma" "Add comma")

    # Snacks pickers
    # Top Pickers & Explorer
    (nlua "<leader><space>" /* lua */ "Snacks.picker.smart()" "Smart Find Files")
    (nlua "<leader>," /* lua */ "Snacks.picker.buffers({focus='list'})" "Buffers")
    (nlua "<leader>/" /* lua */ "Snacks.picker.grep()" "Grep")
    (nlua "<leader>:" /* lua */ "Snacks.picker.command_history()" "Command History")
    (nlua "<leader>n" /* lua */ "Snacks.picker.notifications()" "Notification History")
    (nlua "<leader>e" smartExplorer "File Explorer")
    (nlua "\\" smartExplorer "File Explorer")
    # -- Find
    (nlua "<leader>fb" /* lua */ "Snacks.picker.buffers({focus='list'})" "Buffers")
    (nlua "<leader>ff" /* lua */ "Snacks.picker.files()" "Find Files")
    (nlua "<leader>fg" /* lua */ "Snacks.picker.git_files()" "Find Git Files")
    (nlua "<leader>fp" /* lua */ "Snacks.picker.projects()" "Projects")
    (nlua "<leader>fr" /* lua */ "Snacks.picker.recent()" "Recent")
    # -- Git
    (nlua "<leader>gb" /* lua */ "Snacks.picker.git_branches({focus='list'})" "Git Branches")
    (nlua "<leader>gl" /* lua */ "Snacks.picker.git_log({focus='list'})" "Git Log")
    (nlua "<leader>gL" /* lua */ "Snacks.picker.git_log_line({focus='list'})" "Git Log Line")
    (nlua "<leader>gs" /* lua */ "Snacks.picker.git_status({focus='list'})" "Git Status")
    (nlua "<leader>gS" /* lua */ "Snacks.picker.git_stash({focus='list'})" "Git Stash")
    (nlua "<leader>gd" /* lua */ "Snacks.picker.git_diff({focus='list'})" "Git Diff (Hunks)")
    (nlua "<leader>gf" /* lua */ "Snacks.picker.git_log_file({focus='list'})" "Git Log File")
    # -- Grep
    (nlua "<leader>sb" /* lua */ "Snacks.picker.lines()" "Buffer Lines")
    (nlua "<leader>sB" /* lua */ "Snacks.picker.grep_buffers()" "Grep Open Buffers")
    (nlua "<leader>sg" /* lua */ "Snacks.picker.grep()" "Grep")
    # -- Search
    (nlua "<leader>sa" /* lua */ "Snacks.picker.autocmds()" "Autocmds")
    (nlua "<leader>sb" /* lua */ "Snacks.picker.lines()" "Buffer Lines")
    (nlua "<leader>sc" /* lua */ "Snacks.picker.command_history()" "Command History")
    (nlua "<leader>sC" /* lua */ "Snacks.picker.commands()" "Commands")
    (nlua "<leader>sd" /* lua */ "Snacks.picker.diagnostics()" "Diagnostics")
    (nlua "<leader>sD" /* lua */ "Snacks.picker.diagnostics_buffer()" "Buffer Diagnostics")
    (nlua "<leader>sh" /* lua */ "Snacks.picker.help()" "Help Pages")
    (nlua "<leader>sH" /* lua */ "Snacks.picker.highlights()" "Highlights")
    (nlua "<leader>si" /* lua */ "Snacks.picker.icons()" "Icons")
    (nlua "<leader>sj" /* lua */ "Snacks.picker.jumps({layout='vertical'})" "Jumps")
    (nlua "<leader>sk" /* lua */ "Snacks.picker.keymaps({layout='vertical'})" "Keymaps")
    (nlua "<leader>sl" /* lua */ "Snacks.picker.loclist()" "Location List")
    (nlua "<leader>sm" /* lua */ "Snacks.picker.marks()" "Marks")
    (nlua "<leader>sq" /* lua */ "Snacks.picker.qflist()" "Quickfix List")
    (nlua "<leader>sR" /* lua */ "Snacks.picker.resume()" "Resume")
    (nlua "<leader>su" /* lua */ "Snacks.picker.undo({focus='list', layout='vertical'})" "Undo History")
    (nlua "<leader>ft" /* lua */ "Snacks.terminal()" "Terminal")
    (mkKeyLua [ "n" "t" ] "<c-/>" /* lua */ "Snacks.terminal()" "Terminal")

    # Flash keybindings
    # https://github.com/folke/flash.nvim?tab=readme-ov-file#-installation
    (mkKeyLua [ "n" "x" "o" ] "s" /* lua */ "require('flash').jump()" "Flash")
    (mkKeyLua [ "n" "x" "o" ] "S" /* lua */ "require('flash').treesitter()" "Flash Treesitter")
    (mkKeyLua [ "o" ] "r" /* lua */ "require('flash').remote()" "Remote Flash")
    (mkKeyLua [ "o" "x" ] "R" /* lua */ "require('flash').treesitter_search()" "Treesitter Search")
    (mkKeyLua [ "c" ] "<c-s>" /* lua */ "require('flash').toggle()" "Toggle Flash Search")

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
            __unkeyed-1 = "<leader>f";
            group = "Find/File";
          }
          {
            __unkeyed-1 = "<leader>s";
            group = "Search";
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
            __unkeyed-1 = "<leader>r";
            group = "Replace";
          }
          {
            __unkeyed-1 = "<leader>x";
            group = "Diagnostics";
          }
          {
            __unkeyed-1 = "<leader>v";
            group = "LSP";
          }
          {
            __unkeyed-1 = "<leader>u";
            group = "UI/Toggle";
          }
        ];
      };
    };
  };
}
