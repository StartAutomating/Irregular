$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-RegEx -Description "Matches ANSI Hyperlink" |
    New-RegEx -CharacterClass Escape -Comment 'An Escape' |
    New-RegEx -LiteralCharacter ']' -Comment 'Followed by a right bracket' |
    New-RegEx -Pattern '8[^;]{0,};;' -Comment 'Followed by 8 (and optional non-semicolon content) and two semicolons' |
    New-RegEx -Until '\e' -Name Uri -Comment 'Followed by the uri' |
    New-RegEx -CharacterClass Escape -Comment 'Followed by an escape' |
    New-RegEx -LiteralCharacter '\' -Comment 'Followed by a slash' |
    New-RegEx -Until '\e' -Name Text -Comment 'Followed by the link text' |
    New-RegEx -CharacterClass Escape -Comment 'Followed by an escape' | 
    New-RegEx -LiteralCharacter ']' -Comment 'Followed by a right bracket' | 
    New-RegEx -Pattern '8[^;]{0,};;' -Comment 'Followed by 8 (and optional non-semicolon content) and two semicolons' | 
    New-RegEx -CharacterClass Escape -Comment 'Followed by an Escape' | 
    New-RegEx -LiteralCharacter '\' -Comment 'Finally a closing slash' |
    Set-Content -Path (Join-Path $myRoot $myName)
