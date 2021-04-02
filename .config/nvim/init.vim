set number

syntax enable
set termguicolors
colorscheme oblivion

set ts=4 sts=4 sw=4 expandtab

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ap/vim-css-color'
Plug 'preservim/nerdtree'

call plug#end()

" COC
" Make <Tab> used for trigger completion, completion confirm, snippet expand and jump
inoremap <silent><expr> <TAB>
       \ pumvisible() ? coc#_select_confirm() :
       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
       \ "<TAB>"

let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<S-tab>'

" Close the preview window when completion is done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" NERDTree 
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Paste mode
set pastetoggle=<F3>
