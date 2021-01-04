$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

Write-RegEx -Description "Matches an RGB Hex Color" |
    Write-RegEx -LiteralCharacter '#' -Comment 'Number Sign followed by' |
    Write-RegEx -Atomic -Or @(        
        Write-RegEx -Pattern '[0-9a-f]{2}' -Name Red  -Comment 'EITHER: Two Hex Digits for Red' |
            Write-RegEx -Pattern '[0-9a-f]{2}' -Name Green -Comment 'Two Hex Digits for Green' |
            Write-RegEx -Pattern '[0-9a-f]{2}' -Name Blue -Comment 'Two Hex Digits for Blue'
            
        Write-RegEx -Pattern '[0-9a-f]' -Name Red  -Comment 'OR: One Hex Digit for Red' |
            Write-RegEx -Pattern '[0-9a-f]' -Name Green -Comment 'One Hex Digit for Green' |
            Write-RegEx -Pattern '[0-9a-f]' -Name Blue -Comment 'One Hex Digit for Blue'    
    ) |
    Set-Content -Path (Join-Path $myRoot $myName)



