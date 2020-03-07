if has("mac")
	language mes C " set message language to English.
else
	language mes en " set message language to English.
endif
set langmenu=en_US.UTF-8 " set menu language to English.

set nu " Line numbers on.
set nowrap " Horizontal line wrapping off.
set guifont=Droid\ Sans\ Mono:h10 " Set font & font size.
set ignorecase " Ignore case in search patterns.
set expandtab " Replace tabs with spaces automatically.
set nobackup " Don't make backup files, they confuse GIT.
set noswapfile "Disable'swap files' (eg. .myfile.txt.swp) from being created
"set colorcolumn=120 " Highlight column 80.
set cursorline " Highlight line the cursor is on.
set autoread " Auto read files changed outside VIM.
set guioptions-=T " Turn off GUI tool buttons.
set guioptions-=m " Turn off GUI text menu options.
set guioptions+=b " Turn on horizontal scroll bar.
set guioptions-=a " Turn off auto clipboarding of selected text.
set clipboard=unnamed " Use system clipboard.

:syn on " Syntax highlighting turned on.
:colorscheme desert " Syntax highlighting colour scheme.

" Sensible setup for tabbing (none in python, tabs in everything else)
autocmd FileType * set tabstop=4|set shiftwidth=4|set noexpandtab
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType xml set tabstop=2|set shiftwidth=2|set expandtab
autocmd FileType build set tabstop=2|set shiftwidth=2|set expandtab

" associate *.build with xml filetype
au BufRead,BufNewFile *.build setfiletype xml


" Install VIM-Plug if its not installed already
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins managed by Plug
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/vimfiles/plugged')

" Airline
Plug 'https://github.com/vim-airline/vim-airline'

" NERDTree, toggle bound to F4 key
Plug 'https://github.com/scrooloose/nerdtree'
map <F4> :NERDTreeToggle<CR>

" ctrlp search
Plug 'https://github.com/ctrlpvim/ctrlp.vim'

" Arsenys QGrep
" Plug 'https://github.com/zeux/qgrep', {'rtp': 'vim'}

" MRU file list
Plug 'https://github.com/yegappan/mru'

" Initialize plugin system
call plug#end()

" Configure ripgrep with ctrlp
if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif
