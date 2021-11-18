$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

Write-RegEx -Description "Matches Potential Open SCAD Module Parameters" |
    Write-RegEx -After (Write-Regex -LiteralCharacter '(,') -Comment 'After a ( or a ,' |
    Write-RegEx -CharacterClass Whitespace -Min 0 -Comment 'Optional Whitespace' | 
    Write-RegEx -CharacterClass Word -Repeat -Name Name -Comment 'The Parameter Name' |
    Write-RegEx -CharacterClass Whitespace -Min 0 -Comment 'Optional Whitespace' |
    Write-Regex -Pattern '(?<HasDefaultValue>=)?' -Description @'
A literal = is used to determine if it Has a default value
'@ |
     
    Write-RegEx -If HasDefaultValue -Description 'If there is a default value' -Then (
            Write-RegEx -CharacterClass Whitespace -Min 0 -Comment 'Allow optional whitespace' |
            Write-RegEx -Name Value -Atomic -Description 'Match the value, which could be' -Or @(
                Write-RegEx -Name ListValue -Pattern ?<BalancedBrackets> -Comment "A List Value"
                Write-RegEx -Name NumberValue -CharacterClass Digit -Repeat -LiteralCharacter . -Comment 'A number'
                Write-RegEx -Name BooleanValue -Pattern 'true|false' -Comment 'A boolean literal'
                Write-RegEx -Name ConstantValue -Pattern '\w+' -Comment 'A constant value'
                Write-RegEx -LiteralCharacter '"'  -Comment 'A string'|
                    Write-RegEx -Pattern '(?<StringValue>(?:.|\s)*?(?<!\\))"'                
                Write-RegEx '?<BalancedParenthesis>' -Name Expression
            )                
        ) | 
        Write-RegEx -CharacterClass Whitespace -Min 0 |
    
    Set-Content -Path (Join-Path $myRoot $myName)





