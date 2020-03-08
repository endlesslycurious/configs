"----------------------------------------------------------------------------
" Language stuff
language mes en 			" set message language to English.
set langmenu=en_US.UTF-8 	" set menu language to English.

"----------------------------------------------------------------------------
" Settings
set autoread 						" Auto read files changed outside VIM.
set clipboard=unnamed 				" Use system clipboard.
set cursorline 						" Highlight line the cursor is on.
set expandtab 						" Replace tabs with spaces automatically.
set guifont=Droid\ Sans\ Mono:h8 	" Set font & font size.
set guioptions+=b 					" Turn on horizontal scroll bar.
set guioptions-=a 					" Turn off auto clipboarding of selected text.
set guioptions-=m 					" Turn off GUI text menu options.
set guioptions-=T 					" Turn off GUI tool buttons.
set hlsearch 						" highlight search hits
set ignorecase 						" Ignore case in search patterns.
set nobackup 						" Don't make backup files, they confuse GIT.
set noswapfile 						" Disable'swap files' (eg. .myfile.txt.swp) from being created
set nowrap 							" Horizontal line wrapping off.
set nu 								" Line numbers on.

"----------------------------------------------------------------------------
" Search - use RG instead of grep
if executable('rg')
    set grepprg=rg\ --vimgrep
elseif executable('ripgrep.rg')
    set grepprg=ripgrep.rg\ --vimgrep
endif

"----------------------------------------------------------------------------
" Themes & colours
:syn on 				" Syntax highlighting turned on.
:colorscheme morning 	" Syntax highlighting colour scheme.

"----------------------------------------------------------------------------
" File handling
" Sensible setup for tabbing (none in python, tabs in everything else)
autocmd FileType * set tabstop=4|set shiftwidth=4|set noexpandtab
autocmd FileType build set tabstop=2|set shiftwidth=2|set expandtab
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType tpl set tabstop=2|set shiftwidth=2|set expandtab
autocmd FileType xml set tabstop=2|set shiftwidth=2|set expandtab

" associate *.build with xml filetype
au BufRead,BufNewFile *.build setfiletype xml
au BufRead,BufNewFile *.ddf   setfiletype cs

"----------------------------------------------------------------------------
" Key bindings
" FZF File Search, pipe rg --files through fzf for fastest file find performance
nnoremap <silent> <F2> :call fzf#run({'source': 'rg --files --no-ignore-vcs', 'sink': 'e', 'options': '-m -x +s', 'down' : '40%'})<CR>
" Show Most Recently Used file list
nnoremap <silent> <F3> :MRU<CR> 
" Show NERDTree explorer root on current file
nnoremap <silent> <F4> :NERDTreeToggle %<CR> 
" Paste current file path to system clipboard  
nnoremap <silent> <F5> :let @+=expand("%:p")<CR>
" Set current working directory to that of current file
nnoremap <silent> <F6> :lcd %:p:h<CR>
" Open buffer list with FZF search
nnoremap <silent> <F7> :Buffers<CR>
 
"----------------------------------------------------------------------------
" Plugins managed by Plug
call plug#begin('~/vimfiles/plugged')

Plug 'junegunn/fzf' 					" FZF - fuzzy file finder integration
Plug 'junegunn/fzf.vim' 				" FZF - fuzzy file finder advanced functionality
Plug 'junegunn/rainbow_parentheses.vim' " Rainbow Parentheses
Plug 'nfvs/vim-perforce' 				" Perforce integration
Plug 'scrooloose/nerdtree' 				" NERDTree - directory browser
Plug 'vim-airline/vim-airline' 			" Airline - status bar
Plug 'vim-scripts/a.vim' 				" Open alternate .cpp/.h file
Plug 'yegappan/mru' 					" MRU - recently used files

" Initialize plugin system
call plug#end()

"----------------------------------------------------------------------------
" Rip Grep
let g:rg_highlight = 1
let g:rg_derive_root = 1

"----------------------------------------------------------------------------
" MRU
let MRU_Max_Entries=1024 " 1k file history

"----------------------------------------------------------------------------
" Nerd Tree
let NERDTreeDirArrows=1
let NERDTreeShowHidden=1
let NERDTreeIgnore=[ '\.ncb$', '\.suo$', '\.vcproj\.RIMNET', '\.obj$',
                   \ '\.ilk$', '^BuildLog.htm$', '\.pdb$', '\.idb$',
                   \ '\.embed\.manifest$', '\.embed\.manifest.res$',
                   \ '\.intermediate\.manifest$', '^mt.dep$',
                   \ '\.swp$', '\.swo$' ]

"----------------------------------------------------------------------------
" Rainbow Parentheses
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

augroup rainbow_c
  autocmd!
  autocmd FileType c,cpp,cs,java RainbowParentheses
augroup END

augroup rainbow_go
  autocmd!
  autocmd FileType go RainbowParentheses
augroup END

augroup rainbow_py
  autocmd!
  autocmd FileType py,python RainbowParentheses
augroup END
