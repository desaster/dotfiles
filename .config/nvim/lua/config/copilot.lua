local status_ok, copilot = pcall(require, 'copilot')
if not status_ok then
    return
end

copilot.setup({
    suggestion = {
        auto_trigger = false,
        keymap = {
            accept = "<M-j>",
            accept_word = false,
            accept_line = false,
            next = "<M-n>",
            prev = "<M-p>",
            dismiss = "<M-c>",
        },
    },
})
