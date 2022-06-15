set nomore

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

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Set the title to the current workingdirectory name
autocmd BufEnter * let &titlestring = ' ' . fnamemodify(getcwd(), ':t')
set title

set redrawtime=10000

" Scroll quarter of screen instead of full screen
function! ScrollQuarter(move)
    let height=winheight(0)

    if a:move == 'up'
        let key="\<C-Y>"
    else
        let key="\<C-E>"
    endif

    execute 'normal! ' . height/4 . key
endfunction

nnoremap <silent> <C-u> :call ScrollQuarter('up') <CR><S-m><CR>
nnoremap <silent> <C-d> :call ScrollQuarter('down') <CR><S-m><CR>


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

let mapleader = ","

" set wildignore+=*/tmp/*,*.so,*.sw,*.zip     " MacOSX/Linux

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
au FocusGained * :redraw!

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" remap up and down when context menu is open
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" vsnip configuration
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']
let g:vsnip_filetypes.eruby = ['html', 'eruby']

imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'


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
\ 'colorscheme': 'onedark',
\ }

let g:lightline.component_expand = {
\  'linter_checking': 'lightline#ale#checking',
\  'linter_infos': 'lightline#ale#infos',
\  'linter_warnings': 'lightline#ale#warnings',
\  'linter_errors': 'lightline#ale#errors',
\  'linter_ok': 'lightline#ale#ok',
\ }

let g:lightline.component_type = {
\     'linter_checking': 'right',
\     'linter_infos': 'right',
\     'linter_warnings': 'warning',
\     'linter_errors': 'error',
\     'linter_ok': 'right',
\ }

let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ]] }

let g:lightline.active = {
\ 'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
\            [ 'lineinfo' ],
\            [ 'percent' ],
\            [ 'fileformat', 'fileencoding', 'filetype'] ] }

let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_infos = "\uf129"
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"


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

let test#strategy = "neovim"


" let NERDTreeIgnore = ['.*sw.', 'Session.vim']

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*js,*jsx,*erb'
let g:closetag_xhtml_filenames = '*.xhtml'
let g:closetag_filetypes = 'html,xhtml,phtml,js,jsx,erb'
let g:closetag_xhtml_filetypes = 'xhtml,jsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'

" Terminal remap escape to change to motion mode
tnoremap <Esc> <C-\><C-n>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Flutter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 " Show hover
nnoremap K <Cmd>lua vim.lsp.buf.hover()<CR>
 " Jump to definition
nnoremap gd <Cmd>lua vim.lsp.buf.definition()<CR>
 " Open code actions using the default lsp UI, if you want to change this please see the plugins above
nnoremap <leader>ca <Cmd>lua vim.lsp.buf.code_action()<CR>
 " Open code actions for the selected visual range
xnoremap <leader>ca <Cmd>lua vim.lsp.buf.range_code_action()<CR>


call plug#begin('~/.vim/plugged')

"Declare the list of plugins.
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'vim-ruby/vim-ruby'
Plug 'mg979/vim-visual-multi'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'simeji/winresizer'
Plug 'dense-analysis/ale'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'janko/vim-test'
Plug 'airblade/vim-gitgutter'
Plug 'sainnhe/gruvbox-material'
Plug 'mattn/emmet-vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'Yggdroot/indentLine'
" Plug 'Valloric/MatchTagAlways'
Plug 'honza/vim-snippets'
Plug 'mkitt/tabline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/Tabmerge'
Plug 'itchyny/lightline.vim'
Plug 'AndrewRadev/tagalong.vim'
" Plug 'easymotion/vim-easymotion'
" Plug 'wakatime/vim-wakatime'
Plug 'majutsushi/tagbar'
Plug 'alvan/vim-closetag'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'maximbaz/lightline-ale'
Plug 'unblevable/quick-scope'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'jupyter-vim/jupyter-vim'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'tyru/open-browser.vim'
Plug 'tyru/open-browser-github.vim'
Plug 'williamboman/nvim-lsp-installer'
" Plug 'dart-lang/dart-vim-plugin'
Plug 'akinsho/flutter-tools.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'rcarriga/nvim-notify'
Plug 'Neevash/awesome-flutter-snippets'
Plug 'joshdick/onedark.vim'
Plug 'phaazon/hop.nvim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

if has('termguicolors')
  set termguicolors
endif

let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
let g:gruvbox_material_better_performance = 1
let g:gruvbox_material_background = 'hard'
let g:onedark_terminal_italics = 1
syntax on
colorscheme gruvbox-material
" colorscheme onedark

" NERDTree open if directories are present
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" automatically remove trailing whitespaces
autocmd BufWritePre * :%s/\s\+$//e

" Set comment string for rspec file type
autocmd FileType rspec setlocal commentstring=#\ %s

autocmd BufNewFile,BufRead *_spec.rb set syntax=ruby filetype=ruby

" autocmd BufWritePost *.rb !ripper-tags -R --exclude=vendor . $(bundle list --paths | sed 's/$/\/lib/')

" " Tagbar
" nnoremap <silent> <Leader>b :TagbarToggle<CR>
" nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>b :lua require'telescope.builtin'.buffers{}<CR>
nnoremap <silent> <Leader>co :lua require'telescope.builtin'.commands{}<CR>
nnoremap <silent> <Leader>ch :lua require'telescope.builtin'.command_history{}<CR>
nnoremap <silent> <Leader>r :lua require'vim.lsp.buf'.rename()<CR>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-=> <C-w>=

" open ctags in new tab
" nnoremap <C-]> :execute "vertical ptag " . expand("<cword>")<CR><C-w>=
nnoremap <C-\> :execute "vertical ptag " . expand("<cword>")<CR><C-w>=<C-w>lzz
nnoremap <C-]> :execute "vertical ptag " . expand("<cword>")<CR><C-w>l<C-w>T

" split pane and fix position
nnoremap <C-W>s Hmx`` \|:split<CR>`xzt``

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Spelling shortcuts
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
noremap <leader>nn :NERDTreeToggle<cr>
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

noremap <leader>. :tabnew<cr>

" fzf search mappings

" noremap <leader>fs :Snippets<cr>
" noremap <leader>fw :Windows<cr>
" noremap <leader>ff :RG<cr>
" noremap <leader>fe :RGE<cr>
" " remap fzf to ctrl+p
" nnoremap <silent> <c-p> :Files<cr>

" Find files using Telescope command-line sugar.
nnoremap <silent> <c-p> <cmd>Telescope find_files<cr>
" nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fe <cmd>Telescope grep_string<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" hop mappings
nnoremap <leader>j <cmd>HopWord<cr>
nnoremap <leader>k <cmd>HopPattern<cr>
nnoremap <leader>hl <cmd>HopLine<cr>


" vim-test mappings
nmap <silent> <leader>tn :TestNearest<cr>
nmap <silent> <leader>tf :TestFile<cr>
nmap <silent> <leader>ts :TestSuite<cr>
nmap <silent> <leader>tl :TestLast<cr>
nmap <silent> <leader>tg :TestVisit<cr>

" system keyboard
noremap <leader>y "+yy
noremap <leader>p "+p
noremap <leader>Y "+y
noremap <leader>P "+p

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

" change cursor from block to line on insert mode
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

" set slim filetype when .slim extention detected
autocmd BufNewFile,BufRead *.slim set ft=slim

set completeopt=menu,menuone,noselect

lua << EOF
  require'lspconfig'.solargraph.setup {
    settings = {
      solargraph = {
        commandPath = '/Users/glen/.rbenv/shims/solargraph',
        completion = true
      }
    },
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }

  require'lspconfig'.tsserver.setup {}
  require'lspconfig'.yamlls.setup {}
  require'lspconfig'.dockerls.setup {}

  local tabnine = require('cmp_tabnine.config')
  tabnine:setup({
    max_lines = 1000;
    max_num_results = 20;
    sort = true;
    run_on_every_keystroke = true;
  })

  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
        ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp', priority = 1 },
      { name = 'vsnip', priority = 2 },
      { name = 'path', priority = 5 },
      { name = 'buffer', priority = 4 },
    }
  })

  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end

  local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
      return true
    else
      return false
    end
  end

  local actions = require('telescope.actions')

  require('telescope').setup{
    defaults = {
      selection_caret = "> ",
      file_ignore_patterns = {
          ".gradle/*",
          "android/.gradle/*",
          "android/app/src/main/res/*",
          "android/app/src/staging/res/*"
      },
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        }
      },
      extensions = {
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = false, -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        }
      }
    }
  }

  require('telescope').load_extension('fzf')

  require('flutter-tools').setup({
    outline = { auto_open = false },
    decorations = {
      statusline = { device = true, app_version = true },
    },
    widget_guides = { enabled = true, debug = true },
    lsp = {
      settings = {
        showTodos = true,
        renameFilesWithClasses = 'prompt',
      }
    }
  })

  require("telescope").load_extension("flutter")

  require'hop'.setup()

  local lsp_installer = require("nvim-lsp-installer")

  lsp_installer.on_server_ready(function(server)
      local opts = {}
      server:setup(opts)
  end)

EOF

