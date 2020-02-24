$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path
Write-RegEx -Description @'
Matches a PowerShell Variable
'@ -NotAfter '[`]' -Comment 'Do not match if preceeded by a backtick (gotta allow for escape sequences)'|   
    Write-RegEx -Atomic -Or @(        
        Write-RegEx -LiteralCharacter '@' -Name IsSplat -Comment 'Which is an at sign' -Description "A Splatted Variable:" | 
            Write-RegEx -CharacterClass Word -Repeat -Name Variable -Comment 'Followed by a <Variable> (any number of repeated word characters)' 

        Write-RegEx -LiteralCharacter '$' -Comment 'Which starts with a dollar sign' -Description 'Or Regular Variable,' |
        Write-RegEx -Pattern @(
            Write-RegEx -CharacterClass Word -Repeat -Name Variable -Comment 'Followed by a <Variable> (any number of repeated word characters)'
            Write-RegEx -Between '{','}' -Name Variable -EscapeSequence '`' -Description 'Or a <Variable> enclosed in curly brackets' -Comment 'using backtick as an escape'
        ) -Or
    ) -Description 'A PowerShell Variable Can Be Either:' |
    Set-Content -Path (Join-Path $myRoot $myName)
    
     
