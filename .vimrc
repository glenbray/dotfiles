set colorcolumn=+1
set number
set numberwidth=5
set ruler

set splitbelow
set splitright

set fillchars+=vert:│

" Softabs, 2 spaces
set mouse=a
set ignorecase
set wildmenu
set hlsearch

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Set the title to the current working directory name
autocmd BufEnter * let &titlestring = ' ' . fnamemodify(getcwd(), ':t')
set title

set redrawtime=10000


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set smarttab
set tabstop=2
set shiftwidth=2
set shiftround

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

" let g:gruvbox_contrast_dark = 'dark'

" if has('termguicolors')
"   set termguicolors
" endif

" let g:gruvbox_material_background = 'medium'
" colorscheme gruvbox-material

" set background=dark termguicolors cursorline

let mapleader = ","

" set wildignore+=*/tmp/*,*.so,*.sw,*.zip     " MacOSX/Linux

" better key bindings for UltiSnipsExpandTrigger
" let g:UltiSnipsExpandTrigger="<C-j>"

" open UltiSnipsEditSplit in a new tab
let g:UltiSnipsEditSplit = 'tabdo'


" Visual Multi
let g:VM_leader = '\'

" Git Gutter
let g:gitgutter_enabled = 1
let g:gitgutter_async = 1

" Nerd Tree
let NERDTreeShowHidden = 1
let g:NERDTreeHijackNetrw=0


" let g:indentLine_setConceal = 0
let g:vim_json_syntax_conceal = 0
let g:vim_markdown_conceal = 0
let g:indentLine_concealcursor='nc'
let g:indentLine_fileTypeExclude = ['json', 'md']


" Automatically redraw on focus
" au FocusGained * :redraw!


"COC configuration
set hidden
set updatetime=300

"triger completion when space is pressed
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <NUL> coc#refresh()

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" remap up and down when context menu is open
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" use <C-l> to complete snippets
inoremap <silent><expr> <C-l>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

let g:coc_global_extensions = [
  \ 'coc-solargraph',
  \ 'coc-tsserver'
  \ ]

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

nnoremap <silent> K :call CocAction('doHover')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ale settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_linter_aliases = {'javascriptreact': 'javascript'}
let g:ale_lint_on_save = 1
" let g:ale_yaml_yamllint_executable = 'prettier'
let g:ale_fix_on_save = 1
let g:ale_set_highlights = 0 " Disable highligting
let g:ale_python_flake8_executable = 'python3'
let g:ale_python_pyflakes_executable = 'pyflakes3'

let g:ale_linters = {
\  'ruby': ['standardrb'],
\  'python': ['flake8'],
\  'eruby': [],
\}

let g:ale_fixers = {
\  'ruby': ['standardrb'],
\  'javascript': ['prettier'],
\  'javascriptreact': ['prettier'],
\  'javascript.jsx': [],
\  'typescript': ['prettier', 'tslint'],
\  'css': ['prettier'],
\  'python': ['autopep8', 'yapf'],
\  'dart': ['dartfmt'],
\}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tagbar settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('ripper-tags')
  let g:tagbar_type_ruby = {
      \ 'kinds'      : ['m:modules',
                      \ 'c:classes',
                      \ 'C:constants',
                      \ 'F:singleton methods',
                      \ 'f:methods',
                      \ 'a:aliases'],
      \ 'kind2scope' : { 'c' : 'class',
                       \ 'm' : 'class' },
      \ 'scope2kind' : { 'class' : 'c' },
      \ 'ctagsbin'   : 'ripper-tags',
      \ 'ctagsargs'  : ['-f', '-']
      \ }
endif



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Lightline settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
\ 'component_function': {
\   'filename': 'LightlineFilename'
\ },
\ 'tab_component_function': {
\   'filename': 'LightlineTabname'
\ },
\ 'colorscheme': 'powerline',
\ 'separator': { 'left': '', 'right': '' },
\ 'subseparator': { 'left': '', 'right': '' },
\ }

" \ 'separator': { 'left': "\ue0b8", 'right': "\ue0be" },
" \ 'subseparator': { 'left': "\ue0b9", 'right': "\ue0b9" }
" \ 'tabline_separator': { 'left': "\ue0bc", 'right': "\ue0ba" },
" \ 'tabline_subseparator': { 'left': "\ue0bb", 'right': "\ue0bb" },

function LightLineModified()
  return &modifiable && &modified ? ' ❗' : ''
endfunction

function! LightlineFilename()
  return pathshorten(expand('%')) . LightLineModified()
endfunction

function! LightlineTabname(n) abort
  let bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
  let fname = expand('#' . bufnr . ':t')
  return fname =~ '__Tagbar__' ? 'Tagbar' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ ('' != fname ? fname : '[No Name]')
endfunction

let g:ruby_indent_assignment_style = 'variable'

let test#strategy = "vimterminal"

set rtp+=/usr/local/opt/fzf

" Open FZF in modal center of page
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }

let $FZF_DEFAULT_OPTS="--bind \"ctrl-n:preview-down,ctrl-p:preview-up\""


let NERDTreeIgnore = ['.*sw.', 'Session.vim']

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·


let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*js,*jsx'
let g:closetag_xhtml_filenames = '*.xhtml'
let g:closetag_filetypes = 'html,xhtml,phtml,js,jsx'
let g:closetag_xhtml_filetypes = 'xhtml,jsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'

call plug#begin('~/.vim/plugged')

"Declare the list of plugins.
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'mg979/vim-visual-multi'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'simeji/winresizer'
Plug 'dense-analysis/ale'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'janko/vim-test'
Plug 'airblade/vim-gitgutter'
Plug 'jremmen/vim-ripgrep'
" Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mattn/emmet-vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'Yggdroot/indentLine'
Plug 'Valloric/MatchTagAlways'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'mkitt/tabline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/Tabmerge'
Plug 'itchyny/lightline.vim'
Plug 'AndrewRadev/tagalong.vim'
Plug 'easymotion/vim-easymotion'
Plug 'wakatime/vim-wakatime'
Plug 'lambdalisue/vim-pyenv'
Plug 'majutsushi/tagbar'
Plug 'alvan/vim-closetag'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()


if has('termguicolors')
  set termguicolors
endif

let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
let g:gruvbox_material_better_performance = 1
let g:gruvbox_material_background = 'hard'
colorscheme gruvbox-material


" NERDTree open if directories are present
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" automatically remove trailing whitespaces
autocmd BufWritePre * :%s/\s\+$//e

" Set comment string for rspec file type
autocmd FileType rspec setlocal commentstring=#\ %s

autocmd BufNewFile,BufRead *_spec.rb set syntax=ruby filetype=ruby

" Tagbar
nnoremap <silent> <Leader>b :TagbarToggle<CR>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-=> <C-w>=

" open ctags in vertical split
nnoremap <C-]> :execute "vertical ptag " . expand("<cword>")<CR>

" split pane and fix position
nnoremap <C-W>s Hmx`` \|:split<CR>`xzt``

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

nnoremap ^[h gt<cr>
nnoremap ^[l gT<cr>

" Quit
map <leader>x :q<cr>

" Save
map <leader>w :w<cr>

" NERDTree mappings
noremap <leader>c :NERDTreeToggle<cr>
noremap <leader>nf :NERDTreeFind<cr>

" WinResizer
map <leader>e :WinResizerStartResize<cr>

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" fzf search mappings
noremap <leader>. :tabnew<cr>

noremap <leader>fs :Snippets<cr>
noremap <leader>fw :Windows<cr>
noremap <leader>ff :RG<cr>
noremap <leader>fe :RGE<cr>
" remap fzf to ctrl+p
nnoremap <silent> <c-p> :Files<cr>

" vim-test mappings
nmap <silent> <leader>tn :TestNearest<cr>
nmap <silent> <leader>tf :TestFile<cr>
nmap <silent> <leader>ts :TestSuite<cr>
nmap <silent> <leader>tl :TestLast<cr>
nmap <silent> <leader>tg :TestVisit<cr>

" system keyboard
noremap <leader>y "*yy
noremap <leader>p "*p
noremap <leader>Y "+y
noremap <leader>P "+p

noremap <leader>fl :CocList --input=flutter commands<cr>
noremap <leader>fr :call CocAction('runCommand', 'flutter.run', '--flavor', 'development', '-d', 'all')<cr>

nnoremap <silent> <Space> :nohlsearch<Bar>:echo<cr>

augroup DisableMappings
    " autocmd! VimEnter * :inoremap <leader>ic <Nop>
    autocmd! VimEnter * :unmap <C-e>
augroup END

" Start vim obsession when opening vim
if has('autocmd')
  autocmd VimEnter * nested
        \ if !argc() && empty(v:this_session) && filereadable('Session.vim') && !&modified |
        \   source Session.vim |
        \ endif
endif

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '✨ all good ✨' : printf(
        \   '😞 %dW %dE',
        \   all_non_errors,
        \   all_errors
        \)
endfunction

set statusline=
set statusline+=%m
set statusline+=\ %f
set statusline+=%=
set statusline+=\ %{LinterStatus()}

function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

" MarkDownPreview table trigger
inoreabbrev <expr> <bar><bar>
  \ <SID>isAtStartOfLine('\|\|') ?
  \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'

inoreabbrev <expr> __
  \ <SID>isAtStartOfLine('__') ?
  \ '<c-o>:silent! TableModeDisable<cr>' : '__'

let g:mta_filetypes = {
\ 'html' : 1,
\ 'eruby' : 1,
\ 'jsx' : 1,
\ 'xhtml' : 1,
\ 'xml' : 1,
\ 'jinja' : 1,
\}

" https://github.com/junegunn/fzf.vim#example-advanced-ripgrep-integration
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case --hidden %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

function! RipgrepFzfExact(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -F %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
command! -nargs=* -bang RGE call RipgrepFzfExact(<q-args>, <bang>0)

" change cursor on insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" optional reset cursor on start:
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

" automatically install missing plugins on startup
augroup vim_vim_plug_auto_install
  autocmd!
  autocmd VimEnter *
        \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
        \|   PlugInstall --sync | q
        \| endif
augroup END
