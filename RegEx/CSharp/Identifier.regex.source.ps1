$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path
New-RegEx -Description 'Matches a CSharp identifier' | 
    New-Regex -Comment "Must start with a letter or underscore" -LiteralCharacter _ -CharacterClass Letter |    
    New-RegEx -CharacterClass PunctuationConnector, Letter, Digit, MarkNonSpacing -Description "Followed by any number of letters, digitis, nonspacing marks, and connector punctation" -Min 0|
    Set-Content -Path (Join-Path $myRoot $myName) -Encoding UTF8 -PassThru
