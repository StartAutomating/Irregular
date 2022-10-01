$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

New-RegEx -Description "Matches an ANSI cursor control" |
    New-RegEx -CharacterClass Escape |
    New-RegEx -LiteralCharacter '[' |
    New-RegEx -Atomic -Or @(
        New-RegEx -Pattern '6n' -Name 'DeviceStatusReport' -Comment '6n will request the cursor position'
        New-RegEx -Pattern (
            New-RegEx -Name Row -Pattern '\d+' |
            New-RegEx -LiteralCharacter ';' |
            New-RegEx -Name Column -Pattern '\d+' |
            New-RegEx -Pattern 'R'
        ) -Comment "A Device Status Report will return CursorPosition in the form <row>;<column> R" -Name CursorPosition
        New-RegEx -Name CursorUp -Comment "Cursor Up is a digit followed by A" -Pattern (
            New-RegEx -Name RowCount -Pattern '\d+' |
                New-RegEx -Pattern 'A'
        )
        New-RegEx -Name CursorDown -Comment "Cursor Down is a digit followed by B" -Pattern (
            New-RegEx -Name RowCount -Pattern '\d+' |
                New-RegEx -Pattern 'B'
        )
        New-RegEx -Name CursorForward -Comment "Cursor Forward is a digit followed by C" -Pattern (
            New-RegEx -Name ColumnCount -Pattern '\d+' |
                New-RegEx -Pattern 'C'
        )
        New-RegEx -Name CursorBack -Comment "Cursor Back is a digit followed by D" -Pattern (
            New-RegEx -Name ColumnCount -Pattern '\d+' |
                New-RegEx -Pattern 'D'
        )
        New-RegEx -Name CursorNextLine -Comment "Cursor Next Line is a digit followed by E" -Pattern (
            New-RegEx -Name LineCount -Pattern '\d+' |
                New-RegEx -Pattern 'E'
        )
        New-RegEx -Name CursorNextLine -Comment "Cursor Next Line is a digit followed by F" -Pattern (
            New-RegEx -Name LineCount -Pattern '\d+' |
                New-RegEx -Pattern 'F'
        )
        New-RegEx -Name CursorAbsolute -Comment "Cursor Absolute Position is a digit followed by G" -Pattern (
            New-RegEx -Name AbsolutePosition -Pattern '\d+' |
                New-RegEx -Pattern 'G'
        )
        New-RegEx -Name CursorPosition -Comment "Cursor Positions are two optional digits, separated by semicolon, ending with H" -Pattern (
            New-RegEx -Name Row -Pattern '\d{0,}' |
            New-RegEx -LiteralCharacter ';' |
            New-RegEx -Name Column -Pattern '\d{0,}' |
            New-RegEx -LiteralCharacter 'H'
        )
        New-RegEx -Name ScrollUp -Comment "Scroll Up is a digit followed by S" -Pattern (
            New-RegEx -Name PageCount -Pattern '\d+' |
                New-RegEx -Pattern 'S'
        )
        New-RegEx -Name ScrollDown -Comment "Scroll Down is a digit followed by T" -Pattern (
            New-RegEx -Name PageCount -Pattern '\d+' |
                New-RegEx -Pattern 'T'
        )
        New-RegEx -Name CursorHide -Comment 'Cursors can be hidden with 25h' (
            New-RegEx -Pattern '25h'
        )
        New-RegEx -Name CursorShow -Comment 'Cursors can be hidden with 25l' (
            New-RegEx -Pattern '25l'
        )
    ) |    
    Set-Content -Path (Join-Path $myRoot $myName) -PassThru
