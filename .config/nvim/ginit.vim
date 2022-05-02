" https://jdhao.github.io/2019/01/17/nvim_qt_settings_on_windows/

" The GUI tabline of nvim-qt is ugly. We can use GuiTabline 0 inside ginit.vim
" to disable GUI tabline and use the terminal nvim tabline.
GuiTabline 0

" The GUI completion menu is also ugly and too long, since it shows the
" detailed docstrings of object methods

GuiPopupmenu 0

GuiFont! Consolas:h10

map <F11> <Esc>:call GuiWindowFullScreen(!g:GuiWindowFullScreen)<CR>
map <a-cr> <Esc>:call GuiWindowFullScreen(!g:GuiWindowFullScreen)<CR>
