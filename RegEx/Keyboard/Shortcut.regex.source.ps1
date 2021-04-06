$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path
Write-RegEx -Description @'
Matches Keyboard Shortcuts
'@ |
    Write-RegEx -Name Modifiers -Description 'Keyboard Shortcuts are a <Modifiers> followed by a Key' -Pattern (
        Write-Regex -Atomic -Or @(        
            Write-RegEx -Name Alt -Pattern (
                'Option','Alt','LeftAltPressed','RightAltPressed','LeftAlt','RightAlt' -join '|'
            ) -Comment 'An <Alt> modifier'
            Write-Regex -Name Control -Pattern (
                "Control", "Ctrl", 'LeftCtrlPressed',"LeftCtrl", 'RightCtrlPressd', "RightCtrl" -join '|'
            ) -Comment "A <Control> Modifier"
            Write-RegEx -Name Command -Pattern (
                'EnhancedKey','Command','Cmd','LeftCmd','RightCmd','Windows','Win','Apple','OpenApple' -join '|'
            ) -Comment "A <Command> Modifier (the Windows or Apple key)"
            Write-Regex -Name Shift -Pattern (
                'ShiftPressed', 'Shift','LeftShift','RightShift' -join '|'
            ) -Comment 'A <Shift> Modifier'
        ) |
            Write-RegEx -LiteralCharacter '+'
    ) -Min 0 -Max 3 |
    Write-RegEx -Comment "0-3 modifiers are followed by a key.  The Key can be" |
    Write-RegEx -Atomic -Or @(
        Write-RegEx -CharacterClass Any -EndAnchor LineEnd -Name Key -Comment "A single-character key"
        Write-RegEx -Name VirtualKey -Comment 'A virtual key (enclosed in {}s)' -Pattern (
            Write-RegEx -LC '{' | 
                Write-RegEx -LC '}' -Not -Repeat |
                    Write-RegEx -LC '}' -Min 1 -Max 2
        )
        Write-RegEx -LiteralCharacter ',' -Not -Repeat -Name KeyName -Comment "A key name"        
    ) |
    Set-Content -Path (Join-Path $myRoot $myName) -Encoding UTF8 -PassThru

    