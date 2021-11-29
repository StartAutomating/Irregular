$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

Write-RegEx -Description "Matches an IPv4 Address" |    
    Write-RegEx -DigitMax 255 -Comment 'Match a series of digits (up to 255),'  |
    Write-RegEx -LiteralCharacter . -Comment 'followed by a dot,' |
    Write-RegEx -DigitMax 255 -Comment 'followed by another series of digits (up to 255),' | 
    Write-RegEx -LiteralCharacter . -Comment 'followed by a dot,' |
    Write-RegEx -DigitMax 255 -Comment 'followed by another series of digits (up to 255),' | 
    Write-RegEx -LiteralCharacter . -Comment 'folowed by a dot,' |
    Write-RegEx -DigitMax 255 -Comment 'followed by a final series of digits (up to 255)' | 
    Write-RegEx -Before '\D|$' -Comment 'followed by a non-digit or end of string.' |
    Set-Content -Path (Join-Path $myRoot $myName)



