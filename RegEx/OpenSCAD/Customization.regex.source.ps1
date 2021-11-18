#requires -Module Irregular
$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

Write-RegEx -Description "Matches Potential Open SCAD Customizations" -StartAnchor LineStart -Modifier Multiline |        
    Write-RegEx -CharacterClass Word -Repeat -Name Name -Comment 'Optional Whitespace'   |
    Write-RegEx -CharacterClass Whitespace -Min 0 -Comment 'Optional Whitespace' |
    Write-RegEx -LiteralCharacter '=' |
    Write-RegEx -CharacterClass Whitespace -Min 0 -Comment 'Optional Whitespace' | 
    Write-RegEx -Name Value -Atomic -Or @(
        Write-RegEx -Name NumberValue -CharacterClass Digit -Repeat -LiteralCharacter . -Comment "A numeric value"
        Write-RegEx -Name BooleanValue -Pattern 'true|false' -Comment "A boolean value"
        Write-RegEx -LiteralCharacter '"'  |
            Write-RegEx -Name StringValue -Pattern '(?:.|\s)*?(?<!\\)"' -Comment "A string value"
        Write-RegEx -Name ListValue -Pattern ?<BalancedBrackets> -Comment "A List Value"
    ) |
    Write-RegEx -CharacterClass Whitespace -Min 0 -Comment 'Optional Whitespace' |
    Write-RegEx -LiteralCharacter ';' -Comment 'Semicolon' |
    Write-RegEx -Name RestOfLine -Pattern .*$ | #>
    Set-Content -Path (Join-Path $myRoot $myName) -PassThru





