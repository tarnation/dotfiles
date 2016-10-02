" Tell pathogen to load plugins from the bundle directory.
" Use this array to disable loading any bundles, none disabled for now.
"let g:pathogen_disabled = ['vim-autoclose', 'vim-snipMate']
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
set nocompatible         " don't worry about being compatible with vi
set backspace=indent,eol,start
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set nohlsearch
set number
set visualbell
set ignorecase smartcase
set guioptions=aegtc
set mouse=a
set wildmode=list:longest
set nobackup
set nowrap
set hidden
set cpo+=d            " use tags file relative to CWD, not file
set completeopt=menu,menuone,longest
set tags=./tags/all   " use exuberant ctags for completion, lookup
set gdefault
set ts=4
set shiftwidth=4
set expandtab
set background=dark
"set background=light
:colorscheme Tomorrow-Night
":colorscheme solarized
:filetype plugin on
" map CTRL-e to EOL (insert)
imap <C-e> <esc>$i<right>
" Open new tab with Ctrl-o
noremap <c-o> :tabe<cr>
" Toggle line numbering
noremap <F7> :set nu!<CR>:set nu?<CR>
" Horizontal split nav
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
" Vertical split nav
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
" Tab nav, C-n/m
noremap <C-m> :bn<CR>
noremap <C-n> :bp<CR>
" Quick escap = vv
inoremap vv <ESC>
" Quickly edit/reload the .vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
" Tab jumps to matching brackets
nnoremap <tab> %
vnoremap <tab> %

let mapleader = ","   " custom commands start with ,

" Hopefully gives me arrow keys again when editing sql files.
let g:omni_sql_no_default_maps = 1

" for airline
set laststatus=2

"Syntastic
let g:syntastic_php_checkers=['php', 'phpcs']
let g:syntastic_php_phpcs_args="--standard=/home/lance/ClockworkStandard/Clockwork --report=csv"
let g:syntastic_python_checkers=['python', 'flake8']

"SnipMate
let g:snips_author = 'Lance Erickson <lance@clockwork.net>'

"Tagbar
nmap <c-\> :TagbarToggle<CR>
let g:tagbar_sort = 0
let g:tagbar_foldlevel = 0
let g:tagbar_width = 40
let g:tagbar_ctags_bin = 'ctags'

"Keep CtrlP using amm root
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_clear_cache_on_exit = 0

"NERDtree
map <C-q> :NERDTreeToggle<CR>

"Clipper - send to Mac clipboard
noremap <leader>y :call system('nc localhost 21212', @0)<CR>

" Stolen from Clockwork blog
:command SvnDiff :vert diffsplit %:h/.svn/text-base/%:t.svn-base

" Switch syntax highlighting on, when the terminal has colors
syntax on

" Display indent helpers
" Group Names: Comment Constant Identifier Statement
" 	PreProc Type Special Underlined Error Normal
" DISPLAY SOME SPECIAL CHARS
" tab, trail(ing spaces), eol
set list
set listchars=tab:.\ ,trail:~
" Some color preferences
hi NonText ctermfg=DarkGray


" Some alignment jiggery
source ~/.vim/plugin/AlignPlugin.vim
source ~/.vim/plugin/AlignMapsPlugin.vim
map <C-a> vip:Align<cr>

" Only do this part when compiled with support for autocommands.
if has("autocmd")

	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
	filetype plugin indent on

	" Put these in an autocmd group, so that we can delete them easily.
	augroup vimrcEx
		au!

		" For all text files set 'textwidth' to 78 characters.
		autocmd FileType text setlocal textwidth=78

		" AMM alignment style
		autocmd FileType php call Align#AlignCtrl( 'Wp2P2l:','=>','=' )

    " Expand tabs for python
    autocmd FileType python setlocal et

    " Elm
    autocmd FileType elm setlocal et ts=2 sw=2
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1

    let g:elm_syntastic_show_warnings = 1

    " Js
    autocmd FileType js setlocal et ts=2 sw=2

    " Apache files in shared checkout AMMs
    autocmd BufNewFile,BufRead */conf/httpd/*.conf* set syntax=apache

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif

	augroup END

else
	set autoindent "always on
endif
