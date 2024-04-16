﻿$CommandsPath = Join-Path $PSScriptRoot Commands
[include('*-*.ps1')]$CommandsPath

Import-RegEx

foreach ($k in $script:_RegexLibrary.Keys) {
    Set-Alias -Name "?<$k>" -Value Use-RegEx
}

$MyInvocation.MyCommand.ScriptBlock.Module.OnRemove = {
    if ($script:_RegexTempModules -and $script:_RegexTempModules.Count) {
        @($script:_RegexTempModules) | Remove-Module
    }
}

$MyInvocation.MyCommand.ScriptBlock.Module |
    Add-Member NoteProperty Splicers @{
        '\?\<(?<Name>\w+)\>' = {
            $out = "[Regex]::new(@'" + [Environment]::NewLine + (
            Get-RegEx -Name $input.name |
                Select-Object -ExpandProperty Pattern) + "'@, 'IgnoreCase,IgnorePatternWhitespace')"
            $out
        }
    }

Set-Alias ?<> New-RegEx
Set-Alias Write-RegEx New-RegEx
Set-Alias ?<.> Use-Regex

Export-ModuleMember -Function *-* -Alias *