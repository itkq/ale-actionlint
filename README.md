# ale-actionlint

## Usage

Minimum config of dein

```vim
[[plugins]]
repo = 'itkq/ale-actionlint'

[[plugins]]
repo = 'dense-analysis/ale'
hook_add = '''

let g:ale_linters = {
\   'yaml': ['actionlint'],
\}
'''
```
