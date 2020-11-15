"set t_Co=256
" nnoremap <silent> <Leader>v :NERDTreeFind<CR>
set nocompatible
nmap <C-x> <esc>:NERDTreeToggle<CR>
nmap <F7> :TagbarToggle<CR>
set cursorcolumn
set cursorline
filetype plugin on
syntax enable 
"===============================================
"Mundo tree undo visualizer
"===============================================
nnoremap <F5> :MundoToggle<CR>
let g:mundo_width = 60
let g:mundo_preview_height = 40
let g:mundo_right = 1
" ===============================================
" vim-airline theme
" ================================================
"let g:airline_theme='simple'
"let g:airline_theme='molokai'
"let g:airline_theme='badwolf'
"let g:airline_theme='behelit'
let g:airline_theme='zenburn'

" ===============================================
" vertical identation
" ===============================================
"map <C-i> <esc>:IndentLinesToggle<cr>
"let g:indentLine_setColors = 9
let g:indentLine_char = '┊'

" vim-airline
set statusline=2

" ===============================================
" NerdCommenter
" ================================================
let g:NERDToggleCheckAllLines = 1
let g:NERDCompactSexyComs = 1
let g:NERDSpaceDelims = 1

" ===============================================
" deoplete
" ===============================================
let g:deoplete#enable_at_startup = 1
"================================================
" command to compiling and debugg rust code
"================================================
map <C-A> <esc>:w <cr> :! clear && cargo run %<cr>
let g:indentLine_setColors = 1
"let g:indentLine_char = '|'
"================================================
" command to compiling and debugg C and C++ code
"================================================
map <C-h> <esc>:w <cr> :! clear && gcc % && ./a.out && x86_64-w64-mingw32-gcc %<cr>
" ===============================================
setlocal sm
set shiftwidth=4
set softtabstop=4
set viminfo=%,'50,\"100,:100,n
set undolevels=1000  " undoing 1000 changes should be enough :-)
set updatecount=100  " write swap file to disk after each 20 characters
set updatetime=6000  " write swap file to disk after 6 inactive seconds
set noerrorbells " don't make noise
set incsearch " habilita busca incremental
set ts=4 " Paradas de tabulação com 4 espaços

"==================================================
"make a shortcut to hide the comment in a program using F10 key
" =================================================
fu! Comm0n0ff()
	if !exists('g:hiddcomm')
		"016
		let g:hiddcomm=1 | hi Comment ctermfg=234 guifg=#000000
	else
		"046
		unlet g:hiddcomm | hi Comment ctermfg=201 guifg=#00ff00 term=bold
	endif
endfu
map <F10> <esc>:call Comm0n0ff()<cr>
"==================================================
"make a shortcut to comment a line in a program
"==================================================
function! Comment()
  "let ext = tolower(expand('%:e'))
  let ext = &filetype
  if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py'
    silent s/^/\#/
  elseif ext == 'js'
    silent s:^:\/\/:g
  elseif ext == 'vim'
    silent s:^:\":g
  elseif ext == 'c' || ext == 'cs' || ext == 'cpp' || ext == 'rs'
    silent s:^:\/\/:g
  endif
endfunction
map <F11> <esc>:call Comment()<cr>
"==================================================
"make a shortcut to uncomment a line in a program
"==================================================
function! Uncomment()
  "let ext = tolower(expand('%:e'))
  let ext = &filetype
  if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py'
    "s/^\#//
    silent s/\#//
  elseif ext == 'js'
    "s:^\/\/::
    silent s:^\/\/::
  elseif ext == 'vim'
    silent s:^\"::g
  elseif ext == 'c' || ext == 'cs' || ext == 'cpp' || ext == 'rs'
    "s:^\/\/::g
    silent s:\/\/::
endif
endfunction
map <F12> <esc>:call Uncomment()<cr>
" =================================================
" dont difference the lower/upper case when save and quit 
" =================================================
cab W <esc>:w
cab Wq <esc>:wq
cab wQ <esc>:wq
cab WQ <esc>:wq
cab Q  <esc>:q
" =================================================
" General Config 
" =================================================
"
"==================================================
" turn on/off the numeration of lines 
" =================================================
"map <F9> <esc>:set nu!<cr>
nnoremap <F8> :NumbersToggle<CR>
nnoremap <F9> :NumbersOnOff<CR>
let s:numbers_version = '0.5.0'

if exists("g:loaded_numbers") && g:loaded_numbers
    finish
endif
let g:loaded_numbers = 1

if (!exists('g:enable_numbers'))
    let g:enable_numbers = 1
endif

if (!exists('g:numbers_exclude'))
    let g:numbers_exclude = ['unite', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m', 'nerdtree', 'Mundo', 'MundoDiff']
endif

if v:version < 703 || &cp
    echomsg "numbers.vim: you need at least Vim 7.3 and 'nocp' set"
    echomsg "Failed loading numbers.vim"
    finish
endif


"Allow use of line continuation
let s:save_cpo = &cpo
set cpo&vim

let s:mode=0
let s:center=1

function! NumbersRelativeOff()
    if has('nvim')
        set norelativenumber
        set number
    elseif v:version > 703 || (v:version == 703 && has('patch1115'))
        set norelativenumber
    else
        set number
   endif
endfunction

function! SetNumbers()
    let s:mode = 1
    call ResetNumbers()
endfunc

function! SetRelative()
    let s:mode = 0
    call ResetNumbers()
endfunc

function! NumbersToggle()
    if (s:mode == 1)
        let s:mode = 0
        set relativenumber
    else
        let s:mode = 1
        call NumbersRelativeOff()
    endif
endfunc

function! ResetNumbers()
    if(s:center == 0)
        call NumbersRelativeOff()
    elseif(s:mode == 0)
        set relativenumber
    else
        call NumbersRelativeOff()
    end
    if index(g:numbers_exclude, &ft) >= 0
        setlocal norelativenumber

        setlocal nonumber
    endif
endfunc

function! Center()
    let s:center = 1
    call ResetNumbers()
endfunc

function! Uncenter()
    let s:center = 0
    call ResetNumbers()
endfunc


function! NumbersEnable()
    let g:enable_numbers = 1
    set relativenumber
    set number
    augroup enable
        au!
        autocmd InsertEnter * :call SetNumbers()
        autocmd InsertLeave * :call SetRelative()
        autocmd BufNewFile  * :call ResetNumbers()
        autocmd BufReadPost * :call ResetNumbers()
        autocmd FocusLost   * :call Uncenter()
        autocmd FocusGained * :call Center()
        autocmd WinEnter    * :call SetRelative()
        autocmd WinLeave    * :call SetNumbers()
    augroup END
endfunc

function! NumbersDisable()
    let g:enable_numbers = 0
    :set nu
    :set nu!
    augroup disable
        au!
        au! enable
    augroup END
endfunc

function! NumbersOnOff()
    if (g:enable_numbers == 1)
        call NumbersDisable()
    else
        call NumbersEnable()
    endif
endfunc

" Commands
command! -nargs=0 NumbersToggle call NumbersToggle()
command! -nargs=0 NumbersEnable call NumbersEnable()
command! -nargs=0 NumbersDisable call NumbersDisable()
command! -nargs=0 NumbersOnOff call NumbersOnOff()

" reset &cpo back to users setting
let &cpo = s:save_cpo

if (g:enable_numbers)
    call NumbersEnable()
endif

"==================================================
"autocomplete of keys
"==================================================
"inoremap {     {}<Left>
"inoremap {<CR> {<CR>}<Esc>0
"inoremap {{    {
"inoremap {}    {}
"inoremap (     ()<Left>
"inoremap (<CR> (<CR>)<Esc>
"inoremap ((    (
"inoremap ()    ()
"inoremap [     []<Left>
"inoremap [<CR> [<CR>]<Esc>0
"inoremap [[    [
"inoremap []    []
"
imap { {}<left>
imap [ []<left>
imap ( ()<left>
"==================================================
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
"=================================================
" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" =================================================
set hidden

"==================================================
"turn on syntax highlighting
"==================================================
syntax on

" =============================================== abreviations
" ========================================
iab 'c ç
iab 'C Ç
iab 'a á
iab 'A Á
iab "a à
iab "A À
iab 'i í
iab 'Í Í
iab ~a ã
iab ~A Ã
ab tambem também
ab tbm também
iab teh the
iab latex \LaTeX\
iab mA <adalberto.luiz.santos.junior@gmail.com>
ab aljr Adalberto Luiz Dos Santos Junior
ab vc você
iab teh the
iab a. ª
iab analize análise
iab angulo ângulo
iab apos após
iab apra para
iab aqeule aquele
iab aqiulo aquilo
iab arcoíris arco-íris
iab aré até
iab asim assim
iab aspeto aspecto
iab assenção ascenção
iab assin assim
iab assougue açougue
iab aue que
iab augum algum
iab augun algum
iab ben bem
iab beringela berinjela
iab bon bom
iab cafe café
iab caichote caixote
iab capitões capitães
iab cidadães cidadãos
iab ckaro claro
iab cliche clichê
iab compreenssão compreensão
iab comprensão compreensão
iab comun comum
iab con com
iab contezto contexto
iab corrijir corrigir
iab coxixar cochichar
iab cpm com
iab cppara para
iab dai daí
iab danca dança
iab decer descer
iab definitamente definitivamente
iab deshonestidade desonestidade
iab deshonesto desonesto
iab detale detalhe
iab deven devem
iab díficil difícil
iab distingeu distingue
iab dsa das
iab dze dez
iab ecessão exceção
iab ecessões exceções
iab eentão e então
iab emb bem
iab ems sem
iab emu meu
iab en em
iab enbora embora
iab equ que
iab ero erro
iab erv ver
iab ese esse
iab esselência excelência
iab esu seu
iab excessão exceção
iab Excesões exceções
iab excurção excursão
iab Exenplo exemplo
iab exeplo exemplo
iab exijência exigência
iab exijir exigir
iab expontâneo espontâneo
iab ezemplo exemplo
iab ezercício exercício
iab faciu fácil
iab fas faz
iab fente gente
iab ferias férias
iab geito jeito
iab gibóia jibóia
iab gipe jipe
iab ha há
iab hezitação hesitação
iab hezitar hesitar
iab http:\\ http:
iab iigor igor
iab interesado interessado
iab interese interesse
iab Irria Iria
iab isot isto
iab ítens itens
iab ja já
iab jente gente
iab linux GNU/Linux
iab masi mais
iab maz mas
iab con com
iab mema mesma
iab mes mês
iab muinto muito
iab nao não
iab nehum nenhum
iab nenina menina
iab noã não
iab no. nº
iab N. Nº
iab o. º
iab obiter obter
iab observacao observação
iab ons nos
iab orijem origem
iab ospital hospital
iab poden podem
iab portugu6es português
iab potuguês português
iab precisan precisam
iab própio próprio
iab quado quando
iab quiz quis
iab recizão rescisão
iab sanque sangue
iab sao são
iab sen sem
iab sensivel sensível
iab sequéncia seqüência
iab significatimente significativam
iab sinceranete sinceramente
iab sovre sobre
iab susseder suceder
iab tanbem também
iab testo texto
iab téxtil têxtil
iab tydo tudo
iab una uma
iab unico único
iab utilise utilize
iab vega veja
iab vja veja
iab voc6e você
iab wue que
iab xave chave

iab 1a. 1ª
iab 2a. 2ª
iab 3a. 3ª
iab 4a. 4ª
iab 5a. 5ª
iab 6a. 6ª
iab 7a. 7ª
iab 8a. 8ª
iab 9a. 9ª
iab 10a. 10ª
iab 11a. 11ª
iab 12a. 12ª
iab 13a. 13ª
iab 14a. 14ª
iab 15a. 15ª
iab 1o. 1º
iab 2o. 2º
iab 3o. 3º
iab 4o. 4º
iab 5o. 5º
iab 6o. 6º
iab 7o. 7º
iab 8o. 8º
iab 9o. 9º
"
" =================================================
" Turn Off Swap Files 
" =================================================

set noswapfile
set nobackup
set nowb

" identention set
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
"
" theme set up
" Minimalist - A Material Color Scheme Darker
"
" Author:       Diki Ananta <diki1aap@gmail.com>
" Repository:   https://github.com/dikiaap/minimalist
" Version:      1.6
" License:      MIT
"
"    HEX   |256-color| 256-Color |      Type
"          |         |  -> HEX   |
" --------------------------------------------------
"  #ffffff |     015 | #ffffff   | On Background
"  #e1e1e1 |     254 | #e4e4e4   | High-emphasis
"  #b2b2b2 |     249 | #b2b2b2   | Hi-Mid-emphasis
"  #8a8a8a |     245 | #8a8a8a   | Mid-emphasis
"  #6c6c6c |     242 | #6c6c6c   | Disabled
"  #4e4e4e |     239 | #4e4e4e   | Overlay
"  #383838 |     237 | #3a3a3a   | Overlay
"  #313131 |     236 | #303030   | Overlay
"  #2a2a2a |     235 | #262626   | Overlay
"  #1a1a1a |     234 | #1c1c1c   | Surface
"  #0c0c0c |     232 | #080808   | Background
"  #000000 |     000 | #000000   | Background
"  #bb86fc |     141 | #af87ff   | Primary
"  #b26eff |     135 | #af5fff   | Primary Valiant
"  #00d7ff |     045 | #00d7ff   | Secondary
"  #cf6679 |     168 | #d75f87   | Error
"  #ff4081 |     204 | #ff5f87   | (Special & Diff Delete)
"  #7CB342 |     107 | #87af5f   | (Diff Add)
"  #ffdf00 |     220 | #FDD835   | (Diff Change)
"
" Vim Color File
" Name: embark.vim
" Based On: Challenger Deep, Ayu Mirage, and Manta

" == PRELUDE ==
"
" Setup and configuration
hi clear

if exists('syntax on')
  syntax reset
endif

let g:colors_name='embark'
set background=dark

if !exists("g:embark_terminal_italics")
  let g:embark_terminal_italics = 0
endif

if !exists("g:embark_terminalcolors")
  let g:embark_termcolors = 256
endif

" == COLOR PALETTE == 
"
" TODO: Cterm values here are OG from Challenger Deep
" 263
let s:space = { "gui": "#29006B", "cterm": "263", "cterm16": "NONE"}
let s:deep_space= { "gui": "#100E23", "cterm": "241", "cterm16": "0"}
let s:eclipse = { "gui": "#ffffff", "cterm": "15", "cterm16": "0"}

let s:stardust = { "gui": "#cbe3e7", "cterm": "253", "cterm16": "7"}
let s:cosmos = { "gui": "#a6b3cc", "cterm": "252", "cterm16": "15"}

let s:red = { "gui": "#F48FB1", "cterm": "204", "cterm16": "1"}
let s:dark_red = { "gui": "#F02E6E", "cterm": "203", "cterm16": "9"}

let s:green = { "gui": "#A1EFD3", "cterm": "120", "cterm16": "2"}
let s:dark_green = { "gui": "#62d196", "cterm": "119", "cterm16": "10"}

let s:yellow = { "gui": "#ffe6b3", "cterm": "228", "cterm16": "3"}
let s:dark_yellow = { "gui": "#F2B482", "cterm": "215", "cterm16": "11"}

let s:blue = { "gui": "#91ddff", "cterm": "159", "cterm16": "4"}
let s:dark_blue = { "gui": "#65b2ff", "cterm": "75", "cterm16": "12"}

let s:purple = { "gui": "#d4bfff", "cterm": "039", "cterm16": "5"}
let s:dark_purple = { "gui": "#a37acc", "cterm": "033", "cterm16": "13"}

let s:cyan = { "gui": "#87DFEB", "cterm": "122", "cterm16": "6"}
let s:dark_cyan = { "gui": "#63f2f1", "cterm": "121", "cterm16": "14"}

let s:black           = { "gui": "#000000", "cterm": "0", "cterm16" : "8" }
"cterm: 016
let s:medium_gray     = { "gui": "#000000", "cterm": "234", "cterm16" : "0" }
let s:white           = { "gui": "#F3F3F3", "cterm": "15", "cterm16" : "15" }
let s:actual_white    = { "gui": "#FFFFFF", "cterm": "231", "cterm16" : "231" }
let s:light_black     = { "gui": "#000000", "cterm": "0", "cterm16" : "0" }
let s:lighter_black   = { "gui": "#000000", "cterm": "0", "cterm16" : "240" }

" lighter shadows and darker grays
let s:subtle_black  = { "gui": "#000000", "cterm": "0", "cterm16" : "0" }
let s:light_gray    = { "gui": "#B2B2B2", "cterm": "249", "cterm16" : "249" }
let s:lighter_gray  = { "gui": "#C6C6C6", "cterm": "251", "cterm16" : "251" }

let s:bg              = s:space
let s:bg_subtle       = s:deep_space
let s:bg_dark         = s:black
let s:norm            = s:stardust
let s:norm_subtle     = s:cosmos
let s:visual          = s:lighter_gray

let s:head_a         = s:dark_blue
let s:head_b         = s:blue
let s:head_c         = s:dark_cyan

" == UTILS AND HELPERS == 
"
" shamelessly stolen from hemisu: https://github.com/noahfrederick/vim-hemisu/
function! s:h(group, style)
  " Not all terminals support italics properly. If yours does, opt-in.
  if g:embark_terminal_italics == 0 && has_key(a:style, "cterm") && a:style["cterm"] == "italic"
    unlet a:style.cterm
  endif
  if g:embark_termcolors == 16
    let l:ctermfg = (has_key(a:style, "fg") ? a:style.fg.cterm16 : "NONE")
    let l:ctermbg = (has_key(a:style, "bg") ? a:style.bg.cterm16 : "NONE")
  else
    let l:ctermfg = (has_key(a:style, "fg") ? a:style.fg.cterm : "NONE")
    let l:ctermbg = (has_key(a:style, "bg") ? a:style.bg.cterm : "NONE")
  end
  execute "highlight" a:group
    \ "guifg="   (has_key(a:style, "fg")    ? a:style.fg.gui   : "NONE")
    \ "guibg="   (has_key(a:style, "bg")    ? a:style.bg.gui   : "NONE")
    \ "guisp="   (has_key(a:style, "sp")    ? a:style.sp.gui   : "NONE")
    \ "gui="     (has_key(a:style, "gui")   ? a:style.gui      : "NONE")
    \ "ctermfg=" . l:ctermfg
    \ "ctermbg=" . l:ctermbg
    \ "cterm="   (has_key(a:style, "cterm") ? a:style.cterm    : "NONE")
endfunction

" == COMMON GROUPS ==
"
" (see `:h w18`)
call s:h("Normal",        {"bg": s:bg, "fg": s:norm})
call s:h("Cursor",        {"bg": s:blue, "fg": s:bg_dark})
call s:h("Comment",       {"fg": s:medium_gray, "gui": "italic", "cterm": "italic"})

call s:h("Constant",      {"fg": s:yellow})
hi! link String           Constant
hi! link Character        Constant

call s:h("Number",       {"fg": s:dark_yellow})
hi! link Boolean          Constant
hi! link Float            Constant

call s:h("Identifier",    {"fg": s:purple})
hi! link Function         Keyword

call s:h("Label",        {"fg": s:dark_blue})
hi! link Conditonal       Statement
hi! link Exception        Statement

call s:h("Operator",     {"fg": s:dark_cyan})
hi! link Repeat           Operator

call s:h("PreProc",       {"fg": s:green})
hi! link Include          PreProc
hi! link Define           PreProc
hi! link Macro            PreProc
hi! link PreCondit        PreProc

call s:h("Keyword",       {"fg": s:red})
hi! link Statement        Keyword

call s:h("Type",          {"fg": s:blue})
hi! link StorageClass     Type
hi! link Structure        Type
hi! link Typedef          Type

call s:h("Special",       {"fg": s:cyan})
hi! link SpecialChar      Special
hi! link Tag              Special
hi! link Delimiter        Special
hi! link SpecialComment   Special
hi! link Debug            Special

call s:h("Underlined",    {"fg": s:norm, "gui": "underline", "cterm": "underline"})
call s:h("Ignore",        {"fg": s:bg})
call s:h("Error",         {"fg": s:dark_red, "bg": s:bg_subtle , "gui": "bold", "cterm": "bold"})
call s:h("Todo",          {"fg": s:dark_yellow, "bg": s:bg, "gui": "bold", "cterm": "bold"})

" == UI CHROME ==
"
" ordered according to `:help hitest.vim`
call s:h("SpecialKey",    {"fg": s:blue})
call s:h("Boolean",    {"fg": s:dark_yellow})
call s:h("Number",    {"fg": s:dark_yellow})
call s:h("Float",    {"fg": s:dark_yellow})
call s:h("NonText",       {"fg": s:bg_dark})
call s:h("Directory",     {"fg": s:purple})
call s:h("ErrorMsg",      {"fg": s:dark_red})
call s:h("IncSearch",     {"bg": s:yellow, "fg": s:space})
call s:h("Search",        {"bg": s:dark_yellow, "fg": s:space})
call s:h("MoreMsg",       {"fg": s:medium_gray, "gui": "bold", "cterm": "bold"})
hi! link ModeMsg MoreMsg

call s:h("LineNr",        {"fg": s:eclipse, "bg": s:bg_subtle})
"hi LineNr guibg=#C6C6C6 ctermbg=68
hi LineNr guibg=#C6C6C6 ctermbg=22

call s:h("CursorLineNr",  {"bg": s:bg_subtle, "fg": s:blue, "gui": "bold"})
call s:h("Question",      {"fg": s:red})
call s:h("StatusLine",    {"bg": s:bg_dark})
call s:h("Conceal",       {"fg": s:norm})
call s:h("StatusLineNC",  {"bg": s:bg_dark, "fg": s:medium_gray})
call s:h("VertSplit",     {"fg": s:bg_subtle})
call s:h("Title",         {"fg": s:dark_blue})
call s:h("Visual",        {"bg": s:visual})
call s:h("WarningMsg",    {"fg": s:yellow})
call s:h("WildMenu",      {"fg": s:bg_subtle, "bg": s:cyan})
call s:h("Folded",        {"fg": s:dark_purple})
call s:h("FoldColumn",    {"fg": s:yellow})
call s:h("DiffAdd",       {"fg": s:space, "bg": s:dark_green})
call s:h("DiffDelete",    {"fg": s:space, "bg": s:red})
call s:h("DiffChange",    {"fg": s:space, "bg": s:dark_yellow})
call s:h("DiffText",      {"fg": s:space, "bg": s:dark_yellow, "gui": "bold"})
call s:h("SignColumn",    {"fg": s:green})

if has("gui_running")
  call s:h("SpellBad",    {"gui": "underline", "sp": s:dark_red})
  call s:h("SpellCap",    {"gui": "underline", "sp": s:green})
  call s:h("SpellRare",   {"gui": "underline", "sp": s:red})
  call s:h("SpellLocal",  {"gui": "underline", "sp": s:dark_green})
else
  call s:h("SpellBad",    {"cterm": "underline", "fg": s:dark_red})
  call s:h("SpellCap",    {"cterm": "underline", "fg": s:green})
  call s:h("SpellRare",   {"cterm": "underline", "fg": s:red})
  call s:h("SpellLocal",  {"cterm": "underline", "fg": s:dark_green})
endif
call s:h("Pmenu",         {"fg": s:norm, "bg": s:deep_space})
call s:h("PmenuSel",      {"fg": s:purple, "bg": s:space})
call s:h("PmenuSbar",     {"fg": s:norm, "bg": s:bg_subtle})
call s:h("PmenuThumb",    {"fg": s:norm, "bg": s:bg_subtle})
call s:h("TabLine",       {"fg": s:norm, "bg": s:bg_dark})
call s:h("TabLineSel",    {"fg": s:norm, "bg": s:bg_subtle, "gui": "bold", "cterm": "bold"})
call s:h("TabLineFill",   {"fg": s:norm, "bg": s:bg_dark})
call s:h("CursorColumn",  {"bg": s:bg_subtle})
call s:h("CursorLine",    {"bg": s:bg_subtle})
call s:h("ColorColumn",   {"bg": s:bg_subtle})

" == PLUGIN SUPPORT GROUPS ==
"
" vim-sneak
hi link Sneak Search


" HTML syntax
hi! link htmlTag          Special
hi! link htmlEndTag       htmlTag

hi! link htmlTagName      KeyWord
" html5 tags show up as htmlTagN
hi! link htmlTagN         Keyword

" HTML content
call s:h("htmlH1",        {"fg": s:head_a, "gui": "bold,italic", "cterm": "bold"     })
call s:h("htmlH2",        {"fg": s:head_a, "gui": "bold"       , "cterm": "bold"     })
call s:h("htmlH3",        {"fg": s:head_b, "gui": "italic"     , "cterm": "italic"   })
call s:h("htmlH4",        {"fg": s:head_b, "gui": "italic"     , "cterm": "italic"   })
call s:h("htmlH5",        {"fg": s:head_c                                            })
call s:h("htmlH6",        {"fg": s:head_c                                            })
call s:h("htmlLink",      {"fg": s:blue  , "gui": "underline"  , "cterm": "underline"})
call s:h("htmlItalic",    {                "gui": "italic"     , "cterm": "italic"   })
call s:h("htmlBold",      {                "gui": "bold"       , "cterm": "bold"     })
call s:h("htmlBoldItalic",{                "gui": "bold,italic", "cterm": "bold"     })
" hi htmlString     guifg=#87875f guibg=NONE gui=NONE        ctermfg=101 ctermbg=NONE cterm=NONE

" tpope/vim-markdown
call s:h("markdownBlockquote",          {"fg": s:norm})
call s:h("markdownBold",                {"fg": s:norm  , "gui": "bold"       , "cterm": "bold"  })
call s:h("markdownBoldItalic",          {"fg": s:norm  , "gui": "bold,italic", "cterm": "bold"  })
call s:h("markdownEscape",              {"fg": s:norm})
call s:h("markdownH1",                  {"fg": s:head_a, "gui": "bold,italic", "cterm": "bold"  })
call s:h("markdownH2",                  {"fg": s:head_a, "gui": "bold"       , "cterm": "bold"  })
call s:h("markdownH3",                  {"fg": s:head_a, "gui": "italic"     , "cterm": "italic"})
call s:h("markdownH4",                  {"fg": s:head_a, "gui": "italic"     , "cterm": "italic"})
call s:h("mckarkdownH5",                  {"fg": s:head_a})
call s:h("markdownH6",                  {"fg": s:head_a})
call s:h("markdownHeadingDelimiter",    {"fg": s:norm})
call s:h("markdownHeadingRule",         {"fg": s:norm})
call s:h("markdownId",                  {"fg": s:medium_gray})
call s:h("markdownIdDeclaration",       {"fg": s:norm_subtle})
call s:h("markdownItalic",              {"fg": s:norm  , "gui": "italic"     , "cterm": "italic"})
call s:h("markdownLinkDelimiter",       {"fg": s:medium_gray})
call s:h("markdownLinkText",            {"fg": s:norm})
call s:h("markdownLinkTextDelimiter",   {"fg": s:medium_gray})
call s:h("markdownListMarker",          {"fg": s:norm})
call s:h("markdownOrderedListMarker",   {"fg": s:norm})
call s:h("markdownRule",                {"fg": s:norm})
call s:h("markdownUrl",                 {"fg": s:medium_gray, "gui": "underline", "cterm": "underline"})
call s:h("markdownUrlDelimiter",        {"fg": s:medium_gray})
call s:h("markdownUrlTitle",            {"fg": s:norm})
call s:h("markdownUrlTitleDelimiter",   {"fg": s:medium_gray})
call s:h("markdownCode",                {"fg": s:norm})
call s:h("markdownCodeDelimiter",       {"fg": s:norm})

" plasticboy/vim-markdown
call s:h("mkdBlockQuote",               {"fg": s:norm})
call s:h("mkdDelimiter",                {"fg": s:medium_gray})
call s:h("mkdID",                       {"fg": s:medium_gray})
call s:h("mkdLineContinue",             {"fg": s:norm})
call s:h("mkdLink",                     {"fg": s:norm})
call s:h("mkdLinkDef",                  {"fg": s:medium_gray})
call s:h("mkdListItem",                 {"fg": s:norm})
call s:h("mkdNonListItemBlock",         {"fg": s:norm})  " bug in syntax?
call s:h("mkdRule",                     {"fg": s:norm})
call s:h("mkdUrl",                      {"fg": s:medium_gray, "gui": "underline", "cterm": "underline"})
call s:h("mkdCode",                     {"fg": s:norm})
call s:h("mkdIndentCode",               {"fg": s:norm})

" gabrielelana/vim-markdown
call s:h("markdownBlockquoteDelimiter", {"fg": s:norm})
call s:h("markdownInlineDelimiter",     {"fg": s:norm})
call s:h("markdownItemDelimiter",       {"fg": s:norm})
call s:h("markdownLinkReference",       {"fg": s:medium_gray})
call s:h("markdownLinkText",            {"fg": s:norm})
call s:h("markdownLinkTextContainer",   {"fg": s:medium_gray})
call s:h("markdownLinkUrl",             {"fg": s:medium_gray, "gui": "underline", "cterm": "underline"})
call s:h("markdownLinkUrlContainer",    {"fg": s:medium_gray})
call s:h("markdownFencedCodeBlock",     {"fg": s:norm})
call s:h("markdownInlineCode",          {"fg": s:norm})

" mattly/vim-markdown-enhancements
call s:h("mmdFootnoteDelimiter",        {"fg": s:medium_gray})
call s:h("mmdFootnoteMarker",           {"fg": s:norm})
call s:h("mmdTableAlign",               {"fg": s:norm})
call s:h("mmdTableDelimiter",           {"fg": s:norm})
call s:h("mmdTableHeadDelimiter",       {"fg": s:norm})
call s:h("mmdTableHeader",              {"fg": s:norm})
call s:h("mmdTableCaptionDelimiter",    {"fg": s:norm})
call s:h("mmdTableCaption",             {"fg": s:norm})

" XML content
hi! link xmlTag                     htmlTag
hi! link xmlEndTag                  xmlTag
hi! link xmlTagName                 htmlTagName

call s:h("MatchParen",    {"bg": s:bg_subtle, "fg": s:purple, "gui": "bold", "cterm": "bold"})
call s:h("qfLineNr",      {"fg": s:medium_gray})

" Signify, git-gutter
hi link SignifySignAdd              LineNr
hi link SignifySignDelete           LineNr
hi link SignifySignChange           LineNr
call s:h("GitGutterAdd",{"fg": s:green, "bg": s:bg})
call s:h("GitGutterDelete",{"fg": s:red, "bg": s:bg})
call s:h("GitGutterChange",{"fg": s:yellow, "bg": s:bg})
call s:h("GitGutterChangeDelete",{"fg": s:red, "bg": s:bg})

" Ale
call s:h("ALEErrorSign", {"fg": s:red, "bg": s:bg})
call s:h("ALEWarningSign", {"fg": s:dark_yellow, "bg": s:bg})
call s:h("ALEVirtualTextWarning", {"fg": s:dark_yellow})
" CTRLP
call s:h("CtrlpMatch", {"fg": s:yellow})
call s:h("NERDTreeDir", {"fg": s:blue})
call s:h("NERDTreeFlags", {"fg": s:green})

" nvim LSP
call s:h ("LspDiagnosticsError", {"fg": s:red, "bg": s:bg_subtle})
call s:h ("LspDiagnosticsWarning", {"fg": s:yellow, "bg": s:bg_subtle})
call s:h ("LspDiagnosticsInformation", {"fg": s:blue, "bg": s:bg_subtle})
call s:h ("LspDiagnosticsHint", {"fg": s:purple, "bg": s:bg_subtle})
call s:h ("LspDiagnosticsErrorSign", {"bg": s:bg})
call s:h ("LspDiagnosticsWarningSign", {"bg": s:bg})
call s:h ("LspDiagnosticsInformationSign", {"bg": s:bg})
call s:h ("LspDiagnosticsHintSign", {"bg": s:bg})

" nvim terminal colors
let g:terminal_color_0 = s:bg_dark.gui
let g:terminal_color_1 = s:red.gui
let g:terminal_color_2 = s:green.gui
let g:terminal_color_3 = s:yellow.gui
let g:terminal_color_4 = s:blue.gui
let g:terminal_color_5 = s:purple.gui
let g:terminal_color_6 = s:cyan.gui
let g:terminal_color_7 = s:space.gui
let g:terminal_color_8 = s:subtle_black.gui
let g:terminal_color_9 = s:dark_red.gui
let g:terminal_color_10 = s:dark_green.gui
let g:terminal_color_11 = s:dark_yellow.gui
let g:terminal_color_12 = s:dark_blue.gui
let g:terminal_color_13 = s:dark_purple.gui
let g:terminal_color_14 = s:dark_cyan.gui
let g:terminal_color_15 = s:cosmos.gui
