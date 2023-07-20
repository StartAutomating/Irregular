$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path
New-RegEx -Description @'
Matches a regular expression group name
'@ -NotAfter '\\' -LiteralCharacter '(' -Comment 'Named Groups start with a Parenthesis' | 
    New-RegEx -LiteralCharacter '?' -Comment 'Followed by a Question Mark' | 
    New-RegEx -LiteralCharacter '<' -Comment 'Followed by Less Than' |
    New-RegEx -Name 'IsBalancingGroup' -Optional -LiteralCharacter '-' -Comment "A dash can indicate a balancing group" |
    New-RegEx -CharacterClass Word -Repeat -Comment 'Most group names are simply any number of word characters' -Name Group |
    New-RegEx -LiteralCharacter '>' |
    Set-Content -Path (Join-Path $myRoot $myName) -PassThru

