{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "multicursor.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "jake-stewart";
        repo = "multicursor.nvim";
        # main as of 2025-02-08
        rev = "06a8a98a70a7840900621ecd410c790ea9b60296";
        hash = "sha256-pDX6Gtkla8kdK1zECvYCLmdyL+fIQvUw7gJKEWdCUew=";
      };
    })
  ];
  extraConfigLua = ''
    do
        local mc = require("multicursor-nvim")

        mc.setup()

        local set = vim.keymap.set

        -- Add or skip cursor above/below the main cursor.
        -- set({"n", "v"}, "<up>",
        --     function() mc.lineAddCursor(-1) end)
        -- set({"n", "v"}, "<down>",
        --     function() mc.lineAddCursor(1) end)
        -- set({"n", "v"}, "<leader><up>",
        --     function() mc.lineSkipCursor(-1) end)
        -- set({"n", "v"}, "<leader><down>",
        --     function() mc.lineSkipCursor(1) end)
        --
        -- -- Add or skip adding a new cursor by matching word/selection
        -- set({"n", "v"}, "<leader>n",
        --     function() mc.matchAddCursor(1) end)
        -- set({"n", "v"}, "<leader>s",
        --     function() mc.matchSkipCursor(1) end)
        -- set({"n", "v"}, "<leader>N",
        --     function() mc.matchAddCursor(-1) end)
        -- set({"n", "v"}, "<leader>S",
        --     function() mc.matchSkipCursor(-1) end)

        -- Add all matches in the document
        set({"n", "v"}, "<leader>A", mc.matchAllAddCursors, { desc = "Add all matches"})

        -- You can also add cursors with any motion you prefer:
        -- set("n", "<right>", function()
        --     mc.addCursor("w")
        -- end)
        -- set("n", "<leader><right>", function()
        --     mc.skipCursor("w")
        -- end)

        -- Rotate the main cursor.
        set({"n", "v"}, "<left>", mc.nextCursor, { desc = "Next cursor"})
        set({"n", "v"}, "<right>", mc.prevCursor, { desc = "Prev cursor"})

        -- Delete the main cursor.
        -- set({"n", "v"}, "<leader>x", mc.deleteCursor, { desc = "Delete cursor"})

        -- Add and remove cursors with control + left click.
        set("n", "<c-leftmouse>", mc.handleMouse, { desc = "Handle mouse"})

        -- Easy way to add and remove cursors using the main cursor.
        set({"n", "v"}, "<c-q>", mc.toggleCursor, { desc = "Toggle cursor"})

        -- Clone every cursor and disable the originals.
        set({"n", "v"}, "<leader><c-q>", mc.duplicateCursors, { desc = "Duplicate cursors"})

        set("n", "<esc>", function()
            if not mc.cursorsEnabled() then
                mc.enableCursors()
            elseif mc.hasCursors() then
                mc.clearCursors()
            else
                -- Default <esc> handler.
            end
        end)

        -- bring back cursors if you accidentally clear them
        set("n", "<leader>gv", mc.restoreCursors, { desc = "Restore cursors"})

        -- Align cursor columns.
        set("n", "<leader>a", mc.alignCursors, { desc = "Align cursors"})

        -- Split visual selections by regex.
        -- set("v", "S", mc.splitCursors, { desc = "Split cursors"})

        -- Append/insert for each line of visual selections.
        -- set("v", "I", mc.insertVisual, { desc = "Insert visual cursors"})
        -- set("v", "A", mc.appendVisual, { desc = "Append visual cursors"})

        -- match new cursors within visual selections by regex.
        -- set("v", "M", mc.matchCursors, { desc = "Match cursors"})

        -- Rotate visual selection contents.
        -- set("v", "<leader>T",
        --     function() mc.transposeCursors(-1) end, { desc = "Transpose cursors reverse"})
        -- set("v", "<leader>t",
        --     function() mc.transposeCursors(1) end, { desc = "Transpose cursors"})

        -- Jumplist support
        set({"v", "n"}, "<c-i>", mc.jumpForward, { desc = "Jump forward cursors"})
        set({"v", "n"}, "<c-o>", mc.jumpBackward, { desc = "Jump backward cursors"})

        -- Customize how cursors look.
        local hl = vim.api.nvim_set_hl
        hl(0, "MultiCursorCursor", { link = "Cursor" })
        hl(0, "MultiCursorVisual", { link = "Visual" })
        hl(0, "MultiCursorSign", { link = "SignColumn"})
        hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
        hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
    end
  '';
}
