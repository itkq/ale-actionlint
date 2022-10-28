function! ale_linters#yaml#actionlint#GetExecutable(buffer) abort
    return expand('%:p') =~ '.\+\/.github\/workflows\/.\+$' ? 'actionlint' : ''
endfunction

function! ale_linters#yaml#actionlint#Handle(buffer, lines) abort
    let l:output = []

    for l:err in ale#util#FuzzyJSONDecode(a:lines, [])
        call add(l:output, {
        \   'text': l:err['message'],
        \   'type': 'E',
        \   'code': l:err['kind'],
        \   'lnum': l:err['line'],
        \   'col' : l:err['column']
        \})
    endfor

    return l:output"
endfunction

call ale#linter#Define('yaml', {
\   'name': 'actionlint',
\   'executable': function('ale_linters#yaml#actionlint#GetExecutable'),
\   'command': 'actionlint -format "{{json .}}" - < %s',
\   'callback': 'ale_linters#yaml#actionlint#Handle',
\   'output_stream': 'stdout',
\})
