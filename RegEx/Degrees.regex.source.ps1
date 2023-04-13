$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-RegEx -Description "Matching degrees" |
    New-Regex -Pattern ?<Decimals> | 
    New-RegEx -CharacterClass Whitespace -Min 0 -Comment "Optional Whitespace" |
    New-RegEx -Atomic -Or @("Degrees","Degree", "°") -Comment "Degree(s) or the degree symbol" |
    New-RegEx -CharacterClass Whitespace -Min 0 -Comment "Optional Whitespace" |
    New-RegEx -Name UnitType -Optional -Pattern $(
        New-RegEx -Atomic -Or @(
            "Celsius"
            "C"
            "Fahrenheit"
            "F"
        )
    ) -Comment "Optional unit" |
    Set-Content -Path (Join-Path $myRoot $myName)



