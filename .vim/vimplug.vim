call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'git://git.wincent.com/command-t.git'

"Plug 'Shougo/neocomplete'

Plug 'Shougo/unite.vim'
Plug 'ujihisa/unite-colorscheme'
Plug 'tomasr/molokai'

" Custom Plug
Plug 'itchyny/lightline.vim'

Plug 'rstacruz/sparkup', {'rtp': 'vim/'}

Plug 'scrooloose/nerdtree'

Plug 'posva/vim-vue'

Plug 'andrewstuart/vim-kubernetes'

Plug 'Chiel92/vim-autoformat'

Plug 'nsf/gocode', {'rtp': 'vim/'}
Plug 'fatih/vim-go'

Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'

" toml
Plug 'cespare/vim-toml'

Plug 'tpope/vim-endwise'

" Plug 'ervandew/supertab'
Plug 'maralla/completor.vim'

Plug 'haya14busa/is.vim'

" Syntax Highlight
Plug 'w0rp/ale'

" Auto Fix Trailing White-Space
Plug 'bronson/vim-trailing-whitespace'

" Auto Close
Plug 'jiangmiao/auto-pairs'

" Comment
Plug 'tpope/vim-commentary'


call plug#end()

" ------------------------------------
" colorscheme
" ------------------------------------
syntax on

if filereadable(expand("$HOME/.vim/plugged/molokai/colors/molokai.vim"))
    colorscheme molokai
endif

highlight Normal ctermbg=none
