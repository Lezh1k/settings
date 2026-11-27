require("lezh1k")

local log = vim.lsp.log.get_filename()
local st = vim.uv.fs_stat(log)
if st and st.size > 10 * 1024 * 1024 then
  os.remove(log)
end
