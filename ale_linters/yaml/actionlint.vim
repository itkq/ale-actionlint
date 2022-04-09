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
\   'executable': {b -> expand('#' . b . ':p:h') =~? '\.github/workflows$' ? 'actionlint' : ''},
\   'command': 'actionlint -format "{{json .}}" - < %s',
\   'callback': 'ale_linters#yaml#actionlint#Handle',
\   'output_stream': 'stdout',
\})


