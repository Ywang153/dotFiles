"********************************** Sections Guide  **********************************"
"    -> General
"    -> Vim user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Diff mode related
"    -> Moving around, tabs and buffers
"    -> Enable fold
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Status line
"    -> Plugins configure
"******************************************************************************"


"********************************** General **********************************"
" vim config, for more details, call :h feature-list
let $VIMHOME = $HOME
let $VIMFILES = $VIMHOME.'/.vim'

if filereadable(expand("$VIMHOME/.vimrc_base"))
    source $VIMHOME/.vimrc_base
endif

if filereadable(expand("$VIMHOME/.vimrc_util"))
    source $VIMHOME/.vimrc_util
endif

" change vimrc* with auto reload
autocmd! BufWritePost .vimrc* source %

" enable filetype plugins
filetype plugin on
filetype indent on

" set to auto read when a file is changed from the outside
set autoread

" the working directory is always the one containing the current file
set autochdir

" hide splashscreen
set shortmess+=filmnrxoOtT

" better unix / windows compatibility
set viewoptions=folds,options,cursor,unix,slash 

" allow for cursor beyond last character
set virtualedit=onemore

" paste text into vim command line
cmap <S-Insert>  <C-r><C-o>+

" fast saving
nmap <silent> <leader>wW :w !sudo tee %<cr>

" show register
nmap <silent> <leader>di :registers<CR>

" insert current date or timeInsert current date or time
nnoremap <silent> <leader>dt "=strftime("%c")<CR>P
inoremap <silent> <leader>dt <C-R>=strftime("%c")<CR>

" search and replace the word under the cursor
nnoremap <silent> <leader>sr :%s/\<<C-r><C-w>\>//g<Left><Left>

" Open the folder containing the currently open file
if WINDOWS()
    map <silent> <leader>!e :!explorer %:p:h:gs?\/?\\\\\\?<CR>
elseif OSX()
    " not set yet.
else
    if CYGWIN()
        map <silent> <leader>!e :!cygstart -x "%:p:h"<CR>
    elseif LINUX()
        map <silent> <leader>!e :!nautilus "%:p:h"<CR>
    else
        echoerr "Unseted platform!!"
    endif
endif


"********************************** Vim user interface **********************************"
" show line number
set nu
map <silent> <leader>nu :set nu!<cr>

" set 7 lines to the cursor - when moving vertically using j/k
set so=7

"no compatible mode
set nocompatible

" turn on the wild menu
set wildmenu

" ignore compiled files
set wildignore=*.o,*~,*.pyc

"always show current position
set ruler

" height of the command bar
set cmdheight=2

" a buffer becomes hidden when it is abandoned
set hid

" configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" don't redraw while executing macros (good performance config)
set lazyredraw

" show matching brackets when text indicator is over them
set showmatch

" how many tenths of a second to blink when matching brackets
set mat=2

" jump to last line, but stay in the same column
set nostartofline

" display an incomplete command
set showcmd

" set the terminal title
set title

" opening new buffer below the current
set splitbelow

" maintain more context around the cursor
set scrolloff=3

" no annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Show all characters that aren't whitespace.
set listchars=eol:$,nbsp:%,tab:>-,trail:~,extends:>,precedes:<
map <silent> <leader>sc :set list!<CR>

" accessing the system clipboard
if has('unnamedplus')
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif

" Windows gvim maximized
if WINDOWS()
    au GUIEnter * simalt ~x
else
    " vimtip1228
    set completeopt=longest,menuone

    " auto close preview windows after left insert mode
    autocmd CursorMovedI,InsertLeave * if pumvisible() == 0|pclose|endif

    " auto selected current item after press CR key
    inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    " arrow key will show other info
    inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
    inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
    inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
    inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
endif

noremap <leader>bg :call ToggleBG()<CR>


"********************************** Colors and Fonts **********************************"
" enable syntax highlighting
syntax enable

" set extra options when running in gui mode
if has("gui_running")		
    if WINDOWS()
        set guifont=Courier\ New
    elseif LINUX()
        set guifont=Courier\ 10\ Pitch
    else
    endif

    set guioptions-=T
    set guioptions-=e

    set background=light

    nmap <silent> <leader>gfnt :set guifont=*<CR>
else
	set background=dark
endif

" set 256 color
set t_Co=256

" set utf8 as standard encoding and en_us as the standard language
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gbk,euc-jp,euc-kr,latin1

let &termencoding=&encoding

" use Unix as the standard file type
set ffs=unix,dos,mac


"********************************** Files, backups and undo **********************************"
" turn backup off, since most stuff is in svn, git et.c anyway...
set nobackup
set nowb
set noswapfile

set isfname+=32

noremap <silent> <leader>fn :let @+ = expand("%:t")<CR>:echo "File Name Copied to Clipboard."<CR>
noremap <silent> <leader>fd :let @+ = expand("%:p:h")<CR>:echo "Current Directory Copied to Clipboard."<CR>
noremap <silent> <leader>fp :let @+ = expand("%:p")<CR>:echo "Full File Path Copied to Clipboard."<CR>

command! Bclose call <SID>BufcloseCloseIt()
command! BOld :new +setl\ buftype=nofile | 0put =v:oldfiles | nnoremap <buffer> <CR> :e <C-r>=getline('.')<CR><CR>

nnoremap <silent> <leader>mkv :call MakeView()<CR>
nnoremap <silent> <leader>lv :call LoadView()<CR>


"********************************** Text, tab and indent related **********************************"
" be smart when using tabs ;)
set smarttab

if has('mouse') " enable mouse
    set mouse=a
    set mousehide
endif

set splitright
set splitbelow

" linebreak on 512 characters
set lbr
set tw=512

set si "smart indent

nmap <silent> <leader>x :%!xxd<cr>
nmap <silent> <leader>X :%!xxd -r<cr>

nmap <silent> <leader>bl :g/^$/d<cr>

nmap <silent> <leader>utf8 :set fenc=utf-8<cr>

autocmd InsertLeave,TextChanged * if expand('%') != '' | update | endif " auto save file


"********************************** Visual mode related **********************************"
" search and replace selected text
vnoremap <silent> <leader>sr "hy:%s/<C-r>h//gc<left><left><left>

" make arrow keys work in visual mode under windows
set keymodel-=stopsel

" type \vl to toggle VeryLiteral to turn whitespace matching off/on
if !hasmapto("<Plug>VLToggle")
    nmap <unique> <Leader>vl <Plug>VLToggle
endif


"********************************** Moving around, tabs, windows and buffers **********************************"
" close the current buffer
let bclose_multiple = 0

" Close all the buffers
nmap <silent> <leader>bo :BufOnly!<cr>

" useful mappings for managing tabs
map <silent> <leader>tn :tabnew<cr>
map <silent> <leader>to :tabonly<cr>
map <silent> <leader>tc :tabclose<cr>
map <silent> <leader>tm :tabmove

" opens a new tab with the current buffer's path, super useful when editing files in the same directory
map <silent> <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" shift tab pages
map <silent> <S-t> :tabnext<CR>
map <silent> <S-y> :tabprev<CR>

set stal=1
set tabline=%!MyTabLine()

" switch CWD to the directory of the open buffer
map <silent> <leader>cd :cd %:p:h<cr>:pwd<cr>

" specify the behavior when switching between buffers
set switchbuf=useopen,usetab,newtab

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
	 
" Quickfix windows formating, and change.
au BufWinEnter quickfix  setlocal modifiable

" remember info about open buffers on close
set viminfo^=%

" set the maxiumu tab page number to 64
set tabpagemax=64
  
" toggles the quickfix window.
" http://vim.wikia.com/wiki/Toggle_to_open_or_close_the_quickfix_window
function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
nmap <silent> <leader>e :call ToggleList("Quickfix List", 'c')<CR>

command! -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction

nmap <silent> <leader>` :QFix<CR>


"********************************** Enable fold **********************************"
let g:xml_syntax_folding=1

set foldenable
set foldmethod=indent
set foldlevel=1
set foldlevelstart=99
set fdo-=search

nmap <silent> <leader>fc :call SetFoldColumn()<CR>

au FileType xml,c,cc,cpp,cxx,h,hpp setlocal foldmethod=syntax
au BufWinEnter * if &fdm == 'indent' | setlocal fdm=manual | endif


"********************************** Editing mappings **********************************"
" remap vim 0 to first non-blank character
" map 0 ^

" use black hole register to make vim not copy whenever you delete text
map <silent><leader>d "_d

" repeat last colon command
map <silent>gC @:

" move a line of text using alt+[jk] or comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if OSX()
    nmap <D-j> <M-j>
    nmap <D-k> <M-k>
    vmap <D-j> <M-j>
    vmap <D-k> <M-k>
endif

" delete trailing white space on save, useful for python and coffeescript ;)
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()


"********************************** vimgrep searching and cope displaying **********************************"
" get the word under the cursor, and searches for it in the current directory and all subdirectories, opening the quickfix window when done
command! F :exe "vimgrep /" . expand("<cword>") . "/j **" | copen

" get the word under the cursor, but limit the search to the current file only
map <silent> <leader>f :exe 'vimgrep /'.expand('<cword>').'/gj '.expand('%') <Bar> cw<CR>

" to go to the next search result
map <silent> <leader>i :cn<cr>

" to go to the previous search results
map <silent> <leader>o :cp<cr>

" when you search with vimgrep, display your results in cope
map <silent> <leader>bc :botright cope<cr>


"********************************** Spell checking **********************************"
" pressing ,ss will toggle and untoggle spell checking
map <silent> <leader>ss :setlocal spell!<cr>

" shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

map <silent> <leader>ds /\(\<\w\+\>\)\_s*\1<cr>

noremap <silent> <leader>sl :ToggleSlash<CR>


"********************************** Misc **********************************"
" remove the windows ^m - when the encodings gets messed up
noremap <silent> <Leader>D mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm

" quickly open a buffer for scripbble
map <silent> <leader>nb :new<CR>

" toggle paste mode on and off
set pastetoggle=<F6>

" format xml using xmllint
noremap <silent> <leader>fxml :set ft=xml<CR>:%! xmllint --format --recover - 2>/dev/null<CR>

" remove all blanks using xmllint
noremap <silent> <leader>lxm :%! xmllint --noblanks --recover - 2>/dev/null<CR>

" convert current file to html
noremap <silent> <leader>chtm :%TOhtml<CR>

" using tidy for cleaning up html
noremap <silent> <leader>fhtm :set ft=html<CR>:%! tidy --indent yes --wrap 0 --tidy-mark no --force-output true -quiet --show-errors 0 --show-warnings 0<CR>

" change color scheme
colorscheme desert

" enable syntax auto complete
set ofu=syntaxcomplete#Complete

" highlight tabline, popupmenu, and cursorcolumn
if has("gui_running")
    hi tablinefill cterm=NONE ctermfg=Black ctermbg=NONE
    hi tabline cterm=italic ctermfg=DarkGreen ctermbg=LightMagenta
    hi tablinesel gui=NONE guifg=Red guibg=Yellow
    
    hi Pmenu guifg=LightBlue guibg=DarkGray gui=bold
    hi PmenuSel guifg=DarkYellow guibg=LightMagenta gui=bold,italic
    
    hi CursorColumn gui=NONE guifg=#ffaf87 guibg=#5f5f5f
else
    hi tablinefill cterm=NONE ctermfg=Black ctermbg=NONE
    hi tabline cterm=italic ctermfg=DarkGreen ctermbg=LightMagenta
    hi tablinesel cterm=NONE ctermfg=Red ctermbg=Yellow
    
    hi Pmenu ctermfg=LightBlue ctermbg=DarkGray gui=bold
    hi PmenuSel ctermfg=DarkYellow ctermbg=LightMagenta gui=bold,italic
    
    hi CursorColumn cterm=NONE ctermfg=216 ctermbg=59
endif


"********************************** Diff mode related **********************************"
" To prevent vimdiff from asking you to press enter every time it starts
function! Compare(file)
    silent exe "vert diffsplit " . a:file
endfunction

" Usage :Compto[!] {other file}
command! -nargs=* -complete=file Compto call Compare(<q-args>)

if &diff
    " ignore white space in vimdiff
    set diffexpr=""

    " auto wrap
    setlocal wrap< 

    set shortmess=Ot

    set diffopt+=context:3
    set diffopt+=iwhite
    set diffopt+=indent-heuristic
    set nu
    set scrollbind

    " use theirs when merge
    noremap <silent> <leader>re :diffget RE<CR>:diffupdate<CR>
    " use base when merge
    noremap <silent> <leader>ba :diffget BA<CR>:diffupdate<CR>
    " use yours when merge
    noremap <silent> <leader>lo :diffget LO<CR>:diffupdate<CR>

    noremap ] ]c
    noremap [ [c
    
    colorscheme evening
    
    hi DiffChange   cterm=italic    ctermfg=50    ctermbg=53        gui=italic   guifg=#00ffdf       guibg=#5f005f
    hi DiffAdd      cterm=italic    ctermfg=9     ctermbg=2         gui=italic   guifg=#ff0000       guibg=#008000
    hi DiffText     cterm=bold      ctermfg=193   ctermbg=160       gui=bold     guifg=#dfffaf       guibg=#df0000
    hi DiffDelete   cterm=italic    ctermfg=48    ctermbg=95        gui=italic   guifg=#00ff87       guibg=#875f5f

    hi statusline   cterm=NONE    ctermfg=96    ctermbg=DarkCyan  gui=bold     guifg=LightMagenta  guibg=DarkCyan
    hi statuslinenc cterm=italic  ctermfg=96    ctermbg=DarkCyan  gui=italic   guifg=LightMagenta  guibg=DarkCyan
endif


"********************************** Status line **********************************"
" always show the status line
set laststatus=2

" format the status line
set statusline=%{HasPaste()}[File:\ %t%m%r%h%w][CWD:\ %<%{getcwd()}%h]%=[%{&ff}][%{''!=&fenc?&fenc:&enc}][Ln:\ %l/%L,\ Col:\ %v,\ %p%%]

if has("gui_running")
    hi search gui=bold,italic guibg=#5fff5f guifg=#5f5f5f  
    hi statusline gui=NONE guifg=LightMagenta guibg=DarkCyan
    hi statuslinenc gui=italic guifg=LightMagenta guibg=DarkCyan
else
    hi search cterm=bold,italic ctermfg=59 ctermbg=216 
    hi statusline cterm=NONE ctermfg=96 ctermbg=DarkCyan
    hi statuslinenc cterm=italic ctermfg=96 ctermbg=DarkCyan
endif


"********************************** Plugins configure **********************************"
if filereadable(expand("$VIMHOME/.vimrc_plugin"))
    source $VIMHOME/.vimrc_plugin
endif

noremap <silent> <Leader>ff :Autoformat<CR>

nmap <silent> <Leader>M :MarkClear<CR>

nnoremap <silent> <C-\> :TagbarToggle<CR>

nmap <silent> <leader>dox :Dox<cr>
nmap <silent> <leader>db :DoxBlock<cr>
nmap <silent> <leader>da :DoxAuthor<cr>

nmap <silent> <leader>ct :XtermColorTable<cr>

nmap <silent> <F3> :NERDTreeToggle <cr>

cnoreabbrev Ack Ack!
nnoremap <leader>a :Ack!<space>
xnoremap <leader>va y:Ack <C-r>=fnameescape(@")<CR><CR>

" sometimes cscope cannot jump correctly
nmap <silent> <C-]> :tj <C-R>=expand("<cword>")<CR><CR>

if LINUX()
    inoremap <silent> <leader>co <C-x><C-o>
    
    nnoremap <silent> <leader>yme :YcmToggleLogs stderr<CR>
    inoremap <silent> <S-F2> :YcmForceCompileAndDiagnostics<CR>
    nnoremap <silent> <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
endif

