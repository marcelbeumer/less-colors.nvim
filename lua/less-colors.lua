local M = {}

local enabled = false

local defaults = {
  enabled = true,
  enable_command = "LessColors",
  disable_command = "MoreColors",
  toggle_command = "LessColorsToggle",
  commands = true,
  autocmd = false,
}

local function less_colors()
  local normal_fg = vim.fn.synIDattr(vim.fn.hlID("Normal"), "fg", "gui")
  vim.api.nvim_set_hl(0, "Boolean", { fg = normal_fg })
  vim.api.nvim_set_hl(0, "Character", { fg = normal_fg })
  vim.api.nvim_set_hl(0, "Comment", { fg = normal_fg })
  vim.api.nvim_set_hl(0, "Constant", { fg = normal_fg })
  vim.api.nvim_set_hl(0, "Float", { fg = normal_fg })
  vim.api.nvim_set_hl(0, "Function", { fg = normal_fg })
  vim.api.nvim_set_hl(0, "Identifier", { fg = normal_fg })
  vim.api.nvim_set_hl(0, "Keyword", { fg = normal_fg })
  vim.api.nvim_set_hl(0, "Number", { fg = normal_fg })
  vim.api.nvim_set_hl(0, "Special", { fg = normal_fg })
  vim.api.nvim_set_hl(0, "@spell", { fg = normal_fg })
  vim.api.nvim_set_hl(0, "Statement", { fg = normal_fg })
  vim.api.nvim_set_hl(0, "String", { fg = normal_fg })
  vim.api.nvim_set_hl(0, "Type", { fg = normal_fg })
end

local function more_colors()
  if vim.g.colors_name then
    vim.cmd.colorscheme(vim.g.colors_name)
  else
    vim.cmd.colorscheme("default")
  end
end

function M.enable()
  enabled = true
  less_colors()
end

function M.disable()
  enabled = false
  more_colors()
end

function M.toggle()
  enabled = not enabled
  if enabled then
    less_colors()
  else
    more_colors()
  end
end

function M.setup(opts)
  opts = opts or {}
  local config = vim.tbl_extend("force", {}, defaults, opts)

  enabled = config.enabled

  if config.commands then
    vim.api.nvim_create_user_command(config.enable_command, M.enable, {})
    vim.api.nvim_create_user_command(config.disable_command, M.disable, {})
    vim.api.nvim_create_user_command(config.toggle_command, M.toggle, {})
  end

  if config.autocmd then
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        if enabled then
          less_colors()
        end
      end,
    })
  end

  if enabled then
    less_colors()
  end
end

return M
