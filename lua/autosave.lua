print("Updated autosave.lua")
local attach_to_buffer = function(output_bufnr, command, pattern)
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = vim.api.nvim_create_augroup("bEiGeOnEsCommands", { clear = true }),
		pattern = pattern,
		callback = function()
			vim.api.nvim_buf_set_lines(output_bufnr, 0, -1, false, { "output of: test.lua" })

			vim.fn.jobstart(command, {
				stdout_buffered = true,
				on_stdout = function(_, data)
					-- print("stdout: " .. vim.inspect(data))
					if data then
						local lines = {}
						for _, line in ipairs(data) do
							line = line:gsub("\r", "")
							if line ~= "" then
								table.insert(lines, line)
							end
						end
						if #lines > 0 then
							vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, lines)
						end
					end
				end,
				on_stderr = function(_, data)
					-- print("stderr: " .. vim.inspect(data))
					if data then
						local lines = {}
						for _, line in ipairs(data) do
							line = line:gsub("\r", "")
							if line ~= "" then
								table.insert(lines, line)
							end
						end
						if #lines > 0 then
							vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, lines)
						end
					end
				end,
			})
		end,
	})
end

local nvim_path = vim.fn.exepath("nvim")
if nvim_path == "" then
	error("Neovim not found on the path")
end

local pattern = "*.lua"
attach_to_buffer(65, { nvim_path, "-l", "test.lua" }, pattern)
