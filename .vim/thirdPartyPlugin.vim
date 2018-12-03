"#############################################################################
"                                Vundle Setup                                #
"#############################################################################
" Vundle Plugins 
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'octol/vim-cpp-enhanced-highlight' "Highlights c++ characters
Plugin 'git://git.wincent.com/command-t.git' " Fuzzy finder for faster searching
Plugin 'sjl/badwolf' " Really nice colorscheme
Plugin 'flazz/vim-colorschemes' " Stores all available colorschemes
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


"#############################################################################
"                                Pathogen setup                              #
"#############################################################################
"execute pathogen#infect()

"#############################################################################
"                                Variable Definition                         #
"#############################################################################
colorscheme badwolf
let g:badwolf_tabline=0
let g:badwolf_darkgutter=0

"#############################################################################
"                              netrw Settings(Nerdetree  alt)                #
"#############################################################################
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

"#############################################################################
"                                Plugin rameaps                              #
"#############################################################################
" Toggle NERDtree for file finding
nnoremap <C-n> :Vexplore<CR>
