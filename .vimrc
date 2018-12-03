set shell=bash\ -i
" Vim Colorscheme Settings
"#############################################################################
"                        Color scheme setup for vim                          #
"#############################################################################
set t_Co=256 " Allows for vim to support colorschemes in putty
set t_BE=
set colorcolumn=80

"#############################################################################
"                                Third Party Setup                           #
"#############################################################################
function! SourceIfExists(file)
if filereadable(expand(a:file))
  exe 'source' a:file
endif
endfunction

" Third party setup must be done first to prevent overwritting setup
call SourceIfExists("~/.vim/thirdPartyPlugin.vim")

"#############################################################################
"                                Environemnt Setup                           #
"#############################################################################
syntax enable " Indents to format for corresponding filetype
filetype indent on " Indents to format for corresponding filetype

set showcmd " Shows the command that was typed in
set tabstop=2 " Set tabs to to spaces.
set shiftwidth=2
set expandtab
set showmatch "Matches the corresponding open or closing bracket
set wildmenu " Provides options for autocompletion
set incsearch " Automatically starts searching for characters
set hlsearch " Lets you see the items you've searched
set ignorecase " Vim Automatically searches case insensitive
set smartcase " Becomes case sensitive if you search an upper case letter
set splitright " Moves new vim windows to the right
set splitbelow " Moves new horizantal windows to the bottom
set cindent " Allows cindentation
set nostartofline " Doesn't move to the beginning on big jumps
set cinoptions=
set cinoptions+=g0 " prevents private and public from being autotabbed
" This sets formatting so that function arguements align when on next line
set cinoptions+=(0
" No namespace indenting
set cinoptions+=N-s
" This sets class inheritence to be after the ":"
"set cinoptions+=i0
" Sets the case to be aligned with the switch i
set cinoptions+=:0
"set cinoptions+={-1s
set number relativenumber " Makes it so you can see the line numbers
set autochdir " Automatically make the open buffer the curr directory
set autoread
set bs=indent,eol,start		" allow backspacing over everything in insert mode
set fileformats=unix

"#############################################################################
"                                Basic nonfunctonal remaps                   #
"#############################################################################
" Vim Shortcuts
" Set local leader to space
let mapleader="\\"
map <space> \

" Escapes instead of using escape key
inoremap jk <Esc>

vnoremap u <NOP>
vnoremap U <NOP>

" Jump to beginning of line
nnoremap H ^
vnoremap H ^

" Jump to end of line
nnoremap L $
vnoremap L $

" Jump to end of line
nnoremap Y y$
vnoremap Y $y

" Prevent upper case K from doing lookups
nnoremap K <nop>
vnoremap K <nop>

" Automagically format my paste.
noremap p ]p
noremap P ]P

vnoremap <C-c> "+y
vnoremap <C-x> "+d

inoremap <C-a> <ESC>"+pa
vnoremap <C-a> "+]P
nnoremap <C-a> "+]P

" Change word to upper case
inoremap <C-u> <ESC>bveUea

""" Format inside of a block of curlies
nnoremap <leader>f mzvi{='zzz
""" Format the entire document and clear out trailing white space.
nnoremap <leader>F mzggvG='zzz

""" Search for visually selected text. Useful when not a Word
vnoremap // y/<C-R>"<CR>

""" Selects an entire line if the search item is inside of it
vnoremap <leader>/ y/.\+<C-R>".\+\n<CR>

""" Remap auto complete to Ctrl-Space
inoremap <c-space> <c-p>

"#############################################################################
"                            Basic functional reamps                         #
"#############################################################################
" Save application with good old <C-S>
noremap <silent> <C-S> :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O> <ESC>:update<CR>

" Clear searches
nnoremap <leader><space> :nohlsearch <CR>

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

""" Movement commands. Move to in parenthsis
onoremap np :<c-u>normal! f(vi(<cr>
onoremap lp :<c-u>normal! F(vi(<cr>

""" Clear the white space from a file
nnoremap <leader>cw mz:%s/\s\+$//g<cr>'zzz

""" Opens up a new terimnal vertically
nnoremap <leader>t :vert terminal<CR>

""" C language only. Change function arguements
""" Normall upper case indicates going to last, however it is unlinkely that
""" you will be searching forward. Usually you will be in the function of
""" interest
onoremap Fa :<c-u>execute "normal! /^\\(\\(::\\)\\=\\w\\+\\(\\s\\+\\)\\=\\)\\{2,}([^!@#$+%^]*)\r:nohlsearch\rf(vi("<cr>
onoremap fa :<c-u>execute "normal! ?^\\(\\(::\\)\\=\\w\\+\\(\\s\\+\\)\\=\\)\\{2,}([^!@#$+%^]*)\r:nohlsearch\rf(vi("<cr>


" User Functions
" Most of the functions I write will be defined here
call SourceIfExists("~/.vim/iroPlugin.vim")
