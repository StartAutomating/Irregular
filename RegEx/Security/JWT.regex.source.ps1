$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path
Write-RegEx -Description @'
Matches a JSON Web Token (JWT)
'@ | 
    Write-RegEx -Pattern '[0-9a-z=/\+]+' -Name Header -Comment "A base 64 string containing the header" |
    Write-RegEx -LiteralCharacter '.' -Comment "Followed by a period" |
    Write-RegEx -Pattern '[0-9a-z=/\+]+' -Name Payload -Comment "A base 64 string containing the payload" |
    Write-RegEx -LiteralCharacter '.' -Comment "Followed by a period" |
    Write-RegEx -Pattern '[0-9a-z=/\+]+' -Name Signature -Comment "A base 64 string containing the signature" |
    Set-Content -Path (Join-Path $myRoot $myName) -PassThru
