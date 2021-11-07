$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

Write-RegEx -Description "Matches a Duration, defined in ISO 8601" |    
    Write-RegEx -LiteralCharacter 'P' -Comment "A literal P denotes the period" |
    Write-RegEx -Atomic -Pattern (
        Write-RegEx -CharacterClass Digit -Repeat -Name Year |
            Write-RegEx -LiteralCharacter 'Y' -Comment "An optional year can be denoted with \d+Y"
    ) -Optional |
    Write-RegEx -Atomic -Pattern (
        Write-RegEx -CharacterClass Digit -Repeat -Name Month |
            Write-RegEx -LiteralCharacter 'M' -Comment "An optional month can be denoted with \d+M"
    ) -Optional |
    Write-RegEx -Atomic -Pattern (
        Write-RegEx -CharacterClass Digit -Repeat -Name Week |
            Write-RegEx -LiteralCharacter 'W' -Comment "An optional week can be denoted with \d+W"
    ) -Optional |
    Write-RegEx -Atomic -Pattern (
        Write-RegEx -CharacterClass Digit -Repeat -Name Day |
            Write-RegEx -LiteralCharacter 'D' -Comment "An optional day can be denoted with \d+D"
    ) -Optional |
    Write-RegEx -LiteralCharacter 'T' -Comment "A literal T starts the time component" -Optional |
    Write-RegEx -Atomic -Pattern (
        Write-RegEx -CharacterClass Digit -Repeat -Name Hour |
            Write-RegEx -LiteralCharacter 'H' -Comment "An optional hour can be denoted with \d+H"
    ) -Optional |
    Write-RegEx -Atomic -Pattern (
        Write-RegEx -CharacterClass Digit -Repeat -Name Minute |
            Write-RegEx -LiteralCharacter 'M' -Comment "An optional minute can be denoted with \d+M"
    ) -Optional |
    Write-RegEx -Atomic -Pattern (
        Write-RegEx -CharacterClass Digit -Repeat -Name Second |
            Write-RegEx -LiteralCharacter 'S' -Comment "An optional second can be denoted with \d+S"
    ) -Optional |
    Set-Content -Path (Join-Path $myRoot $myName)





