" github.com/garybernhardt/dotfiles
" github.com/mislav/vimfiles
" vimcasts.org
" vim.wikia.com
" for more info on any settings
" :help <command> eg
" :help showcmd

call pathogen#infect()          " load pathogen
set nocompatible                " choose no compatibility with legacy vi
set encoding=utf-8              " sensible encoding
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation
set number                      " need those line numbers
set ruler                       " show the line/column number of the cursor position
set shell=sh                    " hack for rvm
"" Whitespace
set nowrap                      " wrap lines, switch with set wrap/nowrap
set linebreak                   " break line for wrapping at end of a word
set tabstop=2 shiftwidth=2      " a tab is two spaces
set expandtab                   " use spaces
set backspace=indent,eol,start  " backspace through everything in insert mode
set scrolloff=999               " Keep the cursor in the middle of the screen
set noesckeys                   " no arrow keys in insert mode

" Store temporary files in a central spot
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" remember more commands and search history
set history=10000
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,cucumber set ai sw=2 sts=2 et

  autocmd! BufRead,BufNewFile *.scss setfiletype scss
  autocmd! BufRead,BufNewFile *.js.erb setfiletype javascript
  autocmd! BufRead,BufNewFile *.cap setfiletype ruby
  autocmd! BufRead,BufNewFile *.feature setfiletype cucumber
  autocmd! BufRead,BufNewFile *.go setfiletype go
  autocmd! BufRead,BufNewFile *.pp setfiletype ruby
  autocmd FileType go compiler go

  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd FileType markdown setlocal wrap
  autocmd FileType qf setlocal wrap

  " Indent p tags
  autocmd FileType html,eruby if g:html_indent_tags !~ '\\|p\>' | let g:html_indent_tags .= '\|p\|li\|dt\|dd' | endif
augroup END

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
set wildmenu                    " enhanced command line completion
set wildignore+=*.o,*.obj,.bundle,coverage,doc,.DS_Store,_html,.git,*.rbc,*.class,.svn,vendor/gems/*,vendor/rails/*
set complete=.,w,b,u,t          " don't complete with included files (i)
set foldmethod=manual           " for super fast autocomplete

"" Colors
set term=xterm-256color
syntax enable
set background=dark             " or light
colorscheme solarized           " can't work with anything else
highlight LineNr ctermfg=darkgrey
set cursorline                  " highlight current line
set list                        " turn on invisible characters
set listchars=tab:▸\ ,trail:▝   " which characters to highlight
highlight NonText guifg=#444444
highlight SpecialKey guifg=#444444

" Window
set cmdheight=2                 " number of lines for the command line
set laststatus=2                " always have a status line
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
set showtabline=2               " always show tab bar
set winwidth=84                 "
set colorcolumn=80              " highlight at 80 characters

" Mappings
let mapleader=","               " use , as leader instead of backslash

" CTags
" navigate with <c-]> / <c-t>
map <Leader>ct :!ctags --exclude=public --exclude=spec --exclude=_html --exclude=tmp --exclude=log --exclude=coverage --extra=+f -R *<CR><CR>
map <C-\> :tnext<CR>
map <C-'> :tprev<CR>
" exclude javascript files
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" navigate buffers
nmap <C-n> :bnext<CR>
nmap <C-b> :bprev<CR>

" switch most recent buffers
nnoremap <leader><leader> <c-^>

" remove whitespace
map <leader>s :%s/\s\+$//<CR>

" replace :ruby => 'syntax' with ruby: 'syntax'
map <leader>pp :%s/:\([^ ]*\)\(\s*\)=>/\1:/g<cr>

" symbolize string
map <leader>ps :%s/[''"]\(\w\+\)[''"]/:\1/g<cr>

" clear the search buffer
nnoremap <CR> :nohlsearch<cr>

" Make <leader>' switch between ' and "
nnoremap <leader>' ""yls<c-r>={'"': "'", "'": '"'}[@"]<cr><esc>

" Tabs
nmap <leader>] :tabn<cr>
nmap <leader>[ :tabp<cr>
nmap T :tabnew<cr>

" Splits
" open tests in new split
map <leader>v :vs<cr>,.

" quick split and jump into window
map :vs :vsplit<cr><c-l>

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Remap shift key failure
command! W :w
command! Wq :wq
command! E :e

" Retain indent when pasting code
nnoremap <leader>pt :set invpaste paste?<CR>
set pastetoggle=<leader>pt
set showmode

" use OS clipboard
"set clipboard=unnamed

" force vim
map <Left> :echo "damnit!"<cr>
map <Right> :echo "you suck!"<cr>
map <Up> :echo "this is why you fail"<cr>
map <Down> :echo "nooooo!"<cr>

" evil mode
inoremap <Left> <nop>
inoremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>

" ctrl-p buffer search
:nmap ; :CtrlPBuffer<CR>
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" Plugin mappings
" Fugutive shortcuts
map :gs :Gstatus<cr>
map :gb :Gblame<cr>
map :gd :Gdiff<cr>

"  Ack
map <leader>/ :Ack<space>

" Use the silver searcher
let g:ackprg = 'ag --nogroup --nocolor --column'

" Powerline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'solarized'

" Open Markdown files in Marked.app
nnoremap <leader>m :silent !open -a Marked.app '%:p'<cr>:redraw!<cr>

" Run
map <leader>r :!ruby % -v<cr>

" Easy align
"   vip<Enter>=
"   `v`isual-select `i`nner `p`aragraph
"   Start EasyAlign command (<Enter>)
"   Align around =
vmap <Enter>   <Plug>(EasyAlign)
" <Leader>aip=
"   Start EasyAlign command (<Leader>a) for `i`nner `p`aragraph
"   Align around =
map <leader>e <Plug>(EasyAlign)

" Map keys to go to specific files
map <leader>gr :topleft :split config/routes.rb<cr>
function! ShowRoutes()
  " Requires 'scratch' plugin
  :topleft 100 :split __Routes__
  " Make sure Vim doesn't write __Routes__ as a file
  :set buftype=nofile
  " Delete everything
  :normal 1GdG
  " Put routes output in buffer
  :0r! rake -s routes
  " Size window to number of lines (1 plus rake output length)
  :exec ":normal " . line("$") . "_ "
  " Move cursor to bottom
  :normal 1GG
  " Delete empty trailing line
  :normal dd
endfunction
map <leader>gR :call ShowRoutes()<cr>
map <leader>gg :topleft 100 :split Gemfile<cr>

" Switch between test and production code
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '^app\/') != -1
  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end
    let new_file = substitute(new_file, '\.rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    end
  endif
  return new_file
endfunction
nnoremap <leader>. :call OpenTestAlternate()<cr>

" Running tests
map <Leader>t :call RunCurrentSpecFile()<cr>:redraw!<cr>
map <Leader>T :call RunNearestSpec()<cr>:redraw!<cr>
map <Leader>l :call RunLastSpec()<cr>:redraw!<cr>
map <Leader>a :call RunAllSpecs()<cr>:redraw!<cr>
map <leader>u :!ruby -I"lib:test" %<cr>:redraw!<cr>
map <leader>f :!bundle exec cucumber % -r features KEEP_RUNNING=1<cr>:redraw!<cr>

" run tests with Dispatch
let g:rspec_command = 'silent !echo bundle exec rspec --color {spec} > .test_commands'

 " When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif
augroup END

" Create parent folder when saving file
function s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction
augroup BWCCreateDir
  autocmd!
  autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
