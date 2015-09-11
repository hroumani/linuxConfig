" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set smarttab
set expandtab
set smartindent
filetype indent on
set tabstop=4
set shiftwidth=4
set cmdheight=2
set textwidth=79

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=100		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Don't like visual mode!
set mouse-=a

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

set autoindent		" always set autoindenting on
set smartindent

" Set nice colors
" background for normal text is light grey
" Text below the last line is darker grey
" Cursor is green
" Constants are not underlined but have a slightly lighter background
  highlight Normal guibg=grey95
 highlight Cursor guibg=Red guifg=NONE
 highlight Visual guifg=Sys_HighlightText guibg=Sys_Highlight gui=NONE
  highlight NonText guibg=grey90
  highlight Constant gui=NONE guibg=grey95
  highlight Special gui=NONE guibg=grey95

"if has("gui_running")
"if &columns < 90 && &lines < 32
"   win 90 32 
    au GUIEnter * win 90 32 
"  endif
"  " Make external commands work through a pipe instead of a pseudo-tty
"  set noguipty
"endif

" Map control-cr to goto new line without comment leader
imap <C-CR> <ESC>o



" Look at syntax attribute
"nmap <F4> :echo synIDattr(synID(line("."), col("."), 1), "name")<CR>
"nmap <S-F4> :echo synIDattr(synID(line("."), col("."), 0), "name")<CR>
" delete the swap file
" nmap \\. :echo strpart("Error  Deleted",7*(0==delete(expand("%:p:h")."/.".expand("%:t").".swp")),7)<cr>

" delete prev word
" imap <C-BS> <c-w>

"  set joinspaces 

nnoremap <cr> :noh <cr>


set wildmenu
set showfulltag
set display+=lastline
set printoptions=syntax:y,wrap:y

" Switch on syntax highlighting.
syntax on

set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)\ -\ %{v:servername}
set title titlestring=VIM:\ \ %t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)%{v:servername}%=%l/%L titlelen=70
set title
set background=dark
" map <F12> :let &background = ( &background == "dark"? "light" : "dark" )<CR>

set pastetoggle=<F12>
set ignorecase
set smartcase

set whichwrap=h,l,~,[,]
noremap <Space> <PageDown>

nnoremap . :next<CR>
nnoremap , :prev<CR>

" set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]
set scrolloff=999
set showmatch
set hlsearch
set incsearch
set mat=5

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
  " autocmd FileType text setlocal textwidth=79

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent     " always set autoindenting on

endif " has("autocmd")

"set list listchars=trail:_
" highlight SpecialKey ctermfg=DarkGray ctermbg=yellow


"highlight RedundantSpaces ctermbg=blue guibg=blue
"   match RedundantSpaces /\s\+$\| \+\ze\t\|\^\t/

set listchars=tab:>-
set list

highlight RedundantSpaces ctermbg=blue guibg=blue
match RedundantSpaces /\s\+$\| \+\ze\t\|\^\t/




autocmd FileType c,cpp,slang set cindent
autocmd FileType c set formatoptions+=ro
autocmd FileType perl set smartindent

nnoremap <silent> <F5> :TlistToggle<CR>
nnoremap <silent> <F6> :TlistOpen<CR>


if has("cscope")
    set csprg=/wsdb/oemtools/linuxamd64/bin/cscope-15.5
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb
else
    echo "no cscope"
endif

set tags=/vbs/engn/cscope/tags

au BufNewFile,BufRead LATEST set filetype=cpp






" Dictionary stuff... leave at end of file ... stupid syntax highlighting.

" nmap <F7> :!echo <C-r><C-w> \| aspell -a<CR>

nnoremap \sc :call SpellSuggest()<CR>
nmap <silent><F7> \sc

function! SpellSuggest()
  let s = substitute(system("echo ".expand("<cword>")." | aspell -a -W2 | grep '^&'"), "^.*:\\s\\(.*\\)\\n", "\\1,", "")
  if s != ""
    let slength = strlen(s)
    let end = 0
    let i = 0
    while end != slength
      let i = i + 1
      let w = matchstr(s, "^\\%(.\\{-}\\zs[^ ,]\\+\\ze,\\)\\{".i."}")
      echon "(".i.")".w." "
      let end = matchend(s, w.",")
    endwhile
    echo ""
    let c = input("Replace with: ")
    if c =~ "^[1-9]\\d*$" && c > 0 && c <= i
      execute "normal! ciw".matchstr(s, "^\\%(.\\{-}\\zs[^ ,]\\+\\ze,\\)\\{".c."}")
    endif
  else
    echo 'Spelling is fine or no suggestions'
  endif
endfunction


map <F11> :w!<CR>:!aspell --mode "ccpp" check %<CR>:e! %<CR>


let PersonalDict = '~/.aspell.en.pws'

nnoremap \sa :call AddWordToDictionary()<CR><CR>
nmap <silent><F10> \sa

function! AddWordToDictionary()
  " get the word under the cursor, including the apostrophe as a word character
  " to allow for words like "won't", but then ignoring any apostrophes at the
  " start or end of the word:
  set iskeyword+='
  let Word = substitute(expand('<cword>'), "^'\\+", '', '')
  let Word = substitute(Word, "'\\+$", '', '')
  set iskeyword-='

  " override any SpellError highlighting that might exist for this word,
  " `highlighting' it as normal text:
  execute 'syntax match Normal #\<' . Word . '\>#'

  " remove any final "'s" so that possessive forms don't end up in the
  " dictionary, then add the word to the dictionary:
  let Word = substitute(Word, "'s$", '', '')
  execute '!echo "' . Word . '" >> ' . g:PersonalDict

endfunction " AddWordToDictionary()



nnoremap \sh :call HighlightSpellingErrors()<CR><CR>
nmap <silent><F8> \sh
nnoremap \su :call Unhighlight()<CR>
nmap <silent><F9> \su

function! Unhighlight()
   syntax clear SpellError
   syntax on
   return
endfunction

set backupdir=~/.vim_backup

function! HighlightSpellingErrors()
    syntax off 
    if hlexists('SpellError')
      syntax clear SpellError
    endif
    if hlexists('Normal')
      syntax clear Normal
    endif

    let PipeCmd = 'write !'
    if &filetype == 'mail'
      let PipeCmd = PipeCmd . ' grep -v "^> " | grep -E -v "^[[:alpha:]-]+:" |'
    endif

  " execute that command, then generate a unique list of misspelt words and
  " store it in a temporary file:
  let ErrorsFile = tempname()
  execute PipeCmd . ' run-with-aspell ispell -l ' .
    \ ' | sort | uniq > ' . ErrorsFile

  " open that list of words in another window:
  execute 'split ' . ErrorsFile

  " for every word in that list ending with "'s", check if the root form
  " without the "'s" is in the dictionary, and if so remove the word from the
  " list:
  global /s$/ execute 'read ! echo ' . expand('<cword>') .
    \ ' | run-with-aspell ispell -l ' | delete
  " (If the root form is in the dictionary, ispell -l will have no output so
  " nothing will be read in, the cursor will remain in the same place and the
  " :delete will delete the word from the list.  If the root form is not in the
  " dictionary, then ispell -l will output it and it will be read on to a new
  " line; the delete command will then remove that misspelt root form, leaving
  " the original possessive form in the list!)

  " only do anything if there are some misspellings:
  if strlen(getline('.')) > 0

    " turn each mistake into a `Vim' command to place it in the SpellError
    " syntax highlighting group:
    % substitute /^/syntax match SpellError !\\</
    % substitute /$/\\>!/
  endif

  " save and close that file (so switch back to the one being checked):
  exit

  " make syntax highlighting case-sensitive, then execute all the match
  " commands that have just been set up in that temporary file, delete it, and
  " highlight all those words in red:
  syntax case match
  execute 'source ' . ErrorsFile
  call delete(ErrorsFile)
  highlight SpellError term=reverse cterm=bold
  highlight SpellError ctermfg=7 ctermbg=1 guifg=Red guibg=White
endfunction " HighlightSpellingErrors()

