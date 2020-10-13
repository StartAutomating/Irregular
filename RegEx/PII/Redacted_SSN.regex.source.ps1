$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

Write-RegEx -Description "Matches Unredacted Social Security Numbers" |
    Write-RegEx -After (
        Write-RegEx -Or -Pattern @(
            Write-RegEx -StartAnchor LineStart
            Write-RegEx -CharacterClass NonDigit
        )
    ) -Comment "Match after line start or a non-digit, so that random dashed numbers don't match." |
    Write-Regex -LiteralCharacter * -Min 3 -Max 3 -Comment '3 stars' |
    Write-Regex -LiteralCharacter - |
    Write-Regex -LiteralCharacter * -Min 2 -Max 2 -Comment '2 stars' |
    Write-Regex -LiteralCharacter - |
    Write-Regex -Name SerialNumber -CharacterClass Digit -Min 4 -Max 4 -Comment '4 Digit Serial Number' |
    Set-Content -Path (Join-Path $myRoot $myName)


