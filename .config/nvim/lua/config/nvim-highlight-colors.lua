local status_ok, hlcolors = pcall(require, 'nvim-highlight-colors')
if not status_ok then
    return
end

hlcolors.setup({
})
