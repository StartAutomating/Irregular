$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path
New-RegEx -Description @'
Matches Progress Lines in FFMpeg output
'@  -StartAnchor LineStart -Pattern "frame=" -Comment "frame=" |
    New-RegEx -CharacterClass Whitespace -Min 0 |
    New-RegEx -Name FrameNumber -CharacterClass Digit -Repeat |
    New-RegEx -CharacterClass Whitespace -Min 0 -Comment "Followed by the Frame Number" |
    New-RegEx -Pattern fps= -Comment "fps="|
    New-RegEx -CharacterClass Whitespace -Min 0 |
    New-RegEx -Name FramesPerSecond (
        New-RegEx -CharacterClass Digit -LiteralCharacter '.' -Repeat
    ) |
    New-RegEx -CharacterClass Whitespace -Repeat -Comment "Followed by Frames Per Second"  |
    New-RegEx -Pattern q= -Comment "q=" |    
    New-RegEx -Name QuanitizerScale -Pattern "[\d\.N/A+]+" |
    New-RegEx -CharacterClass Whitespace -Repeat -Comment "Followed by the Quanitizer Scale"   |    
    New-RegEx -Pattern L?size= -Comment "size=" |
    New-RegEx -CharacterClass Whitespace -Repeat |
    New-RegEx -Name Size -Pattern "\d{1,}\wB" |
    New-RegEx -CharacterClass Whitespace -Repeat -Comment "Followed by the Size"  |
    New-RegEx -Pattern time= -Comment "time=" |   
    New-RegEx -Name Time -Pattern "[\d\:\.]+" |
    New-RegEx -CharacterClass Whitespace -Min 0 -Comment "Followed by the Time" |
    New-RegEx -Pattern bitrate= -Comment "bitrate=" |
    New-RegEx -CharacterClass Whitespace -Min 0 |
    New-RegEx -Name Bitrate -Pattern "[\d\.exN/A]+" |
    New-RegEx -Pattern 'kbits/s' |
    New-RegEx -Atomic -Min 0 -Pattern (
        New-RegEx -CharacterClass Whitespace -Min 0 -Comment "Followed by optional duplicated frame count" |
            New-RegEx -Pattern dup= -Comment "dup=" |
            New-RegEx -CharacterClass Whitespace -Min 0 |
            New-RegEx -Name Duplicated -Pattern "\d+"
    ) |
    New-RegEx -Atomic -Min 0 -Pattern (
        New-RegEx -CharacterClass Whitespace -Min 0 -Comment "Followed by optional dropped frame count" |
            New-RegEx -Pattern drop= -Comment "drop=" |
            New-RegEx -CharacterClass Whitespace -Min 0 |
            New-RegEx -Name Dropped -Pattern "\d+"
    ) |
    New-RegEx -CharacterClass Whitespace -Min 0 -Comment "Followed by the Bitrate" |
    New-RegEx -Pattern speed= -Comment "speed=" |
    New-RegEx -CharacterClass Whitespace -Min 0 |
    New-RegEx -Name Speed -Pattern "[\d\.N/A+]+" |
    New-RegEx -Pattern 'x' |     
    New-RegEx -CharacterClass Whitespace -Min 0 -Comment "Followed by the Speed" |#>
    Set-Content -Path (Join-Path $myRoot $myName) -Encoding UTF8 -PassThru