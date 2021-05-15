$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path
$r =Write-RegEx -Description @'
Matches C/C++ #if/#ifdef/#ifndef .. #endif
'@ -Pattern "\#\s{0,}" -Comment " As long as we're not after comments, Match the #, followed by" -Modifier Multiline -NotAfter '//' -Before 'if' |
    Write-RegEx -Name If -Pattern 'if[^\s]+' -Comment "Match <If> (and the rest of the word)" |     
    Write-RegEx -Pattern '.+?$' -Name 'Condition' -Comment  "the <Condition> is anything until the end of the line" |    
    Write-RegEx -Atomic -Or @(
        Write-RegEx -LiteralCharacter '#' -Not -Repeat -Comment "Any non-preprocessor character matches, and doesn't change the balance"
        Write-RegEx -NotAfter '//' -Pattern '\#if.+?$' |
            Write-RegEx -Name 'Depth' -Comment "An #if Increases the <Depth>"
        Write-RegEx -NotAfter '//' -Pattern '\#endif' |
            Write-RegEx -Name '-Depth' -Comment "An EndIf Decreases the Depth"
        Write-RegEx -LiteralCharacter '#' -Comment 'Match any remaining #'
    ) -Description "Now things get tricky.  Because ifdefs can nest, we need a balancing group" |
    Write-RegEx -Greedy | 
    Write-Regex -If 'Depth' -Then '?!' -Comment "Match until EndIf is balanced" |
    Write-RegEx -NotAfter '//' -Pattern '\#endif' -Comment "Match the endIf" |
    Set-Content -Path (Join-Path $myRoot $myName) -Encoding UTF8 -PassThru 