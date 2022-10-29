$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path
New-RegEx -Description 'Matches a CSharp class' | 
    New-RegEx -Name AccessModifier @(
        New-Regex -Modifier IgnoreCase -Not
        New-RegEx -Atomic -Or @(
            New-RegEx -Pattern "protected\s{1,}internal"
            New-RegEx -Pattern "protected"
            New-RegEx -Pattern "private\s{1,}protected"
            New-RegEx -Pattern "internal"
            New-RegEx -Pattern "private"
            New-RegEx -Pattern "public"            
        ) -Optional
    ) -Comment "An Optional Access Modifier" |
    New-RegEx -CharacterClass Whitespace -Min 1 |
    New-RegEx -NoCapture @(
        New-RegEx -Modifier IgnoreCase -Not | 
        New-RegEx -Pattern class | 
        New-RegEx -CharacterClass Whitespace -Min 1
    ) -Comment "Followed by 'class'" |
    New-RegEx -Name ClassName @(   
        New-Regex -LiteralCharacter _ -CharacterClass Letter |    
            New-RegEx -CharacterClass PunctuationConnector, Letter, Digit, MarkNonSpacing -Min 0
    ) -Comment "Followed by an identifier"|
    New-RegEx -Optional -Pattern @(
        New-RegEx -CharacterClass Whitespace -Min 1 |
        New-RegEx -LiteralCharacter ':' -Name IsInheriting |
        New-RegEx -CharacterClass Whitespace -Min 1
    ) -NoCapture -Comment "Followed by an optional colon" |
    New-RegEx -If IsInheriting -Then @(
        New-RegEx -NoCapture @(
            New-RegEx -CharacterClass Whitespace -Min 0
            New-RegEx -Name Inherits @(
                New-Regex -LiteralCharacter _ -CharacterClass Letter |    
                    New-RegEx -CharacterClass PunctuationConnector, Letter, Digit, MarkNonSpacing -Min 0
            ) |
            New-RegEx -CharacterClass Whitespace -Min 0 |
            New-RegEx -LiteralCharacter ',' -Min 0
        ) -Min 1        
    ) -Else '' -Description "If a colon was present, followed by a number of identifiers" |
    New-RegEx -CharacterClass Whitespace -Min 0 -Comment "Followed by whitespace and balanced curly brackets" |
    New-RegEx -Pattern ?<BalancedCurlyBracket> -Name ClassBody |
    Set-Content -Path (Join-Path $myRoot $myName) -Encoding UTF8 -PassThru
