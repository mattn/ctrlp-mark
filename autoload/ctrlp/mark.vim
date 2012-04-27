if exists('g:loaded_ctrlp_mark') && g:loaded_ctrlp_mark
  finish
endif
let g:loaded_ctrlp_mark = 1

let s:mark_var = {
\  'init':   'ctrlp#mark#init()',
\  'exit':   'ctrlp#mark#exit()',
\  'accept': 'ctrlp#mark#accept',
\  'lname':  'mark',
\  'sname':  'mark',
\  'type':   'mark',
\  'sort':   0,
\}

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:mark_var)
else
  let g:ctrlp_ext_vars = [s:mark_var]
endif

function! s:parse_line(line)
  let mx = '^\s*\(\d\+\)\s\+\(\d\+\)\s\+\(\d\+\)\s\+\(.*\)$'
  let cols = map(range(1, 4), "substitute(a:line, mx, '\\'.v:val, '')")
endfunction

function! ctrlp#mark#init()
  let s = ''
  redir => s
  silent marks
  redir END
  return split(s, "\n")[1:]
endfunc

function! ctrlp#mark#accept(mode, str)
  call ctrlp#exit()
	exe "normal! g'".matchstr(a:str, '^\s*\zs.\ze\s.*')
endfunction

function! ctrlp#mark#exit()
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#mark#id()
  return s:id
endfunction

" vim:fen:fdl=0:ts=2:sw=2:sts=2
