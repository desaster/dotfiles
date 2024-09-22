-- utils?

local M = {}

-- Checks if running under Windows.
function M.is_win()
    if vim.loop.os_uname().version:match('Windows') then
        return true
    else
        return false
    end
end

-- Function equivalent to basename in POSIX systems.
-- https://github.com/grundic/vcsh-neovim-master/blob/main/.config/nvim/lua/utils.lua
function M.basename(str)
  return string.gsub(str, "(.*/)(.*)", "%2")
end

-- https://github.com/grundic/vcsh-neovim-master/blob/main/.config/nvim/lua/utils.lua
function M.join_paths(...)
    local path_sep = M.is_win() and '\\' or '/'
    local result = table.concat({ ... }, path_sep)
    return result
end

-- Loads all modules from the given package. Return combined results.
-- https://www.reddit.com/r/neovim/comments/reovwj/how_to_require_an_entire_directory_in_lua/ht88eug/
-- https://github.com/grundic/vcsh-neovim-master/blob/main/.config/nvim/lua/utils.lua
-- (modified to combine results into a single table)
local _base_lua_path = M.join_paths(vim.fn.stdpath('config'), 'lua')
function M.glob_require(package)
    local combined = {}
    local glob_path = M.join_paths(_base_lua_path, package, '*.lua')

    for _, path in pairs(vim.split(vim.fn.glob(glob_path), '\n', {})) do
        -- convert absolute filename to relative
        -- ~/.config/nvim/lua/<package>/<module>.lua => <package>/foo
        local relfilename = path:gsub(_base_lua_path, ""):gsub("%.lua", "")
        local basename = M.basename(relfilename)
        -- skip `init` and files starting with underscore.
        if (basename ~= 'init' and basename:sub(1, 1) ~= '_') then
            -- collect result to a table
            combined = vim.tbl_extend(
                "force",
                combined,
                {
                    [basename] = require(relfilename)
                })
        end
    end

    return combined
end

-- Clear extra crap from the screen so we can manually copy
-- contents to the clipboard. This is useful when the clipboard
-- integration is not working for whatever reason.
function M.toggle_crap()
    -- if line numbers are enabled, assume we have indent-blankline enabled too
    if vim.wo.number then
        vim.wo.number = false
        vim.wo.relativenumber = false
        vim.wo.signcolumn = 'no'
        if vim.fn.exists(':IBLDisable') > 0 then vim.cmd('IBLDisable') end
    else
        vim.wo.number = true
        vim.wo.relativenumber = true
        vim.wo.signcolumn = 'yes'
        if vim.fn.exists(':IBLEnable') > 0 then vim.cmd('IBLEnable') end
    end
end

return M
