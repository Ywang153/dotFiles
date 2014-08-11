"********************************** Sections **********************************"
"    -> General
"    -> Vim user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Enable fold
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Plugins
"    -> Misc
"    -> Helper functions
"********************************************************************"


"********************************** General **********************************"
" sets how many lines of history vim has to remember
set history=2048

" enable filetype plugins
filetype plugin on
filetype indent on

" set to auto read when a file is changed from the outside
set autoread

" with a map leader it's possible to do extra key combinations, like <leader>w saves the current file
let g:mapleader=","
let mapleader=","

" fast saving
nmap <leader>w :w!<cr>

" fast aborting
nmap <leader>a :q!<cr>

" vim config
let $VIM = $HOME
let $VIMFILES = $VIM.'/.vim'


"********************************** Vim user interface **********************************"
" show line number
set nu
map <leader>nu :set nu!<cr>

"highlight current line
set cursorline

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

" ignore case when searching
set ignorecase

" when searching try to be smart about cases
set smartcase

" highlight search results
set hlsearch

" makes search act like search in modern browsers
set incsearch

" don't redraw while executing macros (good performance config)
set lazyredraw

" for regular expressions turn magic on
set magic

" show matching brackets when text indicator is over them
set showmatch

" how many tenths of a second to blink when matching brackets
set mat=2

" no annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" set right margin
set colorcolumn=100


"********************************** Colors and Fonts **********************************"
" enable syntax highlighting
syntax enable

" set extra options when running in gui mode
if has("gui_running")		
    set guioptions-=T
    set guioptions+=e    
    set guitablabel=%N/\ %t\ %M	
else
	set background=dark
endif

" set 256 color
set t_Co=256

" change color scheme
colorscheme desert

" set utf8 as standard encoding and en_us as the standard language
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

" Use Unix as the standard file type
set ffs=unix,dos,mac


"********************************** Files, backups and undo **********************************"
" turn backup off, since most stuff is in svn, git et.c anyway...
set nobackup
set nowb
set noswapfile


"********************************** Text, tab and indent related **********************************"
" use spaces instead of tabs
set expandtab

" be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" linebreak on 512 characters
set lbr
set tw=512

set ai "auto indent
set si "smart indent

set wrap "wrap lines
nmap <S-w> :set wrap!<cr>


"********************************** Visual mode related **********************************"
" visual mode pressing * or # searches for the current selection. super useful!
vnoremap <silent> * :call VisualSelection('f')<cr>
vnoremap <silent> # :call VisualSelection('b')<cr>


"********************************** Moving around, tabs, windows and buffers **********************************"
" treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" map <space> to / (search) and ctrl-<space> to ? (backwards search)
map <space> /
map <c-space> ?

" disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" smart way to move between windows
map <C-j> <C-W>j
map <C-Down> <C-W>j
map <C-k> <C-W>k
map <C-Up> <C-W>k
map <C-h> <C-W>h
map <C-Left> <C-W>h
map <C-l> <C-W>l
map <C-Right> <C-W>l

" close the current buffer
map <leader>bd :Bclose<cr>

" close all the buffers
map <leader>ba :1,1000 bd!<cr>

" useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" opens a new tab with the current buffer's path, super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" shift tab pages
nmap <S-Left> :tabp<cr>
nmap <S-Right> :tabn<cr>

" switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2   
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
	 
" remember info about open buffers on close
set viminfo^=%

" set the maxiumu tab page number to 64
set tabpagemax=64
  
" hilight tabline  
hi tabline term=bold cterm=bold ctermfg=DarkGreen ctermbg=DarkGray
hi tablinesel term=bold cterm=italic ctermfg=Red ctermbg=Yellow

" scrolling horizontally
nmap <S-u> 4zh
nmap <S-d> 4zl


"********************************** Status line **********************************"
" always show the status line
set laststatus=2

" format the status line
set statusline=[File:\ %t%m%r%h%w][CWD:\ %<%{getcwd()}%h]%=[%{&ff}][%{''!=&fenc?&fenc:&enc}][Ln:\ %l/%L,\ Col:\ %v,\ %p%%]

" hilight statusline
hi statusline term=bold cterm=bold ctermfg=DarkYellow ctermbg=Cyan


"********************************** Enable fold **********************************"
set foldenable
set foldmethod=indent
set foldcolumn=4
set foldlevel=1
set foldlevelstart=99

nmap <leader>fd :set foldenable!<cr>


"********************************** Editing mappings **********************************"
" remap vim 0 to first non-blank character
" map 0 ^

" cut selected to system clipboard
vnoremap <leader>x "*x

" copy selected to system clipboard
vnoremap <leader>y "*y

" copy current line to system clipboard
noremap <leader>yy "*yy

" copy current word to system clipboard
noremap <leader>yw "*yaw

" cut current line to system clipboard
noremap <leader>dd "*dd

" paste from system clipboard
nmap <leader>p "*p

" move a line of text using alt+[jk] or comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" delete trailing white space on save, useful for python and coffeescript ;)
function! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()


"********************************** vimgrep searching and cope displaying **********************************"
" when you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<cr>

" open vimgrep and put the cursor in the right position
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" vimgreps in the current file
map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" when you press <leader>h you can search and replace the selected text
vnoremap <silent> <leader>h :call VisualSelection('replace')<cr>

" when you search with vimgrep, display your results in cope
map <leader>cc :botright cope<cr>

map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg

" to go to the next search result
map <leader>i :cn<cr>

" to go to the previous search results
map <leader>o :cp<cr>


"********************************** Spell checking **********************************"
" pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"********************************** Plugins **********************************"
" taglist
nmap <F11> : TlistToggle <cr>

" auto search ctags prog
set tags=tags;

let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Auto_Update=1
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=1
let Tlist_Auto_Open=0
let Tlist_File_Fold_Auto_Close=1
let Tlist_Sort_Type=1

function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  let resp = system(cmd)
endfunction

function! UpdateTags()
  let f = expand("%:p")
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let cmd = 'ctags -a -f ' . tagfilename . ' --c++-kinds=+p --fields=+iaS --extra=+q ' . '"' . f . '"'
  " call DelTagOfFile(f)
  let resp = system(cmd)
endfunction

" automatically update the ctags file when a file is written
autocmd BufWritePost *.cpp,*.c,*.cc,*.cxx,*.h,*.hpp,*.hxx,*.inl,*.log,*.js,*.asp,*.xml,*.xsl,*.java,*.proto call UpdateTags()


" NERD tree
nmap <F3> : NERDTreeToggle <cr>

" Cscope
function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction

au BufEnter /* call LoadCscope()

" use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
set cscopetag

" check cscope for definition of a symbol before checking ctags: set to 1
" if you want the reverse search order.
set csto=1

" show msg when any other cscope db added
set cscopeverbose 

" The following maps all invoke one of the following cscope search types:
"
"   's'   symbol: find all references to the token under cursor
"   'g'   global: find global definition(s) of the token under cursor
"   'c'   calls:  find all calls to the function name under cursor
"   't'   text:   find all instances of the text under cursor
"   'e'   egrep:  egrep search for the word under cursor
"   'f'   file:   open the filename under cursor
"   'i'   includes: find files that include the filename under cursor
"   'd'   called: find functions that function under cursor calls

" To do the first type of search, hit 'CTRL-\', followed by one of the
" cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
" search will be displayed in the current window.  You can use CTRL-T to
" go back to where you were before the search.  
"

nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>  
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>  
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>  
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>  
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>  
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>  
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>  

" Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
" makes the vim window split horizontally, with search result displayed in
" the new window.
"
" (Note: earlier versions of vim may not have the :scs command, but it
" can be simulated roughly via:
"    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>  

nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR> 
nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR> 
nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR> 
nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR> 
nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR> 
nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR> 
nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>   
nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR> 

" Hitting CTRL-space *twice* before the search type does a vertical 
" split instead of a horizontal one (vim 6 and up only)
"
" (Note: you may wish to put a 'set splitright' in your .vimrc
" if you prefer the new window on the right instead of the left

nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>   
nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR> 
nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>


" vim-addon-manager
fun! EnsureVamIsOnDisk(plugin_root_dir)
  let vam_autoload_dir = a:plugin_root_dir.'/vim-addon-manager/autoload'
  if isdirectory(vam_autoload_dir)
    return 1
  else
    if 1 == confirm("Clone VAM into ".a:plugin_root_dir."?","&Y\n&N")
      call confirm("Remind yourself that most plugins ship with ".
                  \"documentation (README*, doc/*.txt). It is your ".
                  \"first source of knowledge. If you can't find ".
                  \"the info you're looking for in reasonable ".
                  \"time ask maintainers to improve documentation")
      call mkdir(a:plugin_root_dir, 'p')
      execute '!git clone --depth=1 https://github.com/MarcWeber/vim-addon-manager '.
                  \ shellescape(a:plugin_root_dir, 1).'/vim-addon-manager'
      " VAM runs helptags automatically when you install or update
      " plugins
      exec 'helptags '.fnameescape(a:plugin_root_dir.'/vim-addon-manager/doc')
    endif
    return isdirectory(vam_autoload_dir)
  endif
endfunction

fun! CustomGitCheckout(repository, targetDir)
	let a:repository.url = substitute(a:repository.url, '^git://github', 'https://github', '')
	return vam#utils#RunShell('git clone --depth=1 $.url $p', a:repository, a:targetDir)
endfunction

fun! SetupVAM()
  " Set advanced options like this:
  let g:vim_addon_manager = {'scms': {'git': {}}}
  " let g:vim_addon_manager.key = value
  " Pipe all output into a buffer which gets written to disk
  " let g:vim_addon_manager.log_to_buf =1

  " Example: drop git sources unless git is in PATH. Same plugins can
  " be installed from www.vim.org. Lookup MergeSources to get more control
  " let g:vim_addon_manager.drop_git_sources = !executable('git')
  " let g:vim_addon_manager.debug_activation = 1

  " VAM install location:
  let c = get(g:, 'vim_addon_manager', {})
  let g:vim_addon_manager = c
  let g:vim_addon_manager.scms.git.clone=['CustomGitCheckout']
  let c.plugin_root_dir = expand('$VIMFILES/vim-addons', 1)
  if !EnsureVamIsOnDisk(c.plugin_root_dir)
    echohl ErrorMsg | echomsg "No VAM found!" | echohl NONE
    return
  endif
  let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'

  " Tell VAM which plugins to fetch & load:
  call vam#ActivateAddons(['The_NERD_tree', 'taglist', 'a', 'fencview', 'minibufexplorer', 'netrw', 'Mark%2666', 'c%213', 'OmniCppComplete', 'echofunc', 'ctrlp', 'snipmate'], {'auto_install' : 0})
  " sample: call vam#ActivateAddons(['pluginA','pluginB', ...], {'auto_install' : 0})
endfunction

call SetupVAM()


" MiniBufExplorer
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplModSelTarget = 1 
let g:miniBufExplMapWindowNavArrows = 1


" OmniCppComplete
set completeopt=menuone,menu,longest,preview

let OmniCpp_NamespaceSearch = 2     
let OmniCpp_GlobalScopeSearch = 1      
let OmniCpp_DisplayMode = 1
let OmniCpp_ShowScopeInAbbr = 1
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_ShowAccess = 1      
let OmniCpp_MayCompleteDot = 1      
let OmniCpp_MayCompleteArrow = 1      
let OmniCpp_MayCompleteScope = 1      
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

" fencview
let g:fencview_autodetect = 1
let g:fencview_checklines = 16


"********************************** Misc **********************************"
" remove the windows ^m - when the encodings gets messed up
noremap <Leader>M mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>

" toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" sort file, and removing duplicate lines
map <leader>su :sort u<cr>

" format xml using xmllint
au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

" enable syntax auto complete
set ofu=syntaxcomplete#Complete


"********************************** Helper functions **********************************"
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg=@"
    execute "normal! vgvy"

    let l:pattern=escape(@", '\\/.*$^~[]')
    let l:pattern=substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/=l:pattern
    let @"=l:saved_reg
endfunction

" returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return true
    else
		return false
	endif
endfunction

" don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()

function! <SID>BufcloseCloseIt()
   let l:currentBufNum=bufnr("%")
   let l:alternateBufNum=bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction


