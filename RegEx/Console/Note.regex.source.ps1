$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-RegEx -Description "Matches an ANSI VT520 Note" |
New-RegEx -CharacterClass Escape -Comment 'An Escape' |
New-RegEx -LiteralCharacter '[' -Comment 'Followed by a bracket' |
New-RegEx -Name Volume -Atomic -Or -Pattern @(
    New-RegEx -Name VolumeOff -Pattern 0 -Comment "0 is no volume"
    New-RegEx -Name VolumeLow -Pattern '[1-3]' -Comment "1-3 is low volume"
    New-RegEx -Name VolumeHigh -Pattern '[4-7]' -Comment "4-7 is high volume"
) |
New-RegEx -LiteralCharacter ';' -Comment 'A semicolon separated the volume from the duration' |
New-RegEx -Name Duration -Description "Duration is measured in 1/32 of a second" -Pattern '\d+' | 
New-RegEx -LiteralCharacter ';' -Comment 'A semicolon separates the duration from the note' |
New-RegEx -Name Notes -Description "One or more notes will follow" -Pattern (
    New-RegEx -NoCapture -Min 0 (
        New-RegEx -Atomic -Or @(
            New-RegEx -Pattern 25 -Name 'C7'      -Comment '25 is C in the 7th octave (MIDI 96)'
            New-RegEx -Pattern 24 -Name 'B6'      -Comment '24 is B in the 6th octave (MIDI 95)'
            New-RegEx -Pattern 23 -Name 'ASharp6' -Comment '23 is A Sharp in the 6th octave (MIDI 94)'
            New-RegEx -Pattern 22 -Name 'A6'      -Comment '22 is A in the 6th octave (MIDI 93)'
            New-RegEx -Pattern 21 -Name 'GSharp6' -Comment '21 is G Sharp in the 6th octave (MIDI 92)'
            New-RegEx -Pattern 20 -Name 'G6'      -Comment '20 is G in the 6th octave (MIDI 91)'
            New-RegEx -Pattern 19 -Name 'FSharp6' -Comment '19 is F Sharp in the 6th octave (MIDI 90)'
            New-RegEx -Pattern 18 -Name 'F6'      -Comment '18 is F in the 6th octave (MIDI 89)'
            New-RegEx -Pattern 17 -Name 'E6'      -Comment '17 is E in the 6th octave (MIDI 88)'
            New-RegEx -Pattern 16 -Name 'DSharp6' -Comment '16 is D Sharp in the 6th octave (MIDI 87)'
            New-RegEx -Pattern 15 -Name 'D6'      -Comment '15 is D in the 6th octave (MIDI 86)'
            New-RegEx -Pattern 14 -Name 'CSharp6' -Comment '14 is C Sharp in the 6th octave (MIDI 85)'
            New-RegEx -Pattern 13 -Name 'C6'      -Comment '13 is C in the 6th octave (MIDI 84)'
            New-RegEx -Pattern 12 -Name 'B5'      -Comment "12 is B in the 5th octave (MIDI 83)"
            New-RegEx -Pattern 11 -Name 'ASharp5' -Comment "11 is A Sharp in the 5th octave (MIDI 82)"
            New-RegEx -Pattern 10 -Name 'A5'      -Comment "10 is A in the 5th octave (MIDI 81)"
            New-RegEx -Pattern 9  -Name 'GSharp5' -Comment "9 is G Sharp in the 5th octave (MIDI 80)"
            New-RegEx -Pattern 8  -Name 'G5'      -Comment "8 is G in the 5th octave (MIDI 79)"
            New-RegEx -Pattern 7  -Name 'FSharp5' -Comment "7 is F Sharp in the 5th octave (MIDI 78)" 
            New-RegEx -Pattern 6  -Name 'F5'      -Comment "6 is F in the 5th octave (MIDI 77)"
            New-RegEx -Pattern 5  -Name 'E5'      -Comment "5 is E in the 5th octave (MIDI 76)"
            New-RegEx -Pattern 4  -Name 'DSharp5' -Comment "4 is D Sharp in the 5th octave (MIDI 75)"
            New-RegEx -Pattern 3  -Name 'D5'      -Comment "3 is D in the 5th octave (MIDI 74)"
            New-RegEx -Pattern 2  -Name 'CSharp5' -Comment "2 is C Sharp in the 5th octave (MIDI 73)"
            New-RegEx -Pattern 1  -Name 'C5'      -Comment "1 is C in the 5th octave (MIDI 72)"
            New-RegEx -Pattern 0  -Name 'Rest'    -Comment "0 is a rest"
        ) |
        New-RegEx -LiteralCharacter ';' -Optional    
    )
) |
New-RegEx -Pattern ',~' -Comment "A command and a tilda end the sequence" |
Set-Content -Path (Join-Path $myRoot $myName)

