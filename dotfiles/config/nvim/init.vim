set foldmethod=marker
" 0 Setup " {{{
if &compatible
  set nocompatible
endif

" No sounds when esc in WSL (Windows Subsystem for Linux)
set visualbell

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state(expand('~/.cache/dein'))
  call dein#begin(expand('~/.cache/dein'))
  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')    " completion
  " call dein#add('zchee/deoplete-jedi')     " python completion with jedi
  call dein#add('ervandew/supertab')       " Tab works better in cli
  call dein#add('neomake/neomake')      " syntax checking
  call dein#add('mhinz/vim-grepper')       " async grepping
  call dein#add('907th/vim-auto-save')
  call dein#add('tpope/vim-fugitive')        " git
  call dein#add('tpope/vim-unimpaired')      " complementary pair of bracket mappings
  call dein#add('junegunn/fzf', {'build': './install', 'merged': 0})
  call dein#add('junegunn/fzf.vim')        " fuzzy finder
  call dein#add('tpope/vim-commentary')    " commenting
  call dein#add('tpope/vim-repeat')
  call dein#add('justinmk/vim-sneak')    " s{char}{char} -> go places
  call dein#add('justinmk/vim-dirvish')    " directory navigator
  call dein#add('ludovicchabant/vim-gutentags') " tags
  call dein#add('kopischke/vim-fetch')      " go to col/line from interpreters etc
  call dein#add('junegunn/gv.vim')        " commit viewer
  call dein#add('majutsushi/tagbar')
  call dein#add('zah/nim.vim') " nim
  call dein#add('garyburd/neols')
  call dein#add('garyburd/lua-client')
  call dein#add('timeyyy/bubbletrouble.symphony')
  call dein#add('mhinz/vim-startify')     " cool start screen
  call dein#local('~/Documents/git', {}, ['orchestra.nvim', 'clackclack.symphony'])
  call dein#add('vim-airline/vim-airline') " status bar, slows vim alot
  call dein#add('wlangstroth/vim-racket')
  call dein#add('jdonaldson/neovaxe') " Haxe CAUSUES BUGS TODO
  call dein#add('guns/vim-clojure-static')
  call dein#add('tpope/vim-fireplace')
  call dein#add('luochen1990/rainbow')
  " call dein#add('vim-scripts/SyntaxRange')
  " call dein#add('SirVer/ultisnips')
  " call dein#add('honza/vim-snippets')
  " call dein#add('tpope/vim-surround')      " s motion for surround
  " call dein#add('tpope/vim-abolish')     " transforming word forms
  " call dein#add('janko-m/vim-test')        " testing
  call dein#add('floobits/floobits-neovim') " collaborative editing
  " call dein#add('joeytwiddle/sexy_scroller.vim') being gay with terminal
  " call dein#add('maksimr/vim-translator')
  " call dein#add('xolox/vim-misc')          " Required for sessions
  " call dein#add('xolox/vim-session')       " Sessions TODO erroring..
  call dein#end()
  call dein#save_state()
endif
" "}}}
" 1 Plugin Settings "{{{
let g:rainbow_active = 1
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="horizontal"
" }}}
" 2 Defaults {{{
filetype plugin indent on

nnoremap ; :
nnoremap ;; ;

" This stops space from going to the right in normal mode..
nnoremap <space> <nop>
let mapleader = " "

" Auto change dir to the file being edited
" FIXME dirvish currently doesn't suport htis feature
nnoremap <leader>jd :cd %:p:h<cr>
" set autochdir
" reload and backup init.vim on save init.vim
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $XDG_CONFIG_HOME/nvim/init.vim source $XDG_CONFIG_HOME/nvim/init.vim
    autocmd BufWritePost $XDG_CONFIG_HOME/nvim/init.vim   execute 'silent !cp $XDG_CONFIG_HOME/nvim/init.vim
                                                \ ~/Dropbox/dotfiles/init.vim'
augroup END " }
" }}}
" 2 moving around, searching and patterns {{{
" Incremental Searching
set noincsearch
set ignorecase
set smartcase
set nohlsearch
" TODO NOT WORKING FML
augroup cancel_hlsearch " {
    autocmd!
    autocmd CursorHold * :nohlsearch
augroup END " }

" This willl ignore files and folder s in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" Walk down the completion menu list
let g:SuperTabDefaultCompletionType = "<c-n>"
"
" Default grepping tools to use with vim-grepper
let g:grepper = {'tools': ['ag', 'git', 'grep'],}
nnoremap <leader>ag :Grepper -tool ag <cr>
nnoremap <leader>* :Grepper -tool ag -cword -noprompt<cr>


" Directory relative
nnoremap <leader>drr :Dirvish %<cr>
" nnoremap <leader>drs :split|:Dirvish %<cr>
" nnoremap <leader>drv :vsplit|:Dirvish %<cr>
" Directory cwd
nnoremap <leader>dcc :Dirvish<cr>
" nnoremap <leader>dcs :split|:Dirvish<cr>
" nnoremap <leader>dcv :vsplut|:Dirvish<cr>
" let g:dirvish_relative_paths = 0

" Projects
" Don't save hidden and unloaded buffers in sessions.
" set sessionoptions-=buffers
" let g:session_autosave = 'yes'
" let g:session_autoload = 'no'
" let g:session_autosave_silent = 1
" augroup auto_save_session " {
    " autocmd!
    " autocmd BufEnter * SaveSession
" augroup END " }
" nnoremap <leader>ps :SaveSession<cr>
" nnoremap <leader>pn :SaveSession
" nnoremap <leader>po :OpenSession<cr>
" nnoremap <leader>pc :CloseSession<cr>
" nnoremap <leader>pd :DeleteSession<cr>
" nnoremap <leader>pv :ViewSession<cr>
" nnoremap <leader>pr :RestartVim<cr>

command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

" }}}
" 3 tags {{{
nmap <F8> :TagbarToggle<CR>
" }}}
" 5 syntax, highlighting and spelling {{{
syntax on
colorscheme CandyPaper
" colorscheme mayansmoke
" nnore <leader>u :colorscheme mayansmoke<CR>

" Over 80 Lines highlight cell
highlight ColorColumn ctermbg=235 guibg=#2c2d27
let &colorcolumn="80"

" }}}
" 6 multiple windows {{{
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
noremap <C-H> <C-W><C-H>

tnoremap <C-H> <C-\><C-n><C-w>h
tnoremap <C-J> <C-\><C-n><C-w>j
tnoremap <C-K> <C-\><C-n><C-w>k
tnoremap <C-L> <C-\><C-n><C-w>l

set splitbelow
set splitright

nnoremap <leader>w <C-w>
" }}}
" 7 multiple tab pages {{{
" Tab navigation like Firefox.
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>

" }}}
" 8 terminal {{{
nnoremap <leader>te :te<cr>
tnoremap <Esc> <C-\><C-n>
" tnoremap JK <C-\><C-n>
" tnoremap KJ <C-\><C-n>
" }}}
"12 selecting text {{{
noremap <c-a> ggVG
"}}}
"13 editing text {{{
set relativenumber
abbr imoprt import
abbr impot import
abbr response response
abbr resposne response
"}}}
"14 tabs and indenting {{{
set tabstop=4
set autoindent
set expandtab
set shiftwidth=4
"}}}
"17 mapping {{{
" map alt to work in terminal goo.gl/zk1W5p, silent ignores errors
execute "silent! set <M-j>=\ej"
execute "silent! set <M-k>=\ek"
execute "silent! set <M-h>=\eh"
execute "silent! set <M-l>=\el"
execute "silent! set <M-H>=\eH"
execute "silent! set <M-L>=\eL"
nnoremap <M-j> <c-e>
nnoremap <M-k> <c-y>
nnoremap <M-l> :tabnext<cr>
nnoremap <M-L> :tablast<cr>
nnoremap <M-h> :tabprev<cr>
nnoremap <M-H> :tabfirst<cr>

inoremap jk <Esc>
inoremap kj <Esc>


noremap <leader>y "+y
noremap <leader>p "+p
noremap <leader>P "+P

nnoremap H ^
vnoremap H ^
nnoremap L $
vnoremap L $

nnoremap <leader>vo :tabe $XDG_CONFIG_HOME/nvim/init.vim <CR>
nnoremap <leader>vr :source $XDG_CONFIG_HOME/nvim/init.vim  <CR>
nnoremap <leader>vi :call dein#install() <CR>
nnoremap <leader>vu :call dein#update() <CR>
nnoremap <leader>vc :call dein#check_clean() <CR>

nnoremap <leader>zo :tabe ~/.zshrc <CR>
nnoremap <leader>zr :source ~/.zshrc <CR>
nnoremap <leader>zi :!zplug install <CR>

nnoremap <leader>to :tabe ~/.pylintrc <CR>


nnoremap <leader>s :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <c-w> :q <cr>
nnoremap <leader>vq :SaveSession<cr>:qa<cr>

nnoremap <leader>gco :Gread<cr>
nnoremap <leader>ga :Gwrite<cr>
nnoremap <leader>gcc :Gcommit<cr>
nnoremap <leader>gcam :Gcommit --amend<cr>
nnoremap <leader>gsh :Git show<cr>
nnoremap <leader>glg :Git log --stat --max-count=10<cr>
nnoremap <leader>glo :Git log --oneline --decorate --color<cr>
nnoremap <leader>grbi :Git rebase --interactive HEAD~
nnoremap <leader>gbl :Gblame<cr>
nnoremap <leader>gst :Gstatus<cr>
nnoremap <leader>gpp :Git push<cr>
nnoremap <leader>gpf :Git push -f<cr>

nnoremap <c-p> :Files<cr>
nnoremap <leader>fb :Buffers<cr>
" nnoremap <leader>fc :Commits<cr>
" TODO fix change mapping for ctrl p
" let g:ctrlp_map = "\<Leader-f-f>"

nnoremap <c-e> :normal gccj<cr>
vnoremap <c-e> :normal gc<cr>
"}}}
"18 reading and writing files {{{
let g:auto_save = 1 " Enable autosave on vim startup
let g:auto_save_events = ["CursorHold", "CursorHoldI"]
set autowrite
set autoread
"}}}
"23 language specific {{{
autocmd! BufWritePost * Neomake " run on save
sign define dummy
execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')

" Highlight eol spaces
highlight ExtraWhitespace ctermbg=Magenta guibg=Magenta
match ExtraWhitespace /\s\+$/
augroup delete_extra_whitespace " {
    autocmd!
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()
augroup END " }

" TODO FFS USE PYTHON 3
nnoremap <silent> <leader>tn :TestNearest<CR>
nnoremap <silent> <leader>tf :TestFile<CR>
nnoremap <silent> <leader>ta :TestSuite<CR>
nnoremap <silent> <leader>tl :TestLast<CR>
nnoremap <silent> <leader>tl :TestLast<CR>
nnoremap <silent> <leader>tv :TestVisit<CR>

nnoremap <leader>urp :UpdateRemotePlugins<cr>

nnoremap <leader>tvv :call orchestra#set_tune('bubbletrouble')<cr>
" nnoremap <leader>tvv :call orchestra#set_tune('clackclack')<cr>

" Python Language

let g:neomake_python_enabled_makers = ['frosted', 'mypy', 'pylint']

nnoremap <leader>pd oimport pdb;pdb.set_trace()<Esc>
nnoremap <leader>pm o@pytest.mark.z<Esc>

nnoremap <leader>r :tabnew %<cr>:te p %<CR>

" C Language
autocmd FileType c setlocal shiftwidth=2 tabstop=2 softtabstop=2

"
" Kivy Language
au BufNewFile,BufRead *.kv set filetype=kivy
autocmd FileType kivy setlocal commentstring=#\ %s

" Haxe Language
autocmd FileType haxe setlocal shiftwidth=2 tabstop=2 softtabstop=2
" let g:neomake_haxe_enabled_makers = ['haxe']

" Kivy Language
au BufNewFile,BufRead *.kv set filetype=kivy
autocmd FileType kivy setlocal commentstring=#\ %s

" Lua
autocmd FileType lua setlocal shiftwidth=2 tabstop=2 softtabstop=2

let g:neomake_lua_enabled_makers = []

let g:langserver_executables = {
       \ 'go': {
         \ 'name': 'sourcegraph/langserver-go',
         \ 'cmd': ['langserver-go', '-trace', '-logfile', expand('~/Desktop/langserver-go.log')],
         \ },
       \ }

"}}}
"24 multi-byte characters {{{ }}} 25 various {{{
let g:deoplete#enable_at_startup = 1
autocmd FileType lua let b:dispatch = 'luajit %'
let g:startify_change_to_dir = 0

" call orchestra#prelude()
" call orchestra#set_tune('clackclack')
" function specialquit()
    " a:exists = filereadable(bufname(""))
    " if not exists
" endfunction
" augroup special_save " {
    " autocmd!
    " :w
" augroup END " }
"}}}
"26 Project Specific {{{
" Neovim project
nnoremap <leader>gm ?: make<cr>
nnoremap <leader>gc ?: clang<cr>
nnoremap <leader>gg ?: gcc<cr>
nnoremap <leader>gt ?: TEST<cr>

" Extended marks
highlight extmark ctermbg=Blue guibg=Blue
call nvim_init_mark_ns('myplugin')
call nvim_init_mark_ns('myplugin2')
function! Testextmark(timer_id)
    let a:ns = 1
    " Get all the mark ids
    let a:all_marks = nvim_buf_get_marks(0, a:ns, -1, -1, -1, 0)

    call clearmatches()

    for mark in a:all_marks
        let a:bytes = col([mark[1], mark[2]])
        let a:ma = matchaddpos('extmark', [[mark[1], mark[2]]])
    endfor
    call timer_start(100, 'Testextmark')
endfunction

nnoremap <silent> <leader>tm :call timer_start(1, 'Testextmark')<cr>

highlight exttag ctermbg=Red guibg=Red
call nvim_init_tag_ns('myplugin')
function! Testexttag(timer_id)
    let a:ns = 1
    " let a:all_tags = nvim_buf_get_tags(0, a:ns, -1, -1, -1, 0)
    let a:all_tags = nvim_buf_get_tags(0, a:ns, 1, [0, 0], [10, 10], -1, 0)

    call clearmatches()

    for indexes in a:all_tags
        let a:bytes = col(indexes[0])
        let a:ma = matchaddpos('exttag', [indexes[0]])
        let a:bytes = col(indexes[1])
        let a:ma = matchaddpos('exttag', [indexes[1]])
    endfor
    call timer_start(100, 'Testexttag')
endfunction

nnoremap <silent> <leader>tt :call timer_start(1, 'Testexttag')<cr>

"}}}
