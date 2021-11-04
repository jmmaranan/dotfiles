"initial setup
syntax on
set tabstop=4 softtabstop=4
set expandtab
set shiftwidth=4
set smartindent
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set completeopt=menuone,noinsert,noselect
set signcolumn=yes
set cmdheight=2
set updatetime=50
set shortmess+=c
set colorcolumn=80
set cursorline

call plug#begin('~/.vim/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'jremmen/vim-ripgrep'
Plug 'mbbill/undotree'
Plug 'fatih/vim-go'
Plug 'vim-ruby/vim-ruby'
Plug 'preservim/nerdtree'
Plug 'elixir-editors/vim-elixir'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'rust-lang/rust.vim'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
call plug#end()

colorscheme gruvbox
set background=dark

if executable('rg')
    let g:rg_derive_root='true'
endif

let g:netrw_browse_split=2
let g:netrw_winsize = 25

let mapleader=" "

" Window Management
nnoremap <silent> <leader>h :wincmd h<cr>
nnoremap <silent> <leader>j :wincmd j<cr>
nnoremap <silent> <leader>k :wincmd k<cr>
nnoremap <silent> <leader>l :wincmd l<cr>
nnoremap <silent> <leader>H :wincmd H<cr>
nnoremap <silent> <leader>J :wincmd J<cr>
nnoremap <silent> <leader>K :wincmd K<cr>
nnoremap <silent> <leader>L :wincmd L<cr>
nnoremap <silent> <leader>wv :wincmd v<cr>
nnoremap <silent> <leader>wo :wincmd o<cr>
nnoremap <silent> <leader>wp :wincmd p<cr>
nnoremap <silent> <leader>wq :wincmd q<cr>
nnoremap <silent> <leader>wx :wincmd x<cr>
nnoremap <silent> <leader>wd :vertical resize +5<cr>
nnoremap <silent> <leader>wa :vertical resize -5<cr>
nnoremap <silent> <leader>uu :UndotreeShow<cr>
nnoremap <silent> <leader>uq :UndotreeHide<cr>

" File Management
nnoremap <leader>ps :Rg<space>
nnoremap <silent> <leader><space> :Files<cr>
nnoremap <silent> <leader>bb :Buffers<cr>
nnoremap <silent> <leader>nf :NERDTreeFocus<cr>
nnoremap <silent> <leader>nn :NERDTree<cr>
nnoremap <silent> <leader>nt :NERDTreeToggle<cr>
nnoremap <silent> <leader>ns :NERDTreeFind<cr>
nnoremap <leader>gi :Git<space>
nnoremap <leader>ww :wa<cr>

autocmd VimEnter * NERDTree | wincmd p

" Status Line
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P

" Vim-Go
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"

function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>rb :<C-u>call <sid>build_go_files()<cr>
autocmd FileType go nmap <leader>rr <Plug>(go-run)
autocmd FileType go nmap <leader>rt <Plug>(go-test)
autocmd FileType go nmap <leader>rc <Plug>(go-coverage-toggle)
autocmd FileType go nmap <leader>gt :GoAlternate<cr>
autocmd FileType go nmap <leader>ll :GoMetaLinter<cr>
autocmd FileType go nmap <leader>ff :GoFmt<cr>

" Completion Management
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

