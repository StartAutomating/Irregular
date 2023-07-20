$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-RegEx -Description "Matches an ANSI color" |
    New-RegEx -Atomic -Or @(
        New-RegEx -Pattern '?<Console_24BitColor>'
        New-RegEx -Pattern '?<Console_8BitColor>'
        New-RegEx -Pattern '?<Console_4BitColor>'
        New-RegEx -Pattern '?<Console_DefaultColor>'
    ) |    
    Set-Content -Path (Join-Path $myRoot $myName) -PassThru
