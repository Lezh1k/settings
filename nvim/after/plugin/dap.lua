local opts = { noremap = true, silent = true }

local dap = require("dap")
local dapui = require("dapui")
-- todo set up dapui :)

local function configure_exts()
  require("nvim-dap-virtual-text").setup {
    commented = true,
  }

  dapui.setup() -- use default
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
end

local function configure_python_dap()
  local pd = require("dap-python")
  -- pd.test_runner = "pytest" -- todo move to each project
  -- vim.keymap.set("n", "<leader>tm", pd.test_method, opts)
  -- vim.keymap.set("n", "<leader>tc", pd.test_class, opts)
  -- vim.keymap.set("n", "<leader>ds", pd.debug_selection, opts)
  pd.setup("python", {})
end

local function configure_debuggers()
  configure_python_dap()
end


configure_exts()
configure_debuggers()

-- Debugging (requires dap)
vim.keymap.set("n", "<F5>", dap.continue, opts)
vim.keymap.set("n", "<F17>", dap.terminate, opts)
vim.keymap.set("n", "<F10>", dap.step_over, opts)
vim.keymap.set("n", "<F11>", dap.step_into, opts)
vim.keymap.set("n", "<F12>", dap.step_out, opts)
vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, opts)

-- dapui
vim.keymap.set("n", "<leader>dut", dapui.toggle, opts)
