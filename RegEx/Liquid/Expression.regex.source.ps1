$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path
New-RegEx -Description @'
Matches Liquid Expressions
'@ |
    New-Regex -LiteralCharacter '{' -Min 2 -Max 2 -Comment '{{ opens a expression ' |
    New-RegEx -CharacterClass Whitespace -Min 0 -Comment "Optional opening whitespace" |
    New-Regex -Name Expression -Until (
        New-RegEx -CharacterClass Whitespace -Min 0 -Comment "Optional closing whitespace" |
            New-RegEx -LiteralCharacter '}' -Min 2 -Max 2 -Comment 'Followed by a }}'
    ) -Description "The Liquid Expression is anything until the expression close, which is" |
    New-RegEx -CharacterClass Whitespace -Min 0 -Comment "Now we match the close: First Optional whitespace" |    
    New-RegEx -LiteralCharacter '}' -Min 2 -Max 2 -Comment "Followed by }}" |
    Set-Content -Path (Join-Path $myRoot $myName) -Encoding UTF8 -PassThru

    
