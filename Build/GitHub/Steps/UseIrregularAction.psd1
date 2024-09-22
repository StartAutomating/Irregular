@{
    name = 'Run Irregular (from main)'
    if   = '${{github.ref_name == ''master''}}'
    uses = 'StartAutomating/Irregular@master'
    id = 'IrregularMain'
},
@{
    name = 'Run Irregular (on branch)'
    if   = '${{github.ref_name != ''master''}}'
    uses = './'
    id = 'IrregularBranch'
}