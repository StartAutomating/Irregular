$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path
Write-RegEx -Pattern \d+ -After "(?:[\r\n]|^)" -Description "Matches a SubRip Subtitle" -Comment "SRT Files Contain an Index digit"|
    Write-RegEx -CharacterClass Whitespace, NewLine, CarriageReturn -Repeat -Comment "Followed by whitespace and a newline" |
    Write-RegEx -Pattern '[\d\:\,\.]+' -Name StartTime -Comment "Followed by a Timespan, likely using comma as the separator" |
    Write-RegEx -CharacterClass Whitespace |
    Write-RegEx -Pattern '\-\-\>' |  
    Write-RegEx -CharacterClass Whitespace -Comment "Followed by --> (with a space on each side)" |
    Write-RegEx -Pattern '[\d\:\,\.]+' -Name EndTime -Comment "Followed by another Timespan"|
    Write-RegEx -Until (
        Write-RegEx -Pattern \d+ -After "[\r\n]"
    ) -Name Cue -Comment "Any text until the next marker is the subtitle text" |   
    Set-Content -Path (Join-Path $myRoot $myName) -Encoding UTF8 -PassThru

    



