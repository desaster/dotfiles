local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
    return
end

telescope.setup({
    defaults = {
        disable_devicons = true,
        prompt_prefix = "τ ",
        entry_prefix = "○ ",
        set_env = {
            ["COLORTERM"] = "truecolor"
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
            },
        },
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--ignore',
            '--hidden',
            '-g',
            '!.git',
        },
        mappings = {
            i = {
                -- TODO: telescope mappings are a bit clumsy
                --['<ESC>'] = require('telescope.actions').close,
                ['<C-u>'] = false,
                ['<C-d>'] = false,
            },
        },
    },
})
