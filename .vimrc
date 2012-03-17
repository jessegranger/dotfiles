
" Appearance Settings
color darkblue
hi Folded ctermfg=0 ctermbg=NONE
" uncomment if you want Ctrl-V and Ctrl-C as your copy/paste keys
" source $VIMRUNTIME/mswin.vim
behave mswin
set guifont=Consolas:h10:cANSI
syn on

" General Settings
set exrc
set nocompatible
set backspace=2 " allow backspace over anything in insert mode
set nobackup " dont create ~ backup files
set noswapfile " dont create .swp files
set viminfo='20,\"50 " what to save in ~/.viminfo
set history=50 " how much to save
set ruler
set nowrap " dont wrap long lines
set number " show line numbers on the left                                                                                         
set timeoutlen=500 " ms gap between mapping keys
set visualbell " errors flash instead of beep

" how to fold
set foldenable
set foldmethod=indent

" how to indent
set smartindent
set noautoindent
set nocindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
" set expandtab " uncomment to use spaces instead of tabs

" General mappings
map ,l :set number!<Enter>

" Mappings that work on whole indented blocks
map zd zcdd
map z> zc>>
map z< zc<<
map zy zcYzo

" bind some build hotkeys
map <F5> :wa<Enter>:make debug<Enter>
map <F6> :wa<Enter>:make<Enter>
map <F7> :wa<Enter>:make run<Enter>

" dont treat '#' special
inoremap # x<Backspace>#

" Move quickly between splits
imap <C-Up> <Esc><C-w><Up><C-w>_
imap <C-Down> <Esc><C-w><Down><C-w>_
map <C-Up> <Esc><C-w><Up><C-w>_
map <C-Down> <Esc><C-w><Down><C-w>_
imap Oa <Esc><C-w><Up><C-w>_
imap Ob <Esc><C-w><Down><C-w>_
map Oa <Esc><C-w><Up><C-w>_
map Ob <Esc><C-w><Down><C-w>_


" HTML mappings
au FileType html imap <script <script type="text/javascript"
au FileType html imap <style <style type="text/css"
au FileType html imap <link <link rel="stylesheet" href="
au FileType html inoremap <!-- <!-- --><Esc>hhhi

" CF Mappings
au FileType cf noremap ,c I<!--- <Esc>A ---><Esc>
au FileType cf noremap ,u ^:s/<!--- *//<Cr>/---><Cr>:s/ *--->//<Cr>

" ActionScript mappings
au BufRead,BufNewFile *.as map ,h :!cmd /c start ' http://www.google.com/search?q=site:livedocs.adobe.com/flex/2/langref\%20\%20^R^W'<CR>
au BufRead,BufNewFile *.mxml imap <mx:Script> <mx:Script><CR><![CDATA[<CR>]]><CR></mx:Script><Up><Up><Right><CR>

" Python mappings
au! FileType python runtime! autoload/pythoncomplete.vim
au FileType python noremap ,c I# <Esc>
au FileType python noremap ,u :s/$\(\s*\)#\s/\1/

" Go mappings
au BufRead,BufNewFile *.go set filetype=go
au! Syntax go source $VIM/go.vim

" Pathogen must be last
call pathogen#infect()
