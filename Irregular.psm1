$CommandsPath = Join-Path $PSScriptRoot Commands
:ToIncludeFiles foreach ($file in (Get-ChildItem -Path "$CommandsPath" -Filter "*-*.ps1" -Recurse)) {
    if ($file.Extension -ne '.ps1')      { continue }  # Skip if the extension is not .ps1
    foreach ($exclusion in '\.[^\.]+\.ps1$') {
        if (-not $exclusion) { continue }
        if ($file.Name -match $exclusion) {
            continue ToIncludeFiles  # Skip excluded files
        }
    }     
    . $file.FullName
}

$MyModule = $MyInvocation.MyCommand.ScriptBlock.Module
$ExecutionContext.SessionState.PSVariable.Set($myModule.Name, $MyModule)
$MyModule.pstypenames.insert(0, $myModule.Name)

$newDriveCommonParameters =
    @{PSProvider='FileSystem';Scope='Global';ErrorAction='Ignore'}
New-PSDrive -Name $myModule.name @newDriveCommonParameters -Root ($myModule | Split-Path)

if ($home) {
    $MyMyModule= "My$($myModule.name)"
    New-PSDrive -Name $MyMyModule @newDriveCommonParameters -Root (Join-Path $home $MyMyModule)
}

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

Export-ModuleMember -Function *-* -Alias * -Variable $MyModule.Name

