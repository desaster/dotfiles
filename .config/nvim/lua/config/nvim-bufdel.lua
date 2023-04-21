local status_ok, nvim_bufdel = pcall(require, 'nvim_bufdel')
if not status_ok then
    return
end

nvim_bufdel.setup {
}
