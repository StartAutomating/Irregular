$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-RegEx -Description "Matches an ANSI 3 or 4-bit color" |
    New-RegEx -CharacterClass Escape -Comment 'An Escape' |
    New-RegEx -LiteralCharacter '[' -Comment 'Followed by a bracket' |
    New-RegEx -Pattern (
        
        New-RegEx -Atomic -Or @(

            New-RegEx -Pattern 1 -Optional -Name IsBright |
                New-RegEx -LiteralCharacter ';' -Min 0 -Max 1 -Comment "A 1 and a semicolon indicate a bright color" |    
                New-RegEx -Pattern '3' -Name IsForegroundColor -Comment "A number that starts with 3 indicates foreground color"
                        
            New-RegEx -Name IsBright (
                New-RegEx -Pattern '9' -Name IsForegroundColor
            ) -Comment "OR it could be a less common bright foreground color, which starts with 9"
            
            New-RegEx -Pattern 1 -Optional -Name IsBright |
                New-RegEx -LiteralCharacter ';' -Min 0 -Max 1 -Comment "A 1 and a semicolon indicate a bright color"|
                New-RegEx -Pattern '4' -Name IsBackgroundColor -Comment "A number that starts with 3 indicates foreground color"

            New-RegEx -Name IsBright (
                New-RegEx -Pattern '10' -Name IsBackgroundColor
            ) -Comment "OR it could be a less common bright foreground color, which starts with 9"
        ) |        
        New-RegEx -Pattern '[0-7]' -Name ColorNumber -Comment "The color number will be between 0 and 7" |
        New-RegEx -NoCapture -Optional @(
            New-RegEx -LiteralCharacter ';' -Min 0 -Max 1 |
                New-RegEx -Pattern 1 -Optional -Name IsBright
        ) -Comment "Brightness can also come after a color" |
        New-RegEx -LiteralCharacter 'm'
    ) -Name Color |
    Set-Content -Path (Join-Path $myRoot $myName) -PassThru
