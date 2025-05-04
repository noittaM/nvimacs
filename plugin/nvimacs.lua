function keymap_set_to_cmd_and_i(lhs, rhs)
  -- NOTE: need to do this because vim cmd mode doesn't update cursor sometimes
  vim.keymap.set("!", lhs, function()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(rhs, true, true, true), "n", true)
  end, { silent = true })
end

--
--- Navigation

-- backward-char
keymap_set_to_cmd_and_i("<C-b>", "<Left>")

-- forward-char
keymap_set_to_cmd_and_i("<C-f>", "<Right>")

-- previous-line
vim.keymap.set("i", "<C-p>", "<Up>", { silent = true })

-- next-line
vim.keymap.set("i", "<C-n>", "<Down>", { silent = true })

-- move-beginning-of-line
keymap_set_to_cmd_and_i("<C-a>", "<Home>", { silent = true })

-- move-end-of-line
keymap_set_to_cmd_and_i("<C-e>", "<End>", { silent = true })

-- backward-sentence
vim.keymap.set("i", "<M-a>", "<C-o>(", { silent = true })

-- forward-sentence
vim.keymap.set("i", "<M-e>", "<C-o>)", { silent = true })

-- backward-word
keymap_set_to_cmd_and_i("<M-b>", "<S-Left>", { silent = true })

-- forward-word
keymap_set_to_cmd_and_i("<M-f>", "<S-Right>", { silent = true })

-- scroll-down-command
vim.keymap.set("i", "<M-v>", "<PageUp>", { silent = true })

-- scroll-up-command
vim.keymap.set("i", "<C-v>", "<PageDown>", { silent = true })

--
--- Copy & Paste

-- delete-char
keymap_set_to_cmd_and_i("<C-d>", "<Del>", { silent = true })

--
--- Editing

-- kill-region
keymap_set_to_cmd_and_i("<M-BS>", "<C-w>", { silent = true })

-- kill-line
vim.keymap.set("i", "<C-k>", function()
	local col = vim.api.nvim_win_get_cursor(0)[2]
	local line = vim.api.nvim_get_current_line()

	if #line <= col then
		return "<Del><C-o>dw"
	end

	return "<C-o>dw"
end, { silent = true, expr = true })
vim.keymap.set("c", "<C-k>", "<C-f>d$<C-c><End>", { silent = true })

-- kill-word
vim.keymap.set("i", "<M-d>", function()
	local col = vim.api.nvim_win_get_cursor(0)[2]
	local line = vim.api.nvim_get_current_line()

	if #line <= col then
		return "<Del>"
	end

	return "<C-o>d$"
end, { silent = true, expr = true })

-- kill-sentence
vim.keymap.set("i", "<M-k>", "<C-o>d)", { silent = true })
