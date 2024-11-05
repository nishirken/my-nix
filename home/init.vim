set tabstop=2
set shiftwidth=2
set expandtab
let mapleader = '\\'

set termguicolors
colorscheme gruvbox-material
let g:airline_theme='base16'

" restore alacritty cursor
augroup RestoreCursorShapeOnExit
  autocmd!
  autocmd VimLeave * set guicursor=a:ver15:blinkwait750-blinkoff750-blinkon750
augroup END

" coc settings
set updatetime=1000

nnoremap <silent> gd :call CocAction('jumpDefinition', 'tab drop')<CR>
nnoremap <silent> gtd :call CocAction('jumpTypeDefinition', 'tab drop')<CR>
nnoremap <silent> gi :call CocAction('jumpImplementation', 'tab drop')<CR>
nmap <silent> gr <Plug>(coc-references)

" select suggestion by enter
inoremap <silent><expr> <CR>
  \ coc#pum#visible() ? coc#pum#confirm() :
  \ "\<CR>"

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" to show documentation in preview window
nnoremap <silent> gh :call CocActionAsync('doHover')<CR>

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

"lua << EOF
"require('haskell-tools').setup {
"  tools = {
"    log = {
"      level = vim.log.levels.DEBUG,
"    },
"  },
"}
"EOF
