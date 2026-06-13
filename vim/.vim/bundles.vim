set nocompatible              " be iMproved, required

if !isdirectory(expand('~/.vim/bundle/Vundle.vim'))
  finish
endif

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Navigation
Plugin 'Lokaltog/vim-easymotion'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'gcmt/wildfire.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'taglist.vim'
" Commands
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/unite-session'
" Auto Complete
Plugin 'vim-scripts/cmdline-completion'
Plugin 'Shougo/neocomplete.vim'
Plugin 'ervandew/supertab'
Plugin 'Raimondi/delimitMate'
" UI Additions
Plugin 'Yggdroot/indentLine'
Plugin 'yonchu/accelerated-smooth-scroll'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'chriskempson/vim-tomorrow-theme'
" Language specific
Plugin 'scrooloose/syntastic'
" Library
Plugin 'L9'
" Neosnippet like Snipmate
Bundle 'Shougo/neosnippet'
Bundle 'Shougo/neosnippet-snippets'
" Misc
Plugin 'junegunn/goyo.vim'
Plugin 'Shougo/vimshell.vim'
Plugin 'Shougo/vimproc.vim'
" Rust
Plugin 'rust-lang/rust.vim'
Plugin 'preservim/tagbar'
Plugin 'mhinz/vim-grepper'

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
