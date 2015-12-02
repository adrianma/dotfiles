" adma <adrian.martinezgomez@u-blox.com>
"

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" set indentation to four spaces
set shiftwidth=4
set tabstop=4       " number of visual spaces per TAB
set expandtab      " tabs are spaces
" show line numbers
set number
" highlight tabs and trailing spaces
set listchars=tab:>\ ,trail:_
set list

let mapleader="\<Space>"

" allow mouse for all modes
set mouse=a

" command maps // to search selected text in visual mode
vnoremap // y/<C-R>"<CR>

" make vim automatically refresh any unchanged files
set autoread

" visual autocomplete for command menu
set wildmenu

"""""""""""""""""""" NeoBundle manager

set runtimepath+=~/.vim/bundle/neobundle.vim
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here...
" 1) This one searches from within vim (in c++ and c files)
NeoBundle 'mileszs/ack.vim.git'
noremap <Leader>a :Ack --cpp --cc <cword><CR>

" Map the opening of NERDTree to Ctrl+n
map <C-n> :NERDTreeToggle<CR>

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" In an xterm the mouse should work quite well, thus enable it.
" set mouse=a

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  colorscheme desert
endif

set tags=tags,./tags,../tags,../../tags

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

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" some CScope maps
noremap <Leader>fs :cscope f s <cword><Enter>

if has("cscope")
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
        " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
endif


" Nice statusbar (stolen from mabr)
set laststatus=2
set statusline=
set statusline+=%-3.3n\                                            " buffer number
set statusline+=%f\                                                " file name
set statusline+=%h%m%r%w                                           " flags
set statusline+=\[%{strlen(&ft)?&ft:'none'},                       " filetype
set statusline+=%{&fileencoding},                                  " encoding
set statusline+=%{&fileformat},                                    " file format
set statusline+=%{((exists(\"+bomb\")\ &&\ &bomb)?\"B,\":\"\")}]\  " BOM
set statusline+=%{strftime('%a\ %b\ %e\ %H:%M')}\                  " hour
set statusline+=%=                                                 " right align
set statusline+=0x%-8B\                                            " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P                              " offset

"""""""""F4 switches from C source .c to header .h file"""""""
function! MPB_LoadFile(filename)
    let s:bufname = bufname(a:filename)
    if (strlen(s:bufname)) > 0
        " File already in a buffer
        exe ":buffer" s:bufname
    else
        " Must open file first
        exe ":e " a:filename
    endif
endfun

function! MPB_Flip_C_H()
    " Switch editing between .c(XYZ) and .h(XYZ) files.
    if match(expand("%"),'\.c') > 0
        let s:flipname = substitute(expand("%"),'\.c\(.*\)','.h\1',"")
        exe ":call MPB_LoadFile(s:flipname)"
    elseif match(expand("%"),'\.h') > 0
        let s:flipname = substitute(expand("%"),'\.h\(.*\)','.c\1',"")
        exe ":call MPB_LoadFile(s:flipname)"
    endif
endfun

function! MPB_Flip_Cpp_H()
    " Switch editing between .c(XYZ) and .h(XYZ) files.
    if match(expand("%"),'\.cpp') > 0
        let s:flipname = substitute(expand("%"),'\.cpp','.h',"")
        exe ":call MPB_LoadFile(s:flipname)"
    elseif match(expand("%"),'\.h') > 0
        let s:flipname = substitute(expand("%"),'\.h','.cpp',"")
        exe ":call MPB_LoadFile(s:flipname)"
    endif
endfun

noremap <F4> :call MPB_Flip_C_H()<CR>
noremap <F3> :call MPB_Flip_Cpp_H()<CR>


call neobundle#end()

NeoBundleCheck

execute pathogen#infect()
