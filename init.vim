" 行数
set number relativenumber
" toggle relative-number automatically
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END

set noswapfile
set termguicolors

let mapleader = "\<Space>"

" insertモードから抜ける
inoremap <C-c> <ESC>
inoremap <silent> jj <ESC>
inoremap <silent> kk <ESC>
inoremap <silent> <C-j> j
inoremap <silent> <C-k> k
" turn off highlignted
noremap <C-c><C-c> :nohlsearch<Cr><Esc>
" toggle relative linenumber
noremap <C-N><C-N> :set relativenumber!<CR>

filetype plugin on
filetype indent on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
set expandtab

set incsearch
set ignorecase
set smartcase
set hlsearch
set cursorline

set mouse=a

set spell
set spelllang=en,cjk

" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
  set termguicolors
endif

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" プラグインがインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " TOMLファイルが存在しない場合は作成
  let g:rc_dir    = expand("~/.config/nvim/")
  if !filereadable(g:rc_dir . './dein.toml')
    execute '!touch ' . g:rc_dir . '/dein.toml'
  endif
  if !filereadable(g:rc_dir . './dein_lazy.toml')
    execute '!touch ' . g:rc_dir . '/dein_lazy.toml'
  endif
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif
