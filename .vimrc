""""""""" General Vim settings """""""""""""""""

syntax enable

set backspace=2
set mouse=a
set fileformats=unix,dos
set ruler
set laststatus=2

" Auto read when a file is changed from the outside.
set autoread

" Tab key produces 4 spaces, and tab characters are converted to spaces.
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent

" When you start searching text with /, search is performed at every
" new character insertion.
set incsearch
set hlsearch

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Turn on filetype detection and load the plugin files for
" specific file types.
filetype plugin on

" Pathogen to install plugins as git submodules.
call pathogen#infect()

" Styles.
set t_Co=256
set background=dark
color jellybeans
let g:airline_theme='jellybeans'

highlight LineNr ctermfg=grey
highlight Folded ctermfg=grey
highlight VertSplit ctermbg=grey ctermfg=grey

" Yellow as selected whatever colour.
highlight Search ctermbg=Yellow ctermfg=Black
highlight Visual ctermbg=Yellow ctermfg=Black
highlight VisualNOS ctermbg=Yellow ctermfg=Black

" Copy & paste from system clipboard (only available if vim was compiled with clipboard support).
if has('clipboard')
  exe 'map <C-c> "+y<CR>'
endif

" Fuzzy search.
" * Adding tags extension
" * Opens the last used mode
set path=$PWD/**
let g:ctrlp_max_height = 20
let g:ctrlp_cmd = 'CtrlPTag'
let g:ctrlp_working_path_mode='a'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_extensions = ['tag']
" Apply here IDE defaults.
" ToggleType and PrtCurStart extended to remove the duplicates once re-maped.
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<cr>', '<c-a>', '<2-LeftMouse>'],
    \ 'AcceptSelection("h")': ['<c-c>', '<c-RightMouse>'],
    \ 'AcceptSelection("v")': ['<c-f>', '<c-MiddleMouse>'],
    \ 'ToggleType(1)':        ['<c-up>'],
    \ 'PrtCurStart()':        ['<c-i>'],
\ }

" Mustache
let g:mustache_abbreviations = 1

" Airline showing the current tag.
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tagbar#flags = 'f'
let g:airline_section_y = ''
let g:airline#extensions#hunks#enabled = 0

" Show trailing whitespaces and tabs.
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * call clearmatches()
autocmd BufWinLeave * call clearmatches()
autocmd InsertLeave * call clearmatches()
autocmd InsertEnter * match ExtraWhitespace /\s\+$\| \+\ze\t\|\t/

" Loading user settings and overwrites.
if filereadable(expand("~/.vim/custom.vim"))
    source ~/.vim/custom.vim
endif

autocmd BufWritePost *.py call Flake8()
