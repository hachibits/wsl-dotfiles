call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'

call plug#end()

ru! defaults.vim                " Use Enhanced Vim defaults
set mouse=                      " Reset the mouse setting from defaults
aug vimStartup | au! | aug END  " Revert last positioned jump, as it is defined below
let g:skip_defaults_vim = 1     " Do not source defaults.vim again (after loading this system vimrc)

set ignorecase
set smartcase
set incsearch
set cursorline
set ruler
set nu
set ai                          " set auto-indenting on for programming
set modeline
set bs=2
set ls=2
set showmatch                   " automatically show matching brackets. works like it does in bbedit.
set vb                          " turn on the "visual bell" - which is much quieter than the "audio blink"
set laststatus=2                " make the last line where the status is two lines deep so you can see status always
set showmode                    " show the current mode
set clipboard=unnamed           " set clipboard to unnamed to access the system clipboard under windows
set wildmode=list:longest,longest:full   " Better command line completion

if &term =~ 'xterm-256color'    " mintty identifies itself as xterm-compatible
  if &t_Co == 8
    set t_Co = 256              " Use at least 256 colors
  endif
  " set termguicolors           " Uncomment to allow truecolors on mintty
endif

" Text, tabs and indent related
set ts=2 sw=2 sts=2
set expandtab
set autoindent
set smartindent

set t_Co=256
let g:seoul256_background = 233
colo seoul256

hi statusline ctermfg=15 guifg=white ctermbg=NONE guibg=NONE

function! s:statusline_expr()
  let mod="%m"
  let ro="%{&readonly ? '[RO]' : ''}"
  let ft="%{len(&filetype) ? '['.&filetype.']' : ''}"
  let ff="\ [%{&ff}]"
  let fug="%{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}"
  let sep="%="
  let pos="%-12(%l : %c%V%)"
  let pct='%P'

  return '[%n] %F %<'.mod.ro.ft.ff.fug.sep.pos.'%*'.pct
endfunction

let &statusline=s:statusline_expr()
"------------------------------------------------------------------------------
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Set UTF-8 as the default encoding for commit messages
    autocmd BufReadPre COMMIT_EDITMSG,MERGE_MSG,git-rebase-todo setlocal fileencoding=utf-8

    " Remember the positions in files with some git-specific exceptions"
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$")
      \           && &filetype !~# 'commit\|gitrebase'
      \           && expand("%") !~ "ADD_EDIT.patch"
      \           && expand("%") !~ "addp-hunk-edit.diff" |
      \   exe "normal! g`\"" |
      \ endif

      autocmd BufNewFile,BufRead *.patch set filetype=diff

      autocmd Filetype diff
      \ highlight WhiteSpaceEOL ctermbg=red |
      \ match WhiteSpaceEOL /\(^+.*\)\@<=\s\+$/
endif " has("autocmd")
set t_u7=
