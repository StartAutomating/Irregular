$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path
Write-RegEx -Description @'
Matches a quantifier
'@ -NotAfter '\\' -Comment 'A Quantifier Can Be' | 
    Write-RegEx -Atomic -Or @(
        Write-RegEx -Name RangeQuantifier -Description 'A <RangeQuantifier>' (
            Write-RegEx -LiteralCharacter '{'  |
                Write-Regex -Atomic -Or @(
                    Write-RegEx -CharacterClass Digit -Before '}' -Comment 'With Fixed <Count> OR' -Name Count
                    Write-RegEx -Name Min -CharacterClass Digit -Repeat -Comment 'A <Min>' |
                        Write-RegEx -LiteralCharacter ',' |
                            Write-RegEx -CharacterClass Digit -Repeat -Name Max -Optional -Comment 'With an optional <Max> OR'
                    Write-RegEx -LiteralCharacter ',' |
                        Write-RegEx -CharacterClass Digit -Repeat -Name Max -Comment 'A <Max> preceeded by a comma'
                ) |
                Write-RegEx -LiteralCharacter '}'
            )        
        Write-RegEx -LiteralCharacter '+*' -Name Greedy -Comment 'A Quantifier can can also be <Greedy> (+ or *) OR'
        Write-RegEx -LiteralCharacter '?' -Name Lazy -Comment 'A Quantifier can be <Lazy>'
    )|
    Write-RegEx -Optional -Atomic -Or @(
        Write-Regex -Name Lazy -LiteralCharacter '?' -Comment 'If a quantifier is followed by ?, it is <Lazy>'
        Write-RegEx -Name Possessive -LiteralCharacter '+' -Comment 'If a quantifier is followed by +, it is <Possesive>'
    ) |
    Set-Content -Path (Join-Path $myRoot $myName) -PassThru
