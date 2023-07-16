describe 'Irregular Console Patterns' {
    it 'Can match any Escape sequence' {
        "$([char]0x1b)[0m" | ?<Console_Code> | Select-Object -ExpandProperty Length | Should -be 4

        "$([char]0x1b)[1;3;5,~" | ?<Console_Code> | Select-Object -ExpandProperty Length | Should -be 9
    }
    context 'Console Colors' {
        it 'Can Match a 4-bit color' {
            $x = "$([char]0x1b)[32m" | ?<Console_4BitColor> -Extract
            $x.ColorNumber | Should -Be 2
            $x.IsForegroundColor | Should -Be 3
        }        

        it 'Can Match a 24-bit color' {
            $x = "$([char]0x1b)[38;2;255;100;0m" | ?<Console_24BitColor> -Extract
            $x.Red | Should -be 255
            $x.Green | Should -be 100
            $x.Blue | Should -be 0
        }
    }

    context 'Console Styles' {
        it 'Can Match Console Styles' {
            @("$([char]0x1b)[3m Italics $([char]0x1b)[23m" | ?<Console_Style>).Count | Should -be 2
        }
    }
}