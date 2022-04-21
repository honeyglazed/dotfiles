call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'
Plug 'jiangmiao/auto-pairs'
Plug 'tomasiser/vim-code-dark'
Plug 'mhinz/vim-startify'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'hrsh7th/nvim-compe'
Plug 'tpope/vim-surround'
Plug 'romgrk/barbar.nvim'
call plug#end()

syntax on
set enc=utf-8				  " Text encoding
set autoindent				" Good auto indent
set splitbelow
set splitright
set hidden				    " Required to keep multiple buffers open
set nowrap				    " Display long lines as one line
set tabstop=2				  " Insert 2 spaces for tabs
set expandtab				  " Tabs to spaces
set shiftwidth=2			" Insert 2 spaces when shifting with >>
set number
set relativenumber
set noshowmode				" Remove extra -- INSERT --
set colorcolumn=120
set smartindent
set mouse=a
set laststatus=2
set cursorline
set scrolloff=8
set incsearch
set noswapfile
set nobackup

colorscheme codedark
highlight Normal guibg=none ctermbg=none
" Set column color
highlight ColorColumn ctermbg=darkgray
"highlight CursorLine cterm=None ctermbg=235 ctermfg=None


:let mapleader = "\\"
inoremap jk <ESC>
vnoremap jk <ESC>
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<cr>
nnoremap _ _i
nnoremap <leader>c :noh<CR>

" Move to the next item in buffer
nnoremap <TAB> :BufferNext<CR>
nnoremap <S-TAB> :BufferPrevious<CR>
" Delete current item in buffer
nnoremap <C-x> :BufferClose<CR>

nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>i
nnoremap <C-q> :q<CR>

" Move lines up and down
nnoremap <silent> J :m .+1<CR>==
nnoremap <silent> K :m .-2<CR>==
vnoremap <silent> J :m '<+2<CR>gv=gv
vnoremap <silent> K :m '<-2<CR>gv=gv

nnoremap <C-e> :Lexplore<CR>

" Copy from cursor to end of line
nnoremap Y y$

" Copy to system clipboard
vnoremap <leader>y "+y
nnoremap <leader>p "+p

"Training wheels
:inoremap <ESC> <nop>
:inoremap <Up> <nop>
:inoremap <Down> <nop>
:inoremap <Left> <nop>
:inoremap <Right> <nop>
:nnoremap <Up> <nop>
:nnoremap <Down> <nop>
:nnoremap <Left> <nop>
:nnoremap <Right> <nop>

let g:vim_json_conceal=0

" Compile and run C++ files
augroup cpp
  autocmd!
  autocmd Filetype cpp nnoremap <F8> :w <bar> !clang++ -std=c++17 %:p -o %:p:h/bin/%:t:r && %:p:h/bin/%:t:r <CR>
augroup END

" Run Python files
augroup pythonlang
  autocmd!
  autocmd Filetype python nnoremap <F8> :w <bar> !python3 %:p <CR>
augroup END

augroup rustlang
  autocmd!
  autocmd Filetype rust nnoremap <F8> :w <bar> !rustc %:p -o %:p:h/bin/%:t:r && %:p:h/bin/%:t:r <CR>
augroup END

" Use template files
augroup templates
  autocmd!
  autocmd BufNewFile *.* silent! execute '0r ~/.vim/templates/skeleton.'.expand("<afile>:e")
augroup END

" Auto source init.vim
augroup reload
  autocmd!
  autocmd BufWritePost $MYVIMRC source %
augroup END

" Powerline config
let g:airline_section_z=airline#section#create(['%p%%'])

" Remove whitespaces
fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

augroup clearwhitespace
  autocmd!
  autocmd BufWritePre * :call TrimWhitespace()
augroup END

" netrw setup
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_winsize=10
let g:netrw_liststyle=3
let g:netrw_altv=1

" Telescope
lua << EOF
require('telescope-config')
EOF
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>

" Language Server
lua << EOF
require'lspconfig'.clangd.setup{}
require'lspconfig'.pyright.setup{}
require'lspconfig'.tsserver.setup{}
EOF
highlight LspDiagnosticsVirtualTextError guifg=Red ctermfg=Red
highlight LspDiagnosticsVirtualTextWarning guifg=Yellow ctermfg=Yellow
nnoremap <silent><C-d> <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent><C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent><C-f> <cmd>lua vim.lsp.buf.formatting()<CR>


" Treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"cpp", "python", "typescript"},
  ignore_install = {},
  highlight = {
    enable = true
    }
  }
EOF

"Autocompletion
set completeopt=menuone,noselect
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:false
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.nvim_lsp = v:true

"Buferr
let g:bufferline = {}
let g:bufferline.icons = v:false
