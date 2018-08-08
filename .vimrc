" Matt Spilchen's .vimrc file

nnoremap . :next<CR>
nnoremap , :prev<CR>

" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = []

call add(g:pathogen_disabled, 'python-mode')

execute pathogen#infect()
execute pathogen#helptags()
syntax on
filetype plugin indent on

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

set bg=dark

" Change to the directory of the current file.
set autochdir

set expandtab
set shiftwidth=3
set tabstop=3

"set relativenumber
" set number

set ignorecase
set scrolloff=999
set nowrapscan
set nocompatible
set expandtab
set noswapfile

:let g:notes_directories = ['~/vimnotes']

" Don't print out any messages when loading the cscope database
set nocsverb

" Add the cscope database that is produced by ~/bin/mkscope
if filereadable('~/cscope/bluoltp_engine')
  cscope add ~/cscope/bluoltp_engine
endif

" Load the color information for this machine
source $HOME/.vimrc.color

" F9 will toggle whether pasted text will be formatted or not
" set pastetoggle=<C-G>
set pastetoggle=<F12>

" Generate the tag list
"map <F7> <ESC>:TlistToggle<CR>
map <F7> <ESC>:TagbarToggle<CR>

" Don't get a warning message to read in config file for YouCompleteMe
let g:ycm_confirm_extra_conf = 0
" Controls where to open when using the GoTo* commands.
let g:ycm_goto_buffer_command = 'new-or-existing-tab'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
" Mapping to use YcmCompleted.  Jump to definition or declaration of the type
" under the cursor.
" Show the date type declaration under the cursor
nnoremap <leader><leader>d :YcmCompleter GoTo<CR>
" Show the date type declaration under the cursor
nnoremap <leader><leader>t :YcmCompleter GetType<CR>
" Show the documentation about the identifier under the cursor.
nnoremap <leader><leader>y :YcmCompleter GetDoc<CR>
" Force a recompile of the current file
nnoremap <leader><leader>f :YcmForceCompileAndDiagnostics<cr>
" Show YCM diagnostics for current file
nnoremap <leader><leader>i :YcmDiags<cr>

" Parenthesis highlighing gives me headaches.  Disable it.
" let loaded_matchparen = 1

" Don't show different color past 80 charaters
set colorcolumn=+100

" Don't highlight searched text
set nohlsearch
set hlsearch
set incsearch
set wrapscan

" Only search when you hit enter
" set noincsearch

" Do not show the ATTENTION message when an existing swap file is found.
" " I disable this so that the autoproto plugin will not get an error when
" " opening a file in the preview window.
set shortmess+=A

" Don't leave swap files in the current directory.  This causes git to see
" them if the extension is not ignored.
set dir=~/tmp/vimswap

" Bind keys to enforce the clang-format we use with the project
map <C-K> :ClangFormat<cr>
let g:clang_format#auto_format = 1

"
"
" Tell CtrlP to initially use the current working directory
let g:ctrlp_working_path_mode = 'c'
" Tell CtrlP that when C-P is pressed to open the MRU window first.  Note you
" can do <C-F> and <C-B> to cycle through the different modes.
let g:ctrlp_cmd = 'CtrlPMRU'

" Turn off command completion for python rope
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0

" Make vim-expand-region easier to use
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Dark background for this theme
highlight Normal ctermbg=None

" z= to spell correct suggest
map <C-F> :setlocal spell! spelllang=en_us<CR>

" Large GIT DIFF buffer for diffs
let g:gitgutter_max_signs = 2500

let g:pymode_python='python'

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>
