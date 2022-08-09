$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-Regex -Not -Modifier IgnoreCase -Description "Matches where a CamelCaseSpace would be" |
    New-RegEx -After '[a-z]' |
    New-RegEx -Before '[A-Z]' |
    Set-Content -Path (Join-Path $myRoot $myName)
