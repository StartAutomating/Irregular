$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path
Write-RegEx -Description @'
Matches C/C++ #if/#ifdef/#ifndef .. #endif
'@ -Pattern "\#\s{0,}" -Comment " As long as we're not after comments, Match the #, followed by" -Modifier Multiline -NotAfter '//' |
    Write-RegEx -Name If -Pattern 'if[^\s]+' -Comment "Match <If> (and the rest of the word)" |
    Write-RegEx -Pattern '.?$' -Name 'Condition' -Comment  "the <Condition> is anything until the end of the line" |
    Write-RegEx -Until (
        Write-RegEx -LiteralCharacter '#' | Write-RegEx -Pattern endif
    ) |
    Write-RegEx -LiteralCharacter '#' | Write-RegEx -Pattern endif |
    Set-Content -Path (Join-Path $myRoot $myName) -Encoding UTF8 -PassThru