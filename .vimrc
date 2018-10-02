"-------------------------------------------------------------------+
"					   VUNDLE PLUGIN MANAGER SHIT					|
"-------------------------------------------------------------------+
set nocompatible              " be iMprovedi, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo. [Apparantly to do git stuff in vim]
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub. [For fast file navigation]
"Plugin 'git://git.wincent.com/command-t.git'

" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly. [For writing HTML]
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

"------------Daniel's plugins---------------
" Better markdown higlighting
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
" Syntax checking on :w. Needs compiler to do the work.
Plugin 'syntastic'
" YouCompleteMe autocomplete. Needs special installation, google it.
" Uses WAY to much memory (560 MB) for school though :(.
"Plugin 'Valloric/YouCompleteMe
"" Gruvbox nice colour scheme!
Plugin 'morhetz/gruvbox'
"" Ctrlp to show paths when using :e (which opens other files)
Plugin 'ctrlpvim/ctrlp.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"--------------------------VUNDLE END------------------------------+

" Default tab sizes if not specified per language in ~/.vim/ftpluging/language.vim
" tabstop:          Width of tab character. Probably keep as default if expandtab
" softtabstop:      Fine tunes the amount of white space to be added
" shiftwidth        Determines the amount of whitespace to add in normal mode
" expandtab:        When on uses space instead of tabs
set expandtab
set softtabstop=4
set shiftwidth=4

"""colorscheme pablo
"""set background =dark

"wordrap
set wrap

"highlight searched words
set hlsearch

"To make vim start in directory of opened file
"echom %:p:h " WIP
cd %:h

" TODO add language specific stuff to turn of the default syntac highlighting
" for languages with special plugins (C, C++, and Java and Python I think.)
syntax on

" Turn of beep. I want to punch the guy that set it on by default.
set vb
set t_vb=

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_cpp_compiler = 'g++'
" Maybe goes at the the end of the line below: -stdlib=libc++
let g:syntastic_cpp_compiler_options = ' -std=gnu++11 -I /info/DD2387/labs/cxxtest/'
" The location list is the intrusive window with error. Always populate keeps
" it updated or something, but could interfere with other plugins.
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" Gruvbox plugin stuff.
colorscheme gruvbox
set background=dark
" 't_ut= ' needed to make tmux use correct background colour on certain
" systems. In Linux on Windows 10 gruvbox doesn't work at all without this.
" When SSH-ing to school with Putty, removing this command will toggle gruvbox
" IN THE TERMINAL OUTSIDE OF VIM every time something is saved with :wq or :x
" (not :w :q though) (hella strange).
set t_ut=

" esc -> capslock experiment. Relies on the non-vim xmodmap.
" Maybe only works for X11-interactions.
au VimEnter * silent !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
au VimLeave * silent !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'
