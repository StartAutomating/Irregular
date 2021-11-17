$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path
Write-RegEx -Pattern '[\d\:\,\.]+' -Name StartTime -After "(?:[\r\n]|^)" -Description "Matches a WebVTT Subtitle"  -Comment "VTT Subtitles start with a StartTime" |
    Write-RegEx -CharacterClass Whitespace |
    Write-RegEx -Pattern '\-\-\>' |  
    Write-RegEx -CharacterClass Whitespace -Comment "Followed by --> (surrounded by a space)" |
    Write-RegEx -Pattern '[\d\:\,\.]+' -Name EndTime -Comment "Followed by an EndTime" |
    Write-RegEx -Pattern '.+?' -Before '[\r\n]' -Name Style -Comment "Anything until the end of the line is considered a style"|
    Write-RegEx -Pattern '[\r\n]+' -Comment "Match the newline" | 
    Write-RegEx -Until (
        Write-RegEx -Pattern '[\d\:\,\.]+' -After "[\r\n]"
    ) -Name Cue -Comment "Anything until the next timespan is a Cue" |     
    Set-Content -Path (Join-Path $myRoot $myName) -Encoding UTF8 -PassThru
