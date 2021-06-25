" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" ========== General Config ==========

" show line number
set number

" highlight current line
set cursorline

" ignore case when searching
set ignorecase

" indent format
set sw=2
set ts=2
set sts=2
set et
set sta

" highlight search result
set hlsearch

" tell me where the cursor is located in the file
set ruler

" encoding
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936

" store lots of :cmdline history
set history=1000

" show current mode down the bottom
set showmode

" reload files changed outside vim
set autoread

" turn off swap files
set noswapfile
set nobackup
set nowb

"syntax highlight
syntax on

set guifont=Monaco:h12

" ========== Plugin ==========

" Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'
Plugin 'mattn/emmet-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'tomasr/molokai'
Plugin 'posva/vim-vue'
Plugin 'fatih/vim-go'
Plugin 'prettier/vim-prettier'
Plugin 'nathangrigg/vim-beancount'
Plugin 'tomlion/vim-solidity'

call vundle#end()

"allow plugin and indent function
filetype plugin indent on

silent! colorscheme molokai

" F10 for nerdtree
nnoremap <silent> <F10> :NERDTreeToggle<CR>

" ========== Keys ==========

" leader key
let mapleader='\'

" change tabs
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" STOP using arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" ######### golang #########"

map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1

let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" Show by default 4 spaces for a tab
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" :GoBuild and :GoTestCompile
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

" :GoRun
autocmd FileType go nmap <leader>r  <Plug>(go-run)

" :GoTest
autocmd FileType go nmap <leader>t  <Plug>(go-test)

" :GoCoverageToggle
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

" :GoDef but opens in a vertical split
autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)

" :GoDef but opens in a horizontal split
autocmd FileType go nmap <Leader>s <Plug>(go-def-split)

" ######### 自动补全括号、引号 ######### "
inoremap ( <c-r>=OpenPair('(')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap { <c-r>=OpenPair('{')<CR>
inoremap } <c-r>=ClosePair('}')<CR>
inoremap [ <c-r>=OpenPair('[')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
" just for xml document, but need not for now.
"inoremap < <c-r>=OpenPair('<')<CR>
"inoremap > <c-r>=ClosePair('>')<CR>
function! OpenPair(char)
    let PAIRs = {
                \ '{' : '}',
                \ '[' : ']',
                \ '(' : ')',
                \ '<' : '>'
                \}
    if line('$')>2000
        let line = getline('.')

        let txt = strpart(line, col('.')-1)
    else
        let lines = getline(1,line('$'))
        let line=""
        for str in lines
            let line = line . str . "\n"
        endfor

        let blines = getline(line('.')-1, line("$"))
        let txt = strpart(getline("."), col('.')-1)
        for str in blines
            let txt = txt . str . "\n"
        endfor
    endif
    let oL = len(split(line, a:char, 1))-1
    let cL = len(split(line, PAIRs[a:char], 1))-1

    let ol = len(split(txt, a:char, 1))-1
    let cl = len(split(txt, PAIRs[a:char], 1))-1

    if oL>=cL || (oL<cL && ol>=cl)
        return a:char . PAIRs[a:char] . "\<Left>"
    else
        return a:char
    endif
endfunction
function! ClosePair(char)
    if getline('.')[col('.')-1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

inoremap ' <c-r>=CompleteQuote("'")<CR>
inoremap " <c-r>=CompleteQuote('"')<CR>
function! CompleteQuote(quote)
    let ql = len(split(getline('.'), a:quote, 1))-1
    let slen = len(split(strpart(getline("."), 0, col(".")-1), a:quote, 1))-1
    let elen = len(split(strpart(getline("."), col(".")-1), a:quote, 1))-1
    let isBefreQuote = getline('.')[col('.') - 1] == a:quote

    if '"'==a:quote && "vim"==&ft && 0==match(strpart(getline('.'), 0, col('.')-1), "^[\t ]*$")
        " for vim comment.
        return a:quote
    elseif "'"==a:quote && 0==match(getline('.')[col('.')-2], "[a-zA-Z0-9]")
        " for Name's Blog.
        return a:quote
    elseif (ql%2)==1
        " a:quote length is odd.
        return a:quote
    elseif ((slen%2)==1 && (elen%2)==1 && !isBefreQuote) || ((slen%2)==0 && (elen%2)==0)
        return a:quote . a:quote . "\<Left>"
    elseif isBefreQuote
        return "\<Right>"
    else
        return a:quote . a:quote . "\<Left>"
    endif
endfunction
