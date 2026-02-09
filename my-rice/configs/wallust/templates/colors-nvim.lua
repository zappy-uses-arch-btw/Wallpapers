vim.cmd('hi clear')
if vim.fn.exists('syntax_on') then vim.cmd('syntax reset') end
vim.o.background = 'dark'
vim.g.colors_name = 'wallust'

local c = {
    bg='{{background}}', fg='{{foreground}}',
    c0='{{color0}}', c1='{{color1}}', c2='{{color2}}', c3='{{color3}}',
    c4='{{color4}}', c5='{{color5}}', c6='{{color6}}', c7='{{color7}}',
    c8='{{color8}}', c9='{{color9}}', c10='{{color10}}', c11='{{color11}}',
    c12='{{color12}}', c13='{{color13}}', c14='{{color14}}', c15='{{color15}}',
}

local function hi(g, o)
    local cmd = 'hi ' .. g
    if o.fg then cmd = cmd .. ' guifg=' .. o.fg end
    if o.bg then cmd = cmd .. ' guibg=' .. o.bg end
    if o.gui then cmd = cmd .. ' gui=' .. o.gui end
    vim.cmd(cmd)
end

hi('Normal', {fg=c.fg, bg=c.bg})
hi('LineNr', {fg=c.c8})
hi('CursorLine', {bg=c.c0})
hi('CursorLineNr', {fg=c.c4, gui='bold'})
hi('Visual', {bg=c.c8})
hi('Search', {fg=c.bg, bg=c.c3})
hi('IncSearch', {fg=c.bg, bg=c.c4})
hi('StatusLine', {fg=c.fg, bg=c.c0})
hi('VertSplit', {fg=c.c8, bg=c.bg})
hi('Pmenu', {fg=c.fg, bg=c.c0})
hi('PmenuSel', {fg=c.bg, bg=c.c4})
hi('Comment', {fg=c.c8, gui='italic'})
hi('Constant', {fg=c.c1})
hi('String', {fg=c.c2})
hi('Number', {fg=c.c3})
hi('Function', {fg=c.c4})
hi('Statement', {fg=c.c5, gui='bold'})
hi('Operator', {fg=c.c6})
hi('Type', {fg=c.c3, gui='bold'})
hi('Error', {fg=c.c1, bg=c.bg})
hi('Todo', {fg=c.c3, bg=c.bg, gui='bold'})
hi('Directory', {fg=c.c4})
hi('Title', {fg=c.c4, gui='bold'})
