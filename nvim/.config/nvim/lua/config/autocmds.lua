local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Stop auto-continue comment on new line.
autocmd("FileType", {
	group = augroup("UserFormatOptions", {}),
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "r", "o" })
	end,
})

-- Pick up writes made outside Neovim (Claude editing files directly).
-- autoread only reloads buffers with no unsaved changes; checktime is what
-- actually triggers the check, and without it the reload waits for a manual :e.
autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
	group = augroup("UserAutoRead", {}),
	pattern = "*",
	callback = function()
		if vim.fn.mode() ~= "c" then
			vim.cmd("checktime")
		end
	end,
})

-- Reloading a clean buffer is silent, so this only fires on a real conflict:
-- the file changed on disk while the buffer held unsaved changes.
autocmd("FileChangedShellPost", {
	group = augroup("UserFileChanged", {}),
	pattern = "*",
	callback = function()
		vim.notify("File changed on disk, buffer reloaded", vim.log.levels.WARN)
	end,
})

-- Restore cursor to last position on file open.
autocmd("BufReadPost", {
	group = augroup("UserLastLoc", {}),
	pattern = { "*" },
	callback = function()
		local last = vim.fn.line([['"]])
		if last > 1 and last <= vim.fn.line("$") then
			vim.cmd([[normal! g'"]])
		end
	end,
})
