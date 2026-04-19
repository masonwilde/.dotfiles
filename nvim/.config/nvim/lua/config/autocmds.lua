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
