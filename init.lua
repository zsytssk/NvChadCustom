vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.list = true
vim.opt.listchars = { space = "⋅", tab = "--" }
vim.opt.cmdheight = 1
vim.opt.spelllang = "en,cjk"
vim.opt.spell = true
vim.opt.swapfile = false
vim.opt.spelloptions = "camel"

vim.cmd "autocmd User TelescopePreviewerLoaded setlocal number"
vim.cmd "autocmd VimEnter,VimLeave * silent !tmux set status"
vim.cmd "autocmd VimResized * wincmd ="
