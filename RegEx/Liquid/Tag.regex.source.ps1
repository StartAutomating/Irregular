$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path
New-RegEx -Description @'
Matches Liquid Tags
'@ |
    New-Regex -LiteralCharacter '{' |
    New-Regex -LiteralCharacter '%' -Comment '{% opens a tag' |
    New-RegEx -CharacterClass Whitespace -Min 0 -Comment "Optional opening whitespace" |
    New-Regex -Name Tag -Until (
        New-RegEx -CharacterClass Whitespace -Min 0 -Comment "Optional closing whitespace" |
            New-RegEx -LiteralCharacter '%' |
            New-RegEx -LiteralCharacter '}' -Comment 'Followed by %}'
    ) -Description "The Liquid Tag is anything until a closing tag, which is" |
    New-RegEx -CharacterClass Whitespace -Min 0 -Comment "Now match the close: First optional whitespace" |    
    New-RegEx -LiteralCharacter '%' |
    New-RegEx -LiteralCharacter '}' -Comment "Followed by %}" |
    Set-Content -Path (Join-Path $myRoot $myName) -Encoding UTF8 -PassThru

    
