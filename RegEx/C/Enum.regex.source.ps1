$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-RegEx -Description "Matches a C/C++ Enum" -Modifier IgnoreCase -Not |
    New-RegEx -Pattern 'enum' -Comment 'Starts with a literal enum' |
    New-RegEx -CharacterClass Whitespace -Min 1 -Comment 'Followed by whitespace' |
    New-RegEx -Name Identifier -Pattern (
        New-RegEx -Pattern '[_a-zA-Z]' |
        New-RegEx -Pattern '[_a-zA-Z0-9]' -Min 1
    ) -Comment 'Followed by an identifier' |
    New-RegEx -CharacterClass Whitespace, NewLine, CarriageReturn -Min 0 -Comment 'Followed by optional whitespace' |
    New-RegEx -Name Comment -Pattern '//.+[\r\n]' -Optional -Comment 'Followed by an optional comment' |
    New-RegEx -CharacterClass Whitespace, NewLine,CarriageReturn -Min 0 -Comment 'Followed by optional whitespace' |
    New-RegEx -Name Values -Pattern '?<BalancedCurlyBracket>' -Comment 'Followed by balanced curly braces' |
    Set-Content -Path (Join-Path $myRoot $myName) -Encoding UTF8 -PassThru