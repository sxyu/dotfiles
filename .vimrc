set nocompatible              " be iMproved, required
set hidden

" Alex's minimalist portable vimrc
filetype plugin indent on
color moody
set nu rnu undofile expandtab ts=4 sw=4 ruler guifont=Monospace\ 11 sta incsearch
set synmaxcol=256
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

imap hh <ESC>

set fdm=indent
set backupdir=/home/sxyu/.vim/tmp
set directory=/home/sxyu/.vim/tmp
set undodir=/home/sxyu/.vim/tmp

set backspace=indent,eol,start
let mapleader=' '
let cc='!g++ -lm -std=c++17 -Wall -O2 -g % -o %< && printf "Compile done, await input\n" 1>&2 &&'
let py='!python %'
let ouf='$PWD/%<'
let inp=' < %<.in'


" F5/F6/F4/F7 to compile, run, etc for C++, Python
autocmd filetype c nnoremap <F5> :w <bar> AsyncRun gcc -lm -std=c99 -Wall -O2 % -o %< && printf "Compile done, await input\n" 1>&2 && urxvt -e bash -c '${PWD}/%<; read -n 1 -s -r -p ""'<CR>
autocmd filetype cpp nnoremap <F5> :w <bar> AsyncRun urxvt -e bash -c 'g++ -lm -g -std=c++17 -Wall -O2 % -o %<&& printf "Compile done, await input\n" 1>&2 && ${PWD}/%< \|\| printf "Compile and run failed! Press any key to close\n"; read -n 1 -s -r -p ""'<CR>
autocmd filetype tex nnoremap <F5> :w <bar> AsyncRun pdflatex % && evince %<.pdf<CR>
"autocmd BufWritePost *.tex AsyncRun pdflatex % && evince %<.pdf | redraw!

autocmd filetype python nnoremap <F5> :w <bar> AsyncRun urxvt -e bash -c 'printf "python3 %\n" && python3 %; read -n 1 -s -r -p ""'<CR>
autocmd filetype cpp nnoremap <F6> :w <bar> AsyncRun urxvt -e bash -c 'g++ -lm -std=c++17 -Wall -O2 % -o %<&& time ${PWD}/%< < ${PWD}/%<.in \|\| printf "Compile failed! Press any key to close\n"; read -n 1 -s -r -p ""'<CR>
autocmd filetype python nnoremap <F6> :w <bar> AsyncRun urxvt -e bash -c 'time python3 % && read -n 1 -s -r -p ""'<CR>
"autocmd filetype cpp nnoremap <F8> :exec '!'.ouf<CR>
autocmd filetype cpp nnoremap <F8> :AsyncRun urxvt -e bash -c '${PWD}/%<; read -n 1 -s -r -p ""'<CR>
autocmd filetype cpp nnoremap <F7> :AsyncRun urxvt -e bash -c '${PWD}/%< < ${PWD}/%<.in; read -n 1 -s -r -p ""'<CR>

nnoremap <F1> /\V\<\><left><left>
" autocmd filetype cpp nnoremap <F2> "2yiw <bar> :%s/\V\<<C-R>2\>//g<left><left>
" autocmd filetype cpp nnoremap <F3> "2yiw <bar> va}:s/\V\<<C-R>2\>//g<left><left>
noremap <F4> :set hlsearch! hlsearch?<CR>
noremap <F12> <C-O>

let @k="astatic_cast<>()hhi"
let @y="gg\"+yG''"
let @p="gg=G''"
let @w="yiwowhile(p--) {}k"
let @f="yiwofor() {}kllll"

" CMake helpers: compile
nnoremap <F9> :w <bar> exec 'cd build' <bar> exec '!cmake .. -DCMAKE_BUILD_TYPE=Release & make -j12 & $(grep -i OUTPUT_NAME CMakeLists.txt \| head -n 1 \| cut -d'\"' -f2 \| trim)' <bar> exec 'cd ..' <CR>
" Smart run: parse project name from CmakeLists!
nnoremap <F10> :exec "!build/$(grep -i OUTPUT_NAME CMakeLists.txt \| head -n 1 \| cut -d'\"' -f2 \| trim)" <CR>
" Deploy
nnoremap <F11> :exec "!deploy build/$(grep -i OUTPUT_NAME CMakeLists.txt \| head -n 1 \| cut -d'\"' -f2 \| trim)" <CR>

" comma+c to auto comment, +u to uncomment
"autocmd filetype python nnoremap <leader>c :norm ^i#<CR>
"autocmd filetype cpp nnoremap <leader>c :norm ^i//<CR>
"autocmd filetype python nnoremap <leader>u :norm ^x<CR>
"autocmd filetype cpp nnoremap <leader>u :norm ^xx<CR>
"autocmd filetype python vnoremap <leader>c :norm ^i#<CR>
"autocmd filetype cpp vnoremap <leader>c :norm ^i//<CR>
"autocmd filetype python vnoremap <leader>u :norm ^x<CR>
"autocmd filetype cpp vnoremap <leader>u :norm ^xx<CR>
nnoremap <leader>L :so ~/.vimrc<CR>

" double tap comma to clear highlights
nnoremap <leader><leader> :noh<CR>
nmap <leader>n <Plug>(coc-diagnostic-next)
nmap <leader>N <Plug>(coc-diagnostic-prev)
"nnoremap <M-n> :<CR>
"nnoremap <M-N> :LspPreviousReference<CR>
nnoremap <leader>S :syntax sync fromstart<CR>

" split screen (window) switching
nnoremap <silent> <C-UP> :wincmd k<CR>
nnoremap <silent> <C-DOWN> :wincmd j<CR>
nnoremap <silent> <C-LEFT> :wincmd h<CR>
nnoremap <silent> <C-RIGHT> :wincmdlh<CR>

" misc
syntax enable
set ttimeoutlen=10
set fileencodings=ucs-bom,utf-8,latin1
set encoding=utf-8
set nospell

let $BASH_ENV = "~/.bash_aliases"

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

let g:switch_mapping = "-"
let g:switch_custom_definitions =
            \ [
            \   ['<', '>'],
            \   ['<=', '>='],
            \   ['first', 'second']
            \ ]

" Mucomplete
set completeopt-=preview
set completeopt+=menuone,noselect
let g:mucomplete#enable_auto_at_startup = 1
let g:clang_library_path = '/usr/lib/llvm-4.0/lib/libclang-4.0.0.so'
let g:clang_user_options = '-std=c++17'
let g:clang_complete_auto = 1
let g:mucomplete#user_mappings = { 'sqla' : "\<c-c>a" }

set noinfercase

let g:mucomplete#chains = {}
let g:jedi#popup_on_dot = 0  " It may be 1 as well
if !(has('python') || has('python3'))
    " Define whatever completion chain you want, but without 'omni':
    let g:mucomplete#chains.python = ['path', 'keyn']
endif

let g:gutentags_enable = 0

" VIM LSC

" let g:lsc_server_commands = {
"             \ 'cpp': {
"             \    'command': 'ccls -log-file=/tmp/ccls.log -v=1',
"             \    'message_hooks': {
"             \        'initialize': {
"             \            'initializationOptions': {'cache': {'directory': '/tmp/ccls/cache'}},
"             \            'rootUri': {m, p -> lsc#uri#documentUri(fnamemodify(findfile('compile_commands.json', expand('%:p') . ';'), ':p:h'))}
"             \        },
"             \    },
"             \    'suppress_stderr': v:true,
"             \  },
"             \ 'cuda': {
"             \    'command': 'ccls -log-file=/tmp/ccls.log -v=1',
"             \    'message_hooks': {
"             \        'initialize': {
"             \            'initializationOptions': {'cache': {'directory': '/tmp/ccls/cache'}},
"             \            'rootUri': {m, p -> lsc#uri#documentUri(fnamemodify(findfile('compile_commands.json', expand('%:p') . ';'), ':p:h'))}
"             \        },
"             \    },
"             \    'suppress_stderr': v:false,
"             \  },
"             \ 'c': {
"             \    'command': 'ccls -log-file=/tmp/ccls.log -v=1',
"             \    'message_hooks': {
"             \        'initialize': {
"             \            'initializationOptions': {'cache': {'directory': '/tmp/ccls/cache'}},
"             \            'rootUri': {m, p -> lsc#uri#documentUri(fnamemodify(findfile('compile_commands.json', expand('%:p') . ';'), ':p:h'))}
"             \        },
"             \    },
"             \    'suppress_stderr': v:true,
"             \  },
"             \ 'javascript': 'typescript-language-server --stdio'
"             \}
"
" let g:lsc_auto_map = {
"             \  'GoToDefinition': '<leader>g',
"             \  'Rename': '<F2>',
"             \ 'GoToDefinitionSplit': ['<C-W>]', '<C-W><C-]>'],
"             \ 'FindReferences': 'gr',
"             \ 'NextReference': '<C-n>',
"             \ 'PreviousReference': '<C-p>',
"             \ 'FindImplementations': 'gI',
"             \ 'FindCodeActions': '<C-f>',
"             \ 'ShowHover': v:true,
"             \ 'DocumentSymbol': 'go',
"             \ 'WorkspaceSymbol': 'gS',
"             \ 'SignatureHelp': 'gm',
"             \ 'Completion': 'completefunc',
"             \}
" nn Q :LSClientGoToDefinition<CR>
" nn <leader>E :LSClientAllDiagnostics<CR>
" nn <leader>f :LSClientFindCodeActions '?'<CR>
" let g:lsc_autocomplete_length = 1
" let g:lsc_trace_level = 'verbose'

" Remap for destroying trailing whitespace cleanly
nnoremap <leader>w :let _save_pos=getpos(".") <Bar>
            \ :let _s=@/ <Bar>
            \ :%s/\s\+$//e <Bar>
            \ :let @/=_s <Bar>
            \ :nohl <Bar>
            \ :unlet _s<Bar>
            \ :call setpos('.', _save_pos)<Bar>
            \ :unlet _save_pos<CR> <Bar>:w<CR>

nnoremap <leader>W :%s/\t/    /ge <Bar>:w<CR>

" VIM LSP

" if executable('ccls')
"    au User lsp_setup call lsp#register_server({
"       \ 'name': 'ccls',
"       \ 'cmd': {server_info->['ccls']},
"       \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
"       \ 'initialization_options': {},
"       \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
"       \ })
" endif
" if executable('pyls')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'pyls',
"         \ 'cmd': {server_info->['pyls']},
"         \ 'whitelist': ['python'],
"         \ })
" endif
" if executable('texlab')
"     au User lsp_setup call lsp#register_server({
"             \ 'name': 'texlab',
"             \ 'cmd': {server_info->['texlab']},
"             \ 'whitelist': ['bib','tex'],
"             \ })
"     set hidden
" endif
" " if executable('ctags')
" "     au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#tags#get_source_options({
" "     \ 'name': 'tags',
" "     \ 'whitelist': ['c', 'cpp'],
" "     \ 'completor': function('asyncomplete#sources#tags#completor'),
" "     \ 'config': {
" "     \    'max_file_size': 50000000,
" "     \  },
" "     \ }))
" " endif
" if executable('typescript-language-server')
"     au User lsp_setup call lsp#register_server({
"       \ 'name': 'javascript support using typescript-language-server',
"       \ 'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
"       \ 'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..'))},
"       \ 'whitelist': ['javascript', 'javascript.jsx']
"       \ })
" endif
" if executable('css-languageserver')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'css-languageserver',
"         \ 'cmd': {server_info->[&shell, &shellcmdflag, 'css-languageserver --stdio']},
"         \ 'whitelist': ['css', 'less', 'sass'],
"         \ })
" endif
" if executable('html-languageserver')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'html-languageserver',
"         \ 'cmd': {server_info->[&shell, &shellcmdflag, 'html-languageserver --stdio']},
"         \ 'whitelist': ['html'],
"         \ })
" endif
" if executable('java') && filereadable(expand('~/lsp/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.5.300.v20190213-1655.jar'))
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'eclipse.jdt.ls',
"         \ 'cmd': {server_info->[
"         \     'java',
"         \     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
"         \     '-Dosgi.bundles.defaultStartLevel=4',
"         \     '-Declipse.product=org.eclipse.jdt.ls.core.product',
"         \     '-Dlog.level=ALL',
"         \     '-noverify',
"         \     '-Dfile.encoding=UTF-8',
"         \     '-Xmx1G',
"         \     '-jar',
"         \     expand('~/lsp/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.5.300.v20190213-1655.jar'),
"         \     '-configuration',
"         \     expand('~/lsp/eclipse.jdt.ls/config_linux'),
"         \     '-data',
"         \     getcwd()
"         \ ]},
"         \ 'whitelist': ['java'],
"         \ })
" endif
" if executable('bash-language-server')
"   au User lsp_setup call lsp#register_server({
"         \ 'name': 'bash-language-server',
"         \ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
"         \ 'whitelist': ['sh'],
"         \ })
" endif
" "let g:lsp_signs_enabled = 1         " enable signs
" let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
"set completeopt+=preview

" nn <silent> <leader>g :LspDefinition<cr>
" nn <silent> Q :LspDefinition<cr>
" nn <silent> <leader>r :LspReferences<cr>
" nn <silent> <leader>f :LspCodeAction<cr>
" nn <f2> :LspRename<cr>
" nn <silent> <leader>a :LspWorkspaceSymbol<cr>
" nn <silent> <leader>l :LspDocumentSymbol<cr>
" nn <silent> <leader>k :LspHover<cr>
" nn <silent> <S-K> :LspHover<cr>

"set termguicolors
set t_Co=256

"let g:asyncrun_open = 8

" includes
autocmd filetype cpp nmap <leader>in o#include ""<Esc>$i
autocmd filetype cpp imap <C-y>i <Esc><leader>i
autocmd filetype cpp nmap <leader>In o#include <><Esc>$i
autocmd filetype cpp imap <C-y><C-i> <Esc><leader>I

autocmd filetype cpp nmap <leader>io Oios::sync_with_stdio(0); cin.tie(0);<Esc>j
autocmd filetype cpp nmap <leader>ifi ofor(int i = 0; i < ; ++i) {<CR>}<Esc>k^2f;i
autocmd filetype cpp nmap <leader>ifj ofor(int j = 0; j < ; ++j) {<CR>}<Esc>k^2f;i
autocmd filetype cpp nmap <leader>ifk ofor(int k = 0; k < ; ++k) {<CR>}<Esc>k^2f;i
autocmd filetype cpp nmap <leader>ifl ofor(int l = 0; l < ; ++l) {<CR>}<Esc>k^2f;i
autocmd filetype cpp nmap <leader>i1i ofor(int i = 1; i <= ; ++i) {<CR>}<Esc>k^2f;i
autocmd filetype cpp nmap <leader>i1j ofor(int j = 1; j <= ; ++j) {<CR>}<Esc>k^2f;i
autocmd filetype cpp nmap <leader>i1k ofor(int k = 1; k <= ; ++k) {<CR>}<Esc>k^2f;i
autocmd filetype cpp nmap <leader>i1l ofor(int l = 1; l <= ; ++l) {<CR>}<Esc>k^2f;i
autocmd filetype cpp nmap <leader>idi ofor(int i = -1; i >= 0; --i) {<CR>}<Esc>k^f-a
autocmd filetype cpp nmap <leader>idj ofor(int j = -1; j >= 0; --j) {<CR>}<Esc>k^f-a
autocmd filetype cpp nmap <leader>idk ofor(int k = -1; k >= 0; --k) {<CR>}<Esc>k^f-a
autocmd filetype cpp nmap <leader>idl ofor(int l = -1; l >= 0; --l) {<CR>}<Esc>k^f-a
autocmd filetype cpp nmap <leader>irn Ocin >> N;<ESC>i
autocmd filetype cpp nmap <leader>irm Ocin >> M;<ESC>i
autocmd filetype cpp nmap <leader>irk Ocin >> K;<ESC>i
autocmd filetype cpp nmap <leader>irv Ocin >> V;<ESC>i
autocmd filetype cpp nmap <leader>ire Ocin >> E;<ESC>i
autocmd filetype cpp nmap <leader>irt Ocin >> T;<ESC>i
autocmd filetype cpp nmap <leader>irl Ocin >> L;<ESC>i
autocmd filetype cpp nmap <leader>irs Ocin >> S;<ESC>i
autocmd filetype cpp nmap <leader>irw Ocin >> W;<ESC>i
autocmd filetype cpp nmap <leader>it ggjo<CR>typedef int64_t ll;<CR>#define int int64_t<Esc>j
autocmd filetype cpp nmap <leader>ii ggO#include <bits/stdtr1c++.h><CR>using namespace std;<Esc>j
autocmd filetype cpp nmap <leader>ip otypedef pair<int, int> ii;<CR>#define ff first<CR>#define ss second<CR><Esc>j
autocmd filetype cpp nmap <leader>im oint32_t main(void){<CR>return 0;<CR>}<Esc>kko

autocmd filetype cpp nmap <leader>mi oint () {<CR>}<Esc>kt(a
autocmd filetype cpp nmap <leader>mv ovoid () {<CR>}<Esc>kt(a
autocmd filetype cpp nmap <leader>md odouble () {<CR>}<Esc>kt(a

autocmd filetype cpp nmap <leader>dp ggjo#define BEGIN_PROFILE auto start = std::chrono::high_resolution_clock::now()<CR>#define PROFILE(x) do{printf("%s: %f ms\n", #x, std::chrono::duration<double, std::milli>(std::chrono::high_resolution_clock::now() - start).count()); start = std::chrono::high_resolution_clock::now(); }while(false)<Esc>''
autocmd filetype cpp nmap <leader>dw ggjo#define WAT(x) cerr<<(#x)<<"="<<(x)<<endl<CR>#define WAT2(x,y) cerr<<(#x)<<"="<<(x)<<" "<<(#y)<<"="<<(y)<<endl<CR>#define WAT3(x,y,z) cerr<<(#x)<<"="<<(x)<<" ",WAT2(y,z)<CR>#define PELN cerr<<"\n";<CR>#define PE1(x) cerr<<(x)<<endl<CR>#define PE2(x,y) cerr<<(x)<<" "<<(y)<<endl<CR>#define PARR(a,s,e) for(size_t _c=size_t(s);_c<size_t(e);++_c)cout<<(a[_c])<<(_c==size_t(e-1)?"":" ");<Esc>''
autocmd filetype cpp nmap <leader>do ggjotemplate <class T1, class T2> std::ostream& operator<<(std::ostream& os, const std::pair<T1, T2> & p){ return os << p.ff << "," << p.ss; }<CR>template <class T> std::ostream& operator<<(std::ostream& os, const std::vector<T> & v){ for(int i=0; i<(int)v.size();++i){ if(i) os << " "; os << v[i];} return os; }<CR>template <class T, size_t N> std::ostream& operator<<(std::ostream& os, const std::array<T, N> & v){ for(int i=0; i<(int)v.size();++i){ if(i) os << " "; os << v[i];} return os; }<ESC>''

autocmd filetype cpp nmap <leader>c4 oconst int MAX = 10015;<Esc>F=hi
autocmd filetype cpp nmap <leader>c5 oconst int MAX = 100015;<Esc>F=hi
autocmd filetype cpp nmap <leader>c6 oconst int MAX = 1000015;<Esc>F=hi
autocmd filetype cpp nmap <leader>c7 oconst int MAX = 10000015;<Esc>F=hi
autocmd filetype cpp nmap <leader>cp oconst int MOD = 1000000007;<Esc>F=hi

autocmd filetype cpp nmap <leader>dvi ivector<int><space>
autocmd filetype cpp nmap <leader>dvd ivector<double><space>
autocmd filetype cpp nmap <leader>va viwo<esc>ea.begin()<Esc>F.hvbyf)a,<space><Esc>pa.end()<Esc>

autocmd filetype cpp nmap <leader>au yiwea.resize(unique(<Esc>pa.begin(), <Esc>pa.end()) - <Esc>pa.begin());<Esc>
autocmd filetype cpp imap <C-y>u .resize(unique(.begin(), .end()) - .begin());
autocmd filetype cpp nmap <leader>as diwisort(<Esc>pa.begin(), <esc>pa.end());<Esc>==
autocmd filetype cpp imap <C-y>s sort(.begin(), .end());
autocmd filetype cpp nmap <leader>orr i<space>>><space>
autocmd filetype cpp imap <C-y>r <space>>><space>
autocmd filetype cpp nmap <leader>oll i <space><<<space>
autocmd filetype cpp imap <C-y>l <space><<<space>

autocmd filetype python nmap <leader>ip ifrom matplotlib import pyplot as plt<Esc>
autocmd filetype python imap <C-y>ip <Esc><leader>ip
autocmd filetype python nmap <leader>in iimport numpy as np<Esc>
autocmd filetype python imap <C-y>in <Esc><leader>in
autocmd filetype python nmap <leader>it iimport torch<return>import torch.nn as nn<return>import torch.nn.functional as F<return>import torch.optim as optim<return><Esc>
autocmd filetype python imap <C-y>it <Esc><leader>it
autocmd filetype python nmap <leader>id idevice = torch.device("cuda" if torch.cuda.is_available() else "cpu")<Esc>
autocmd filetype python imap <C-y>id <Esc><leader>id

" highlight last inserted text
nnoremap gV `[v`]

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>
" save session
nnoremap <leader>s :mksession<CR>

" Keep all folds open when a file is opened
augroup OpenAllFoldsOnFileOpen
    autocmd!
    autocmd BufRead * normal zR
augroup END

" vim-cmake / manual cmake integration
let g:cmake_build_type = 'Release'
nnoremap <leader>mC :CMake<CR>

if filereadable(".ayuproj")
    let t:last_make = readfile('.ayuproj')[0]
    let t:last_run = readfile('.ayuproj')[1]
endif

" Helpers for CMake projects with ./build directory
" Usage: :Make <target>
" Usage: :Run <target flags>
" Usage: :MakeRun <target flags>
" If no arguments, tries to reuse last arguments
" After first use, use <space>mm to make, <space>mr to run, <space>mr to make+run
function Make(...)
    if a:0 >= 1
        let t:last_make = a:1
    endif
    let l:arg = t:last_make
    exe "AsyncRun urxvt -e bash -c 'cd build && make -j12 ". l:arg . " && printf \"make " . l:arg . " done, press any key to continue\"; read -n 1 -s -r -p \"\"'"
endfunction
command! -nargs=* -complete=file -bar Make call Make(<f-args>)

function Run(...)
    if a:0 >= 1
        let t:last_run = join(a:000, ' ')
    endif
    let l:arg = t:last_run
    exe "AsyncRun urxvt -e bash -c 'cd build && ./". l:arg . " && printf \"run " . l:arg . " done, press any key to continue\"; read -n 1 -s -r -p \"\"'"
endfunction
command! -nargs=* -complete=file -bar Run call Run(<f-args>)

function MakeRun(...)
    if a:0 >= 1
        let t:last_make = a:1
        let t:last_run = join(a:000, ' ')
    endif
    let l:marg = t:last_make
    let l:rarg = t:last_run
    exe "AsyncRun urxvt -e bash -c 'cd build && make -j12 ". l:marg ." && ./". l:rarg . " && printf \"make-run " . l:marg . " done, press any key to continue\"; read -n 1 -s -r -p \"\"'"
endfunction
command! -nargs=* -complete=file -bar MakeRun call MakeRun(<f-args>)

function SetTarget(...)
    if a:0 >= 1
        let t:last_make = a:1
        let t:last_run = join(a:000, ' ')
        return 1
    else
        return 0
    endif
endfunction
command! -nargs=* -complete=file -bar SetTarget call SetTarget(<f-args>)

autocmd filetype cpp nnoremap <leader>mc :AsyncRun urxvt -e bash -c 'cd build && cmake .. -DCMAKE_BUILD_TYPE=Release; printf "cmake done, press any key to continue"; read -n 1 -s -r -p ""'<CR>
autocmd filetype cuda nnoremap <leader>mc :AsyncRun urxvt -e bash -c 'cd build && cmake .. -DCMAKE_BUILD_TYPE=Release; printf "cmake done, press any key to continue"; read -n 1 -s -r -p ""'<CR>
autocmd filetype cpp nnoremap <leader>mM :AsyncRun urxvt -e bash -c 'cd build && make -j12; printf "make done, press any key to continue"; read -n 1 -s -r -p ""'<CR>
autocmd filetype cuda nnoremap <leader>mM :AsyncRun urxvt -e bash -c 'cd build && make -j12; printf "make done, press any key to continue"; read -n 1 -s -r -p ""'<CR>
autocmd filetype cpp nnoremap <leader>mm :Make<CR>
autocmd filetype cuda nnoremap <leader>mm :Make<CR>
autocmd filetype cpp nnoremap <leader>mr :Run<CR>
autocmd filetype cuda nnoremap <leader>mr :Run<CR>
autocmd filetype cpp nnoremap <leader>mR :MakeRun<CR>
autocmd filetype cuda nnoremap <leader>mR :MakeRun<CR>
set nofoldenable

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

let g:airline_powerline_fonts = 1
let g:airline_theme='ayu_dark'
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''

" Wordcount is crashing for me sometimes, disabled
"let g:airline#extensions#wordcount#enabled = 1

" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>bn :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>bQ :bp <BAR> bd! #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" Edit
nmap <leader>e :e
" Pastetoggle
set pastetoggle=<F3>


set cmdheight=1
set noshowmode  " to get rid of thing like --INSERT--
set noshowcmd  " to get rid of display of last command
set shortmess+=F  " to get rid of the file name displayed in the command line bar

set cino=N-s
let g:netrw_browse_split = 0
autocmd FileType netrw setl bufhidden=wipe
let g:netrw_fastbrowse = 0

augroup AutoFormat
    autocmd!
    autocmd FileType bzl AutoFormatBuffer buildifier
    autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
    autocmd FileType dart AutoFormatBuffer dartfmt
    autocmd FileType go AutoFormatBuffer gofmt
    autocmd FileType gn AutoFormatBuffer gn
    autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
    autocmd FileType java AutoFormatBuffer google-java-format
    autocmd FileType python AutoFormatBuffer yapf
    " Alternative: autocmd FileType python AutoFormatBuffer autopep8
    autocmd FileType rust AutoFormatBuffer rustfmt
    autocmd FileType vue AutoFormatBuffer prettier
augroup END
autocmd CursorHold * silent call CocActionAsync('highlight')

" ** CoC **

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> <leader>g <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
nmap <F2> <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>f  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <leader>e  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <leader>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent><nowait> <leader>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>sd  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>ss  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <leader>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent><nowait> <leader>p  :<C-u>CocListResume<CR>

" Show sign column
set signcolumn=yes

" Fish
autocmd FileType fish setlocal foldmethod=expr
