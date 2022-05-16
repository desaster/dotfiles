local status_ok, toggleterm = pcall(require, 'toggleterm')
if not status_ok then
    return
end

toggleterm.setup {
    size = 10,
    open_mapping = [[<F4>]],
    direction = horizontal
}
