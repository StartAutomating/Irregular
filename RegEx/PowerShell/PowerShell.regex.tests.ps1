#requires -Module Irregular
describe 'PowerShell Regex' {
    it 'Can match a #requires -Module' {
        '#requires -module Irregular' |
            ?<PowerShell_Requires> -Extract |
            Select-Object -ExpandProperty Module |
            Should -Be 'Irregular'
    }

    it 'Can match an open ended requirement' {
        '#requires $psStyle' |        
            ?<PowerShell_Requires> -Extract |
            Select-Object -ExpandProperty Requirement |
            Should -Be '$psStyle'
    }
}
