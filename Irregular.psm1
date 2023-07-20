. $psScriptRoot\Get-RegEx.ps1
. $psScriptRoot\Compress-RegEx.ps1
. $psScriptRoot\Export-RegEx.ps1
. $psScriptRoot\Import-RegEx.ps1
. $psScriptRoot\New-RegEx.ps1
. $psScriptRoot\Remove-RegEx.ps1
. $psScriptRoot\Set-RegEx.ps1
. $psScriptRoot\Show-RegEx.ps1
. $psScriptRoot\Use-RegEx.ps1

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
