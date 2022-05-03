local cmp = require('cmp')
local luasnip = require('luasnip')

-- Set completeopt to have a better completion experience
-- TODO: explain why
vim.o.completeopt = 'menuone,noselect'

-- check out :CmpStatus
cmp.setup({
    sources = {
        { name = "nvim_lsp" },
        --{ name = "buffer" }, -- mostly annoying
        { name = "path" },
        --{ name = "vsnip" },
        { name = "luasnip" },
        --{ name = "neorg" },
    },
    mapping = {
        -- TODO: ESC seems to work too, but only this one works reliably
        ['<C-e>'] = cmp.mapping.close(),

        -- TODO: maybe C-p C-n with fallback?
        ['<Up>'] = cmp.mapping(cmp.mapping.scroll_docs(-3), { 'i', 'c' }),
        ['<Down>'] = cmp.mapping(cmp.mapping.scroll_docs(3), { 'i', 'c' }),

        -- TODO: what does this do?
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),

        -- TODO: what is this?
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.

        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ['<Cr>'] = cmp.mapping.confirm { select = true },

        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's', }),
    },
    formatting = {
        format = function(entry, item)
            item.menu = ({
                nvim_lsp = "[LSP]",
                path = "[Path]",
                luasnip = "[Snip]",
                buffer = "[Buf]",
            })[entry.source.name]
            return item
        end,
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
})
-- vim: set sw=4 et:
