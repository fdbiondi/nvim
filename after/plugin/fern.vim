" docs
" https://github.com/lambdalisue/fern.vim/wiki/Tips
" https://bluz71.github.io/2017/05/21/vim-plugins-i-like.html#fernvim

" Custom settings and mappings.
noremap <silent> <A-b> :Fern . -drawer -reveal=% -toggle -width=35<CR><C-w>=

let g:fern#disable_default_mappings = 1
let g:fern#drawer_width = 30
let g:fern#disable_drawer_auto_quit = 1
let g:fern#disable_viewer_hide_cursor = 1
let g:fern#renderer = "nerdfont"

function! FernInit() abort
    nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
    nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
    nmap <buffer> l <Plug>(fern-my-open-expand-collapse)
    nmap <buffer> h <Plug>(fern-action-collapse)
    nmap <buffer> s <Plug>(fern-action-open:split)
    nmap <buffer> v <Plug>(fern-action-open:vsplit)

    nmap <buffer> <A-c> <Plug>(fern-action-new-path)
    nmap <buffer> <A-r> <Plug>(fern-action-rename)
    nmap <buffer> <A-m> <Plug>(fern-action-move)
    nmap <buffer> <A-y> <Plug>(fern-action-copy)
    nmap <buffer> <A-d> <Plug>(fern-action-remove)
    nmap <buffer> <A-D> <Plug>(fern-action-trash)

    nmap <buffer> <Tab> <Plug>(fern-action-mark:toggle)j
    nmap <buffer> <S-Tab> k<Plug>(fern-action-mark:toggle)
    nmap <buffer> <nowait> <C-h> <Plug>(fern-action-hidden:toggle)
    nmap <buffer> <C-r> <Plug>(fern-action-reload)

    nmap <buffer><nowait> < <Plug>(fern-action-leave)
    nmap <buffer><nowait> > <Plug>(fern-action-enter)
endfunction

function! s:FernSettings() abort
  nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
  nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
  nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
  nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
endfunction

augroup FernSettings
  autocmd!
  autocmd FileType fern call s:FernSettings()
augroup END

augroup FernGroup
  autocmd!
  autocmd FileType fern call FernInit()
augroup END

augroup MyGlyphPalette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
augroup END
