$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

Write-RegEx -Pattern '(?m)' |
Write-RegEx -Pattern '?<Git_DiffHeader>' |
    Write-RegEx -Until (
        Write-RegEx 'diff' -StartAnchor LineStart
    ) -Name Git_DiffRanges |
    Set-Content -Path (Join-Path $myRoot $myName)


