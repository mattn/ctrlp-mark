if exists('g:loaded_ctrlp_mark') && g:loaded_ctrlp_mark
  finish
endif
let g:loaded_ctrlp_mark = 1

let s:mark_var = {
\  'init':   'ctrlp#mark#init()',
\  'enter':  'ctrlp#mark#enter()',
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

function! s:get_marks()
  let s = ''
  redir => s
  silent marks
  redir END

  let l:marks = []
  if exists("g:ctrlp_mark_match_string")
    let l:marks = filter(split(s, "\n"), g:ctrlp_mark_match_string)[1:]
  else
    let l:marks = split(s, "\n")[1:]
  endif
  return l:marks
endfunction

function! ctrlp#mark#command()
  call ctrlp#init(ctrlp#mark#id())
endfunction

function! ctrlp#mark#enter() abort
  let s:ctrlp_mark_marks = s:get_marks()
endfunction

function! ctrlp#mark#init()
  return s:ctrlp_mark_marks
endfunction

function! ctrlp#mark#accept(mode, str)
  call ctrlp#exit()
	exe "normal! g'".matchstr(a:str, '^\s*\zs\S\+\ze\s.*')
endfunction

function! ctrlp#mark#exit()
  unlet s:ctrlp_mark_marks
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#mark#id()
  return s:id
endfunction

" vim:fen:fdl=0:ts=2:sw=2:sts=2
