$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path
Write-RegEx -Description @'
Matches Progress Lines in FFMpeg output
'@  -StartAnchor LineStart -Pattern "frame=" -Comment "frame=" |
    Write-RegEx -CharacterClass Whitespace -Min 0 |
    Write-RegEx -Name FrameNumber -CharacterClass Digit -Repeat |
    Write-RegEx -CharacterClass Whitespace -Min 0 -Comment "Followed by the Frame Number" |
    Write-RegEx -Pattern fps= -Comment "fps="|
    Write-RegEx -CharacterClass Whitespace -Min 0 |
    Write-RegEx -Name FramesPerSecond (
        Write-RegEx -CharacterClass Digit -LiteralCharacter '.' -Repeat
    ) |
    Write-RegEx -CharacterClass Whitespace -Repeat -Comment "Followed by Frames Per Second"  |
    Write-RegEx -Pattern q= -Comment "q=" |    
    Write-RegEx -Name QuanitizerScale -CharacterClass Digit -LiteralCharacter .  -Repeat |
    Write-RegEx -CharacterClass Whitespace -Repeat -Comment "Followed by the Quanitizer Scale"   |    
    Write-RegEx -Pattern L?size= -Comment "size=" |
    Write-RegEx -CharacterClass Whitespace -Repeat |
    Write-RegEx -Name Size -Pattern "\d{1,}\wB" |
    Write-RegEx -CharacterClass Whitespace -Repeat -Comment "Followed by the Size"  |
    Write-RegEx -Pattern time= -Comment "time=" |   
    Write-RegEx -Name Time -Pattern "[\d\:\.]+" |
    Write-RegEx -CharacterClass Whitespace -Min 0 -Comment "Followed by the Time" |
    Write-RegEx -Pattern bitrate= -Comment "bitrate=" |
    Write-RegEx -CharacterClass Whitespace -Min 0 |
    Write-RegEx -Name Bitrate -Pattern "[\d\.exN/A]+" |
    Write-RegEx -Pattern 'kbits/s' |     
    Write-RegEx -CharacterClass Whitespace -Min 0 -Comment "Followed by the Bitrate" |
    Write-RegEx -Pattern speed= -Comment "speed=" |
    Write-RegEx -CharacterClass Whitespace -Min 0 |
    Write-RegEx -Name Speed -Pattern "[\d\.N/A+]+" |
    Write-RegEx -Pattern 'x' |     
    Write-RegEx -CharacterClass Whitespace -Min 0 -Comment "Followed by the Speed" |#>
    Set-Content -Path (Join-Path $myRoot $myName) -Encoding UTF8 -PassThru