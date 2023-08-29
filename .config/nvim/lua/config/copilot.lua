local status_ok, copilot = pcall(require, 'copilot')
if not status_ok then
    return
end

-- HINT: :Copilot suggestion to toggle auto trigger
copilot.setup({
    panel = {
        keymap = {
            open = false, -- annoying to have it M-CR, TODO: find some other keybind for it
        }
    },
    suggestion = {
        auto_trigger = false,
        keymap = {
            accept = false,
            accept_word = false,
            accept_line = false,
            next = "<M-n>",
            prev = "<M-p>",
            dismiss = "<M-c>",
        },
    },
})
