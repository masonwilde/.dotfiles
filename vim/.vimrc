" ~/.vimrc — pure Vim, no plugins.
"
" Section 1 mirrors ~/.config/nvim (lua/config/{options,keymaps,autocmds}.lua)
" as closely as Vim allows. Section 2 is Vim-only ergonomics with no Neovim
" counterpart. Section 3 reimplements, in Vimscript, the handful of plugin
" behaviours worth keeping (comments, file finding, statusline, file tree).

set nocompatible
filetype plugin indent on
syntax enable

" ===========================================================================
" 1. Mirrors nvim
" ===========================================================================

set number
set relativenumber
set cursorline
set ruler
set title
set showcmd
set showmatch
set wildmenu
set hidden
set autoindent
set expandtab
set shiftwidth=2
set tabstop=2
set encoding=UTF-8
set mouse=
set ttimeoutlen=0
set splitright
set splitbelow
set ignorecase
set smartcase
set gdefault
set scrolloff=8
set sidescrolloff=8

" `lead` in 'listchars' needs 8.2.5066; degrade to tab/trail on older Vim.
if has('patch-8.2.5066')
  set listchars=tab:▸\ ,lead:·,trail:·
else
  set listchars=tab:▸\ ,trail:·
endif
set list

if has('unnamedplus')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif

" True colour, including inside tmux/screen where Vim needs the sequences spelt out.
if has('termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set background=dark
" onedark is a plugin; fall back through the closest bundled schemes.
for s:scheme in ['catppuccin', 'habamax', 'desert']
  try
    execute 'colorscheme' s:scheme
    break
  catch /^Vim\%((\a\+)\)\=:E185:/
  endtry
endfor

let mapleader = ' '

" Netrw stands in for Neo-tree.
nnoremap <silent> <leader>t :Lexplore<CR>
nnoremap <silent> <leader>r :Lexplore %:p:h<CR>

nnoremap <silent> <leader>o :vsplit<CR>
nnoremap <silent> <leader>p :split<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j

nnoremap <C-Left>  <C-w><
nnoremap <C-Right> <C-w>>
nnoremap <C-Up>    <C-w>+
nnoremap <C-Down>  <C-w>-

augroup vimrc_nvim_autocmds
  autocmd!
  " Stop auto-continuing comments on a new line.
  autocmd FileType * setlocal formatoptions-=r formatoptions-=o
  " Restore the cursor to its last position on file open.
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line('$') | execute "normal! g'\"" | endif
augroup END

" ===========================================================================
" 2. Vim-only ergonomics
" ===========================================================================

set noswapfile
set nowrap
set backspace=indent,eol,start
set wildmode=list:longest
set ttyfast
set lazyredraw
set belloff=all

" Block cursor in normal mode, bar in insert, underline in replace.
if !has('gui_running')
  let &t_SI = "\<Esc>[6 q"
  let &t_SR = "\<Esc>[4 q"
  let &t_EI = "\<Esc>[2 q"
endif

nnoremap <C-p> :bnext<CR>
nnoremap <C-o> :bprevious<CR>

" Ctrl-S saves from any mode.
nnoremap <silent> <C-s> :update<CR>
vnoremap <silent> <C-s> <C-c>:update<CR>
inoremap <silent> <C-s> <C-o>:update<CR>

nnoremap <silent> <C-q> :bdelete<CR>
nnoremap <C-a> ggVG

" Trailing whitespace, louder than the listchars marker.
augroup vimrc_extra_whitespace
  autocmd!
  autocmd ColorScheme  * highlight ExtraWhitespace ctermbg=red guibg=red
  autocmd BufWinEnter  * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter  * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave  * match ExtraWhitespace /\s\+$/
augroup END
highlight ExtraWhitespace ctermbg=red guibg=red

" Open the quickfix/location window after anything populates it.
augroup vimrc_quickfix
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l*    lwindow
augroup END

" ===========================================================================
" 3. Plugin behaviours, reimplemented
" ===========================================================================

" --- Neo-tree -> netrw ---
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 25
let g:netrw_altv = 1

" --- fzf-lua -> :find / :grep / :ls / :help ---
set path=.,,**
set wildignore+=*/node_modules/*,*/.git/*,*/dist/*,*/build/*,*/target/*,*/vendor/*
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case
  set grepformat=%f:%l:%c:%m
endif

nnoremap <leader>ff :find<Space>
nnoremap <leader>fg :grep!<Space>
nnoremap <leader>fb :ls<CR>:buffer<Space>
nnoremap <leader>fh :help<Space>

" --- Comment.nvim -> 'commentstring'-driven toggle ---

" Comment or uncomment [line1, line2], skipping blank lines. Uncomments only
" when every non-blank line is already commented, matching Comment.nvim.
function! s:CommentToggle(line1, line2) abort
  if &commentstring !~# '%s'
    return
  endif
  let l:lead = substitute(matchstr(&commentstring, '^.\{-}\ze%s'), '\s\+$', '', '')
  let l:tail = substitute(matchstr(&commentstring, '%s\zs.*$'), '^\s\+', '', '')
  let l:lines = filter(range(a:line1, a:line2), 'getline(v:val) =~# "\\S"')
  if empty(l:lines)
    return
  endif

  let l:pat = '^\s*' . escape(l:lead, '\.*$^~[]')
  let l:commented = 1
  for l:lnum in l:lines
    if getline(l:lnum) !~# l:pat
      let l:commented = 0
      break
    endif
  endfor

  let l:indent = min(map(copy(l:lines), 'match(getline(v:val), "\\S")'))
  for l:lnum in l:lines
    let l:text = getline(l:lnum)
    if l:commented
      let l:text = substitute(l:text, l:pat . '\s\?', repeat(' ', l:indent), '')
      if !empty(l:tail)
        let l:text = substitute(l:text, '\s\?' . escape(l:tail, '\.*$^~[]') . '\s*$', '', '')
      endif
    else
      let l:text = strpart(l:text, 0, l:indent) . l:lead . ' ' . strpart(l:text, l:indent)
      if !empty(l:tail)
        let l:text .= ' ' . l:tail
      endif
    endif
    call setline(l:lnum, l:text)
  endfor
endfunction

command! -range CommentToggle call <SID>CommentToggle(<line1>, <line2>)
nnoremap <silent> gcc :CommentToggle<CR>
xnoremap <silent> gc  :CommentToggle<CR>

" --- lualine -> 'statusline' ---
let s:modes = {
      \ 'n': 'NORMAL', 'i': 'INSERT', 'R': 'REPLACE', 'v': 'VISUAL',
      \ 'V': 'V-LINE', "\<C-v>": 'V-BLOCK', 'c': 'COMMAND', 's': 'SELECT',
      \ 'S': 'S-LINE', "\<C-s>": 'S-BLOCK', 't': 'TERMINAL',
      \ }

function! StatuslineMode() abort
  return get(s:modes, mode(), mode())
endfunction

" Cached per buffer; recomputed on enter/write rather than on every redraw.
function! s:UpdateGitBranch() abort
  let b:git_branch = ''
  if !executable('git') || empty(expand('%:p'))
    return
  endif
  let l:out = systemlist('git -C ' . shellescape(expand('%:p:h')) . ' rev-parse --abbrev-ref HEAD')
  if v:shell_error == 0 && !empty(l:out)
    let b:git_branch = l:out[0]
  endif
endfunction

function! StatuslineBranch() abort
  let l:branch = get(b:, 'git_branch', '')
  return empty(l:branch) ? '' : ' ⎇ ' . l:branch . ' │'
endfunction

augroup vimrc_git_branch
  autocmd!
  autocmd BufEnter,BufWritePost * call s:UpdateGitBranch()
augroup END

set laststatus=2
set noshowmode
let &statusline = ' %{StatuslineMode()} │%{StatuslineBranch()} %f %m%r%h%w%='
      \ . '%{&fileencoding !=# "" ? &fileencoding : &encoding} │ %{&fileformat} │ '
      \ . '%{&filetype !=# "" ? &filetype : "none"} │ %p%% │ %l:%c '
