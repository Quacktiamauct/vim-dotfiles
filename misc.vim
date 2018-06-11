" ========== FZF ==========
function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

let $FZF_DEFAULT_COMMAND = 'ag --hidden -l -g ""'
autocmd! VimEnter * command! -nargs=* -complete=file Ag :call
    \fzf#vim#ag_raw(<q-args>, fzf#wrap('ag-raw',
    \ {'options': "--preview 'coderay $(cut -d: -f1 <<< {}) 2> /dev/null | sed -n $(cut -d: -f2 <<< {}),\\$p | head -".&lines."'"}))

command! -bang Colors
  \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Customize fzf colors to match your color scheme
let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

" ======= Bookmarks =======
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1
let g:bookmark_no_default_key_mappings = 1


" ======= Surround =======
let b:surround_{char2nr('e')}
      \ = "\\begin{\1environment: \1}\n\t\r\n\\end{\1\1}"
let b:surround_{char2nr('c')} = "\\\1command: \1{\r}"

" ===== YCM Settings =====
let g:ycm_min_num_of_chars_for_completion = 3
function! YCMToggle()
  if(g:ycm_auto_trigger == 1)
    echo "YCM Manual Trigger"
    let g:ycm_auto_trigger=0
  else
    echo "YCM Auto Trigger"
    let g:ycm_auto_trigger=1
  endif
endfunc
let g:ycm_autoclose_preview_window_after_completion=1

" ====== Switch relative numbers =======
set showcmd
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

" ===== Toggle spellchecking ======
function! ToggleSpellCheck()
  set spell!
  if &spell
    echo "Spellcheck ON"
  else
    echo "Spellcheck OFF"
  endif
endfunction

" ===== Auto-pairs =====
let g:AutoPairsShortcutFastWrap=''
let g:AutoPairsShortcutBackInsert=''
let g:AutoPairsShortcutJump=''
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<M-b>'
set diffopt=vertical
let g:gitgutter_diff_args = '-w'

" ============ ALE ===========
let ale_python_pylint_options='--max-line-length=120 --load-plugins pylint_django'
let ale_python_flake8_options='--max-line-length=120 --load-plugins pylint_django'
let g:ale_lint_on_enter=0
let g:ale_fixers = {}
let g:ale_fixers.tex = ['remove_trailing_lines', 'trim_whitespace']
let g:ale_fixers.vim = ['remove_trailing_lines', 'trim_whitespace']
let g:ale_fixers.python = ['autopep8', 'isort', 'yapf']
let g:ale_sign_error = ''
let g:ale_sign_warning = ''

" ====== Snippets and Completion ======
set runtimepath+=~/.vim/custom_snips/
let g:UltiSnipsSnippetsDir = '~/.vim/custom_snips/UltiSnips'

let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0
let g:UltiSnipsExpandTrigger           = '<tab>'
let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<s-tab>'
let g:ycm_key_list_select_completion   = ['<C-j>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']

" ============= CtrlP ===============
let g:ctrlp_exentions = ['tag', 'buffertag', 'bookmarkdir']

