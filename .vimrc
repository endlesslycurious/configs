set nocompatible
"source $VIMRUNTIME/vimrc_example.vim
behave xterm
syntax on

" highlight searches
set hlsearch

set backspace=indent,eol,start

if has('nvim')
    :tnoremap <Esc> <C-\><C-n> 
    set termguicolors
endif

set clipboard=unnamed

" mouse settings 
set selectmode=mouse
if !has('nvim')
    set ttymouse=xterm2
endif
set ttyfast
set mouse=a

" Tell me cursor positions
set ruler
set cursorline
set virtualedit=block

" No dings please, visual bell instead
set noerrorbells
set visualbell

" Write automatically
set autowriteall

" read automtacally on change
set autoread

" Set up fileformats
set fileformats=unix,dos

" make set list prettier
set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:+

" Match brackets
set showmatch
set matchtime=5

" default to incremental searching
set incsearch

" wild menu
set wildmenu
set wildignore=*.o,*.obj,*~,*.d

" Directory to put temp files in..
""set dir=c:/vim/temp
set undofile
if has("win32") || has("win64")
    set backupdir=c:/tmp
    set undodir=c:/tmp
    set pythonthreehome=C:/Users/ayounger/scoop/apps/python/current
    set pythonthreedll=C:/Users/ayounger/scoop/apps/python/current/python38.dll
else
    set backupdir=/tmp
    set undodir=/tmp
endif

" if has("gui_win32")
" elseif has("win32") || has("win64")
"     set makeprg=fb\ buildsln\ tool
"     "set shellpipe="|mtee "
" endif

" show line numbers
set number
set norelativenumber

" Ignore case in searches
set ignorecase
set viminfo='20,!,h,%

" Set up search path for tags
set tags=./tags,tags,../tags,../../tags,../../../tags,../../../../tags

" file search path... (recursively down (100 levels) from current directory)
set path=.**

" configure menu/toolbars
"set guioptions-=T	"" minus tool bar
"set guioptions-=m	"" minus menu bar
set guioptions=	" minus everything
set guioptions+=a

" Set up tabs of 4 & sensible C indentation
set tabstop=4
set shiftwidth=4
set expandtab
set cinkeys-=0#
set indentkeys-=0#
"set nostartofline

" Set up horizontal line wrapping (off) and scrolling
set nowrap
set sidescrolloff=16
set sidescroll=1

" always keep status bar up even when only one window
"set laststatus=2

" allow lazy redraws (makes macro's run faster)
set lazyredraw
"set noshowcmd " slow on macos terminal - 

" don't highlight long lines
set synmaxcol=1024

set linespace=0
set cmdheight=1

"----------------------------------------------------------------------------
" Custom keybindings
"----------------------------------------------------------------------------
" Only allow cursors in insert mode
" map <up> <nop>
" map <down> <nop>
" map <left> <nop>
" map <right> <nop>
" imap <up> <nop>
" imap <down> <nop>
" imap <left> <nop>
" imap <right> <nop>

" allow jj to escape insert mode
imap jj  <Esc>

" allow escape in terminal mode
" tnoremap <Esc><Esc> <C-\><C-n>

" remap leader
"let mapleader = " "

"Better window navigation
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-h> <C-w>h
" nnoremap <C-l> <C-w>l

"----------------------------------------------------------------------------
" show hide the menu bar
"----------------------------------------------------------------------------
nmap <silent> <S-F11> :set guioptions+=m<CR>
nmap <silent> <F11> :set guioptions-=m<CR>

"----------------------------------------------------------------------------
" minimal perforce integration
"----------------------------------------------------------------------------
if has("unix")
    nmap <silent> ,ce :execute ":!p4 edit " . resolve(expand("%:p")) . "&"<CR>
    nmap <silent> ,cr :execute ":!p4 revert " . resolve(expand("%:p")) . "&"<CR>
    nmap <silent> ,ca :execute ":!p4 add " . resolve(expand("%:p")) . "&"<CR>
else
    nmap <silent> ,ce :!start p4 edit %:p<CR>
    nmap <silent> ,cr :!start p4 revert %:p<CR>
    nmap <silent> ,ca :!start p4 add %:p<CR>
endif

"----------------------------------------------------------------------------
" Tab's
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <C-Tab> gt
nnoremap <C-S-Tab> gT
nnoremap tc :tabclose<CR>
nnoremap tn :tabnew<CR>
nnoremap <silent> tv :tabnew<CR>:e ~/_vimrc<CR>
nnoremap <silent> rv :so ~/_vimrc<CR>

"----------------------------------------------------------------------------
" RG search
if executable('rg')
    set grepprg=rg\ --vimgrep
elseif executable('ripgrep.rg')
    set grepprg=ripgrep.rg\ --vimgrep
elseif executable('pt')
    set grepprg=pt
endif

"----------------------------------------------------------------------------
" Ctrl-K - clang format block
if has('python')
    map <C-K> :pyf ~/zbd/bin/linux/clang-format.py<cr>
else
    map <C-K> :py3f ~/zbd/bin/linux/clang-format.py<cr>
endif

"----------------------------------------------------------------------------
" Custom file bindings
"----------------------------------------------------------------------------
au BufRead,BufNewFile *.ispc    :set filetype=cpp
au BufRead,BufNewFile *.ddf     :set filetype=cs
au BufRead,BufNewFile *.build 	:set filetype=xml
au BufRead,BufNewFile .clang-format 	:set filetype=yaml
au BufRead,BufNewFile .gdbinit  :set filetype=python
au BufRead,BufNewFile *.vert    :set filetype=glsl
au BufRead,BufNewFile *.frag    :set filetype=glsl

"au BufRead,BufNewFile *.md      :set filetype=markdown
"au BufRead,BufNewFile *.asciidoc :set filetype=asciidoc
"au BufRead,BufNewFile *.json	:set filetype=javascript

" au BufRead,BufNewFile *.cg		setfiletype cg
" au BufRead,BufNewFile *.fx		setfiletype cg
" au BufRead,BufNewFile *.glsl	setfiletype cg
" au BufRead,BufNewFile *.fxh		setfiletype cg
" au BufRead,BufNewFile *.hlsl	setfiletype cg

"au FileType python              setlocal sw=4 sts=4 et 
"au FileType cs                  setlocal sw=4 sts=4 et 
"au FileType cpp                 setlocal commentstring=//\ %s

"----------------------------------------------------------------------------
" PLUGIN SETUP
"----------------------------------------------------------------------------
" VimPlug
"----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

" Language plugins
    Plug 'davidhalter/jedi-vim', { 'for' : 'python' }
    Plug 'dcharbon/vim-flatbuffers'
    Plug 'fatih/vim-go', { 'for' : 'go' }
    Plug 'petrbroz/vim-glsl'
    Plug 'rust-lang/rust.vim', { 'for' : 'rs' }
    Plug 'tmux-plugins/vim-tmux'
    Plug 'uarun/vim-protobuf'
"	Plug 'pboettch/vim-cmake-syntax'
	Plug 'nickhutchinson/vim-cmake-syntax'
    Plug 'cespare/vim-toml'
    Plug 'yaymukund/vim-haxe'
    Plug 'leafo/moonscript-vim'

" Vim plugins..
    Plug 'drmikehenry/vim-fontsize'
    Plug 'easymotion/vim-easymotion'
    Plug 'jlanzarotta/bufexplorer' 
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/gv.vim'  " GV open commit browser, GV! currfile, GV? loclist tracks revisions
    Plug 'junegunn/rainbow_parentheses.vim'
    Plug 'kshenoy/vim-signature'  
    Plug 'machakann/vim-highlightedyank'
    Plug 'mh21/errormarker.vim'
    Plug 'nfvs/vim-perforce'
    Plug 'scrooloose/nerdtree'
    Plug 'sgur/vim-editorconfig'
    Plug 'skywind3000/asyncrun.vim'
    Plug 'tpope/vim-commentary' 
    Plug 'tpope/vim-fugitive' 
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-vinegar'        " original vinegar with NetWR
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes' 
    Plug 'vim-scripts/a.vim'
    Plug 'vim-scripts/ZoomWin'
    Plug 'will133/vim-dirdiff'
    Plug 'yegappan/mru'
"    Plug 'luochen1990/rainbow'
"    Plug 'majutsushi/tagbar'
"   Plug 'airblade/vim-gitgutter'
"   Plug 'ctrlpvim/ctrlp.vim'
"   Plug 'dhruvasagar/vim-vinegar' " vinegar with nerdtree
"   Plug 'huawenyu/neogdb.vim' 
"   Plug 'scrooloose/syntastic'
"   Plug 'tpope/vim-sleuth'    
"   Plug 'huawenyu/neogdb.vim' 

" colorschemes
    Plug 'altercation/vim-colors-solarized'
    Plug 'Badacadabra/vim-archery'
    Plug 'chriskempson/vim-tomorrow-theme'
    Plug 'cocopon/iceberg.vim'
    Plug 'dracula/vim'
    Plug 'emanuelrosa/badcat'
    Plug 'liuchengxu/space-vim-dark'
    Plug 'marciomazza/vim-brogrammer-theme'
    Plug 'morhetz/gruvbox'
    Plug 'NLKNguyen/papercolor-theme'
    Plug 'sjl/badwolf'
    Plug 'trusktr/seti.vim'
    Plug 'google/vim-colorscheme-primary'
    Plug 'tyrannicaltoucan/vim-deep-space'

call plug#end()

"----------------------------------------------------------------------------
" set colourscheme
if has("gui_macvim")
    set background=dark
    set guifont=Menio:h13
    colorscheme iceberg
elseif has("gui_win32")
    "    set background=dark
    set guifont=lucida_console:h12
    "    set guifont=Consolas:h13
    "    colorscheme PaperColor
    "    colorscheme badwolf
    "    colorscheme Tomorrow
    colorscheme Tomorrow-Night-Bright
    set rop=type:directx
elseif has("win32") || has("win64")
    colorscheme badwolf
else
    set background=dark
	set guifont=Monospace\ 18
    if $COLORTERM == 'gnome-terminal' || $VTE_VERSION >= '3803' || $TERM_PROGRAM == 'iTerm.app' || $TERM == 'xterm'
        set t_Co=256
        colorscheme badwolf
    else
        if &t_Co != 256
            colorscheme ansi_blows
        else
            colorscheme badwolf
        endif
    endif
endif
    
highlight LineNr guifg=#8f7f7F
highlight Comment guifg=purple ctermfg=red
highlight SpecialComment guifg=lightblue ctermfg=red
highlight PreProc guifg=cyan ctermfg=cyan
"highlight CursorLine guibg=#203020 ctermbg=purple
highlight HighlightedyankRegion ctermbg=237 guibg=#404040

augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cursorline
    autocmd WinLeave * set nocursorline
augroup END

"----------------------------------------------------------------------------
" editor config options (don't mess with fugitive)
let g:editorconfig_blacklist = {
    \ 'filetype': ['git.*', 'fugitive'],
    \ 'pattern': ['\.un~$']}

"----------------------------------------------------------------------------
" let g:jedi#completions_enabled=0

"----------------------------------------------------------------------------
"let g:rainbow_active=1
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

augroup rainbow_lisp
  autocmd!
  autocmd FileType lisp,clojure,scheme RainbowParentheses
augroup END

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

"----------------------------------------------------------------------------
" Nerd tree setup (F2)
noremap <silent> <F2> :NERDTreeFind<CR>
noremap <silent> <S-F2> :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1
let NERDTreeMinimalUI=1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeDirArrows=1
let NERDTreeShowHidden=1
let NERDTreeIgnore=[ '\.ncb$', '\.suo$', '\.vcproj\.RIMNET', '\.obj$',
                   \ '\.ilk$', '^BuildLog.htm$', '\.pdb$', '\.idb$',
                   \ '\.embed\.manifest$', '\.embed\.manifest.res$',
                   \ '\.intermediate\.manifest$', '^mt.dep$',
                   \ '\.swp$', '\.swo$' ]

"----------------------------------------------------------------------------
" Set MRU entries to beyond 100
let MRU_Max_Entries=2048

" Open MRU list in current window (not cw like window)
let MRU_Use_Current_Window=1

"----------------------------------------------------------------------------
" CtrlP
" let g:ctrlp_show_hidden = 1
" let g:ctrlp_max_depth = 40
" let g:ctrlp_max_files = 50000
" let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:100'
" let g:ctrlp_cmd = "CtrlPLastMode"
" if has("win32") || has("win64")
"     let g:ctrlp_user_command = {
"                 \ 'types': {
"                 \ 1: ['.git', 'cd %s && git ls-files'],
"                 \ 2: ['.hg', 'hg --cwd %s locate -I .'],
"                 \ },
"                 \ 'fallback': 'dir %s /-n /b /s /a-d'
"                 \ }
" else
"     let g:ctrlp_user_command = {
"                 \ 'types': {
"                 \ 1: ['.git', 'cd %s && git ls-files'],
"                 \ 2: ['.hg', 'hg --cwd %s locate -I .'],
"                 \ },
"                 \ 'fallback': 'find %s -type f'
"                 \ }
" endif

" let g:ctrlp_extensions = ['buffertag', 'line', 'dir' ] 
" nnoremap <leader>m :CtrlPMRUFiles<CR>
" nnoremap <leader>f :CtrlPCurWD<CR>
" nnoremap <leader>b :CtrlPBuffer<CR>
" nnoremap <leader>t :CtrlPTag<CR>

"----------------------------------------------------------------------------
" AsyncRun
command! -bang -nargs=* -complete=file Makee AsyncRun -auto=make -program=make @ <args>
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
command! -bang -nargs=* -complete=file Grep AsyncRun -program=grep @ <args>
:noremap <F9> :call asyncrun#quickfix_toggle(8)<cr>
:noremap <S-F9> :AsyncStop<cr>

"----------------------------------------------------------------------------
let g:gofmt_command="goimports"

"----------------------------------------------------------------------------
" AirLine
set noshowmode
let g:airline_colornum_enabled = 1
if has("gui_win32")
    let g:airline_powerline_fonts = 0
elseif has("win32") || has("win64")
    let g:airline_powerline_fonts = 0
else
    let g:airline_powerline_fonts = 1
endif

let g:airline#extensions#whitespace#checks = [ ] " 'indent', 'trailing' ]
let g:airline_theme="cool"
"let g:airline_theme="base16_harmonic16"
function! AirlineInit()
    let g:airline_section_y = airline#section#create(['ffenc', ' %{strftime("%H:%M")}'])
    let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])
endfunction
"let g:airline#extensions#tabline#enabled = 1
autocmd VimEnter * call AirlineInit()

"----------------------------------------------------------------------------
" FZF
" 
" pipe rg --files through fzf for fastest file find performance
"
nmap <silent> <F5> :call fzf#run({'source': 'rg --files --no-ignore-vcs', 'sink': 'e', 'options': '-m -x +s', 'down' : '40%'})<CR>

command! FZFM call fzf#run({
\  'source':  v:oldfiles,
\  'sink':    'e',
\  'options': '-m -x +s',
\  'down':    '40%'})

function! s:fzf_neighbouring_files()
  let current_file =expand("%")
  let cwd = fnamemodify(current_file, ':p:h')
  let command = 'rg --files "' .cwd.'" '

  call fzf#run({
        \ 'source': command,
        \ 'sink':   'e',
        \ 'options': '-m -x +s',
        \ 'window':  'enew' })
endfunction

command! FZFR call s:fzf_neighbouring_files()
