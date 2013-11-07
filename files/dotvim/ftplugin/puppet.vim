" Vim filetype plugin
" Language:     Puppet
" Maintainer:   Todd Zullinger <tmz@pobox.com>
" Last Change:  2009 Aug 19
" vim: set sw=4 sts=4:

if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

if !exists("no_plugin_maps") && !exists("no_puppet_maps")
    if !hasmapto("<Plug>AlignRange")
        map <buffer> <LocalLeader>= <Plug>AlignRange
    endif
endif

noremap <buffer> <unique> <script> <Plug>AlignArrows :call <SID>AlignArrows()<CR>
noremap <buffer> <unique> <script> <Plug>AlignRange :call <SID>AlignRange()<CR>

iabbrev => =><C-R>=<SID>AlignArrows('=>')<CR>
iabbrev +> +><C-R>=<SID>AlignArrows('+>')<CR>

if exists('*s:AlignArrows')
    finish
endif

let s:arrow_re = '[=+]>'
let s:selector_re = '[=+]>\s*\$.*\s*?\s*{\s*$'

function! s:AlignArrows(op)
    let cursor_pos = getpos('.')
    let lnum = line('.')
    let line = getline(lnum)
    if line !~ s:arrow_re
        return
    endif
    let pos = stridx(line, a:op)
    let start = lnum
    let end = lnum
    let pnum = lnum - 1
    while 1
        let pline = getline(pnum)
        if pline !~ s:arrow_re || pline =~ s:selector_re
            break
        endif
        let start = pnum
        let pnum -= 1
    endwhile
    let cnum = end
    while 1
        let cline = getline(cnum)
        if cline !~ s:arrow_re ||
                \ (indent(cnum) != indent(cnum+1) && getline(cnum+1) !~ '\s*}')
            break
        endif
        let end = cnum
        let cnum += 1
    endwhile
    call s:AlignSection(start, end)
    let cursor_pos[2] = stridx(getline('.'), a:op) + strlen(a:op) + 1
    call setpos('.', cursor_pos)
    return ''
endfunction

function! s:AlignRange() range
    call s:AlignSection(a:firstline, a:lastline)
endfunction

" AlignSection and AlignLine are from the vim wiki:
" http://vim.wikia.com/wiki/Regex-based_text_alignment
function! s:AlignSection(start, end)
    let extra = 1
    let sep = s:arrow_re
    let maxpos = 0
    let section = getline(a:start, a:end)
    for line in section
        let pos = match(line, ' *'.sep)
        if maxpos < pos
            let maxpos = pos
        endif
    endfor
    call map(section, 's:AlignLine(v:val, sep, maxpos, extra)')
    call setline(a:start, section)
endfunction

function! s:AlignLine(line, sep, maxpos, extra)
    let m = matchlist(a:line, '\(.\{-}\) \{-}\('.a:sep.'.*\)')
    if empty(m)
        return a:line
    endif
    let spaces = repeat(' ', a:maxpos - strlen(m[1]) + a:extra)
    return m[1] . spaces . m[2]
endfunction
" Add the following to ~/.vim/indent/puppet.vim
" Vim indent file
" Language:     Puppet
" Maintainer:   Todd Zullinger <tmz@pobox.com>
" Last Change:  2009 Aug 19
" vim: set sw=4 sts=4:

if exists("b:did_indent")
    finish
endif
let b:did_indent = 1

setlocal autoindent smartindent
setlocal indentexpr=GetPuppetIndent()
setlocal indentkeys+=0],0)

if exists("*GetPuppetIndent")
    finish
endif

" Check if a line is part of an include 'block', e.g.:
"   include foo,
"       bar,
"       baz
function! s:PartOfInclude(lnum)
    let lnum = a:lnum
    while lnum
        let lnum = lnum - 1
        let line = getline(lnum)
        if line !~ ',$'
            break
        endif
        if line =~ '^\s*include\s\+[^,]\+,$'
            return 1
        endif
    endwhile
    return 0
endfunction

function! s:OpenBrace(lnum)
    call cursor(a:lnum, 1)
    return searchpair('{\|\[\|(', '', '}\|\]\|)', 'nbW')
endfunction

function! GetPuppetIndent()
    let pnum = prevnonblank(v:lnum - 1)
    if pnum == 0
       return 0
    endif

    let line = getline(v:lnum)
    let pline = getline(pnum)
    let ind = indent(pnum)

    if pline =~ '^\s*#'
        return ind
    endif

    if pline =~ '\({\|\[\|(\|:\)$'
        let ind += &sw
    elseif pline =~ ';$' && pline !~ '[^:]\+:.*[=+]>.*'
        let ind -= &sw
    elseif pline =~ '^\s*include\s\+.*,$'
        let ind += &sw
    endif

    if pline !~ ',$' && s:PartOfInclude(pnum)
        let ind -= &sw
    endif

    " Match } }, }; ] ]: )
    if line =~ '^\s*\(}\(,\|;\)\?$\|]:\?$\|)\)'
        let ind = indent(s:OpenBrace(v:lnum))
    endif

    return ind
endfunction
