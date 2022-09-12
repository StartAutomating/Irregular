$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-RegEx -Description "Matches an ANSI 3 or 4-bit color" |
    New-RegEx -CharacterClass Escape -Comment 'An Escape' |
    New-RegEx -LiteralCharacter '[' -Comment 'Followed by a bracket' |
    New-RegEx -Pattern (
        New-RegEx -Pattern 1 -Optional -Name IsBright |
        New-RegEx -LiteralCharacter ';' -Optional |
        New-RegEx -Pattern '3[0-7]' -Name ForegroundColor -Optional |
        New-RegEx -If ForegroundColor -Then 'm' -Else (
            New-RegEx -Pattern '4[0-7]' -Name BackgroundColor | 
                New-RegEx -Pattern 'm' -Modifier IgnoreCase -Not
        ) 
    ) -Name Color |    
    Set-Content -Path (Join-Path $myRoot $myName)
