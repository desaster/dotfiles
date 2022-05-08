local M = {}

M.setup_keymaps = function()
    local g = vim.g -- global variables

    local function map(mode, lhs, rhs, opts)
      local options = { noremap = true }
      if opts then options = vim.tbl_extend('force', options, opts) end
      vim.api.nvim_set_keymap(mode, lhs, rhs, options)
    end

    -- TODO: what does this set_keymap from mjlbach do?
    vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
    g.mapleader = ' '
    g.maplocalleader = ","

    -- next/previous buffer
    map('n', '<leader>l', ':bnext<CR>', { silent = true })
    map('n', '<leader>h', ':bprevious<CR>', { silent = true })
    map("n", "<TAB>", ":bnext<CR>", { silent = true })
    map("n", "<S-TAB>", ":bprevious<CR>", { silent = true })

    -- switch to alternate buffer
    map('n', '<leader>#', ':b#<CR>')

    -- close the current buffer without closing (famiu/bufdelete.nvim)
    map('n', '<leader>d', ':silent Bdelete<CR>', { silent = true })

    -- switch to buffers by number
    map('n', '<leader>1', ':LualineBuffersJump 1<CR>', { noremap = true, silent = true })
    map('n', '<leader>2', ':LualineBuffersJump 2<CR>', { noremap = true, silent = true })
    map('n', '<leader>3', ':LualineBuffersJump 3<CR>', { noremap = true, silent = true })
    map('n', '<leader>4', ':LualineBuffersJump 4<CR>', { noremap = true, silent = true })
    map('n', '<leader>5', ':LualineBuffersJump 5<CR>', { noremap = true, silent = true })
    map('n', '<leader>6', ':LualineBuffersJump 6<CR>', { noremap = true, silent = true })
    map('n', '<leader>7', ':LualineBuffersJump 7<CR>', { noremap = true, silent = true })
    map('n', '<leader>8', ':LualineBuffersJump 8<CR>', { noremap = true, silent = true })
    map('n', '<leader>9', ':LualineBuffersJump 9<CR>', { noremap = true, silent = true })

    -- move between windows
    map('t', '<A-h>', '<C-\\><C-N><C-w>h', { noremap = true })
    map('t', '<A-j>', '<C-\\><C-N><C-w>j', { noremap = true })
    map('t', '<A-k>', '<C-\\><C-N><C-w>k', { noremap = true })
    map('t', '<A-l>', '<C-\\><C-N><C-w>l', { noremap = true })
    map('i', '<A-h>', '<C-\\><C-N><C-w>h', { noremap = true })
    map('i', '<A-j>', '<C-\\><C-N><C-w>j', { noremap = true })
    map('i', '<A-k>', '<C-\\><C-N><C-w>k', { noremap = true })
    map('i', '<A-l>', '<C-\\><C-N><C-w>l', { noremap = true })
    map('n', '<A-h>', '<C-w>h', { noremap = true })
    map('n', '<A-j>', '<C-w>j', { noremap = true })
    map('n', '<A-k>', '<C-w>k', { noremap = true })
    map('n', '<A-l>', '<C-w>l', { noremap = true })

    -- paste over currently selected text without yanking it
    map("v", "p", '"_dP', { noremap = true })

    -- keep search matches in the middle of the window and pulse the line when moving to them
    map('n', 'n', 'nzzzv', { noremap = true })
    map('n', 'N', 'Nzzzv', { noremap = true })

    -- backspace clears matches
    map('n', '<BS>', ':nohlsearch<CR>', { silent = true })

    -- emacs bindings in command line mode
    map('c', '<C-a>', '<Home>', { noremap = true })
    map('c', '<C-e>', '<End>', { noremap = true })

    --
    -- Telescope mappings
    --
    -- These are defined here instead of the telescope config, since we want
    -- telescope to lazy-load
    --

    -- Search for files in your current working directory
    map('n', '<C-p>', ':Telescope find_files<CR>')

    -- Searches for the string under your cursor in your current working directory
    -- map('n', '<leader>g', ':Telescope grep_string<CR>')

    -- Search for a string in your current working directory
    map('n', '<leader>g', ':Telescope live_grep<CR>')

    -- Lists files and folders in your current working directory, open files,
    -- navigate your filesystem, and create new files and folders
    map('n', '<F7>', ':Telescope file_browser<CR>')

    -- list buffers
    map('n', ';', ':Telescope buffers<CR>')
    map('n', '<leader><space>', ':Telescope buffers<CR>') -- 2x-space, could we live with this?
end

-- Setup LSP specific keys for a buffer
-- may be called by configs/lsp.lua or ftplugin/java.lua
M.setup_lsp_keymaps = function(client, bufnr)

    -- set mappings only in current buffer with lsp enabled
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- set options only in current buffer with lsp enabled
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- built-in manual completion popup thingie with CTRL-X CTRL-O
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap = true, silent = true }

    -- TODO: pressing K twice jumps into the hover window :(
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)

    -- Goto the definition of the word under the cursor, if there's only one, otherwise show all options in Telescope
    --buf_set_keymap('n', '<F12>', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    --buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<F12>', '<cmd>Telescope lsp_definitions<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)

    -- Goto the implementation of the word under the cursor if there's only
    -- one, otherwise show all options in Telescope
    --buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)

    -- Lists LSP references for word under the cursor
    --buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)

    -- code actions (e.g. add import)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<M-CR>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts) -- IntelliJ IDEA style Alt-Enter

    -- Goto the definition of the type of the word under the cursor, if
    -- there's only one, otherwise show all options in Telescope
    --buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>D', '<cmd>Telescope lsp_type_definitions<CR>', opts)

    -- workspace folders, do I want this stuff?
    --buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    --buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    --buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

    -- rename (refactor) symbol
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

    -- buf_set_keymap('v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)

    -- popup current diagnostics (e.g. an error)
    buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float(nil, { focus=false, scope="cursor" })<CR>', opts)

    -- jump to next diagnostic (e.g. an error)
    buf_set_keymap('n', '<F8>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<S-F8>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)

    -- disable formatting in favour of eslint formatting
    -- TODO: this setup needs work
    --client.resolved_capabilities.document_formatting = false
    --client.resolved_capabilities.document_range_formatting = false
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap('n', '<space>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    end
    if client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("v", "<space>=", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end
end

return M

-- vim: set sw=4 et:
