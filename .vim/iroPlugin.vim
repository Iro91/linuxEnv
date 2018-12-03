"#############################################################################
"                             Function definitions                           #
"#############################################################################
" Moves the cursor to the center of the line
function! LineCenter()
  call cursor(0,len(getline('.'))/2)
endfun

" Open file through perforce and mark it as writeable.
" The second line is for when perforce tries to make you reload and you are
" not having it.
function! P4Open()
  "! p4 open resolve(expand("%")) 
  ! p4 open %
  w! %
  e! %
endfun

" Mark unwritable file for writing
function! MarkForWrite()
  w! %
  !chmod +w %
endfun

" Brazenly stolen from CurineIncSw. Slight modifications made so that
" switching filles when not found doesn't crash. Original can be found here:
" Also added ability to follow symbolic links. I foudn that annoying.
" Plugin 'ericcurtin/CurtineIncSw.vim' " Let's you switch files
function! FindInc()
  let dirname=fnamemodify(expand("%:p"), ":h")
  let cmd="find -L . " . dirname . " -type f -iname " . t:IncSw . " | head -n1 | tr -d '\n'"
  echom cmd
  let findRes=system(cmd)

  if &mod == 1
    echo "ERROR: FILE HAS BEEN MODIFIED, PLEASE SAVE OR DISCARD TO CONTINUE"
  else
    exe "e " findRes
  endif
endfun

function! CurtineIncSw()
  if match(expand("%"), '\.c') > 0
    let t:IncSw=substitute(expand("%:t"), '\.c\(.*\)', '.h*', "")
    call FindInc()
  elseif match(expand("%"), "\\.h") > 0
    let t:IncSw=substitute(expand("%:t"), '\.h\(.*\)', '.c*', "")
    call FindInc()
  else
    echo "No Matching c/h file found"
  endif

endfun

" Qt indentation function 
function! QtCppIndent()
" Patterns used to recognise labels and search for the start
" of declarations
let labelpat='signals:\|slots:\|public:\|protected:\|private:\|Q_OBJECT'
let declpat='\(;\|{\|}\)\_s*.'
" If the line is a label, it's a no brainer
if match(getline(v:lnum),labelpat) != -1
  return 0
endif
" If the line starts with a closing brace, it's also easy: use cindent
if match(getline(v:lnum),'^\s*}') != -1
  return cindent(v:lnum)
endif
" Save cursor position and move to the line we're indenting
let pos=getpos('.')
call setpos('.',[0,v:lnum,1,0])
" Find the beginning of the previous declaration (this is what
" cindent will mimic)
call search(declpat,'beW',v:lnum>10?v:lnum-10:0)
let prevlnum = line('.')
" Find the beginning of the next declaration after that (this may
" just get us back where we started)
call search(declpat,'eW',v:lnum<=line('$')-10?v:lnum+10:0)
let nextlnum = line('.')
" Restore the cursor position
call setpos('.',pos)
" If we're not after a label, cindent will do the right thing
if match(getline(prevlnum),labelpat)==-1
  return cindent(v:lnum)
" It will also do the right thing if we're in the middle of a
" declaration; this occurs when we are neither at the beginning of
" the next declaration after the label, nor on the (non-blank) line
" directly following the label
elseif nextlnum != v:lnum && prevlnum != prevnonblank(v:lnum-1)
  return cindent(v:lnum)
endif
" Otherwise we adjust so the beginning of the declaration is one
" shiftwidth in
return &shiftwidth
endfunc

"#############################################################################
"                             Autocommand Section                            #
"#############################################################################
autocmd BufRead *.h :setlocal indentexpr=QtCppIndent()

autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

" Every so often checks if the file has changed. If it has, it reloads the
" page
au CursorHold * checktime

" By default keep all files unfolded and focuses on the last line selected
autocmd BufRead * normal zRzz
" This is super cool, removes relative number on entry
autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber

"#############################################################################
"                             Functional Remaps                              #
"#############################################################################

" Switch cpp and h file
noremap <C-h> :call CurtineIncSw()<CR> zz

" Jump to line center
nnoremap gm :call LineCenter() <CR>

""" Open file explorer in new window
noremap  <silent> <C-o> :call P4Open()<CR>

""" Chmod +w to a file
nnoremap <leader>u :call MarkForWrite()<CR>

