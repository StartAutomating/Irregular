$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

Write-RegEx -Description "Matches Unredacted Social Security Numbers" |
    Write-RegEx -After (
        Write-RegEx -Or -Pattern @(
            Write-RegEx -StartAnchor LineStart
            Write-RegEx -CharacterClass NonDigit
        )
    ) -Comment "Match after line start or a non-digit, so that random dashed numbers don't match." |
    Write-Regex -Name AreaNumber -CharacterClass Digit -Min 3 -Max 3 -Comment '3 Digit Area Number (if allocated after 2011 no longer reflects area)' |
    Write-Regex -LiteralCharacter - |
    Write-Regex -Name GroupNumber -CharacterClass Digit -Min 2 -Max 2 -Comment '2 Digit Group Number' |
    Write-Regex -LiteralCharacter - |
    Write-Regex -Name SerialNumber -CharacterClass Digit -Min 4 -Max 4 -Comment '4 Digit Serial Number' |
    Set-Content -Path (Join-Path $myRoot $myName)


