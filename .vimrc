set nocompatible
filetype off

execute pathogen#infect()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gimme a nice colorscheme :-)
colorscheme desert

" allow backspacing over everything in instert mode
set backspace=indent,eol,start
" show the cursor position all time
set ruler
"display incomplete commands
set showcmd
" do incremental searching
set incsearch
" allow mouse for all modes
set mouse=a
" turn off the distracting bell sound
set visualbell

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

" command maps // to search selected text in visual mode
vnoremap // y/<C-R>"<CR>

" make vim automatically refresh any unchanged files
set autoread

" visual autocomplete for command menu
set wildmenu
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ctrl-n shows the side bar
map <C-n> :NERDTreeToggle<CR>
" reduce the update time for vim to refresh; for git-gutter
set updatetime=250
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Nice statusbar
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

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  colorscheme desert
endif

set tags=tags,./tags,../tags,../../tags
