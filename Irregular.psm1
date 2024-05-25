# Include everything beneath /Commands
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

# Determine `$MyModule`,
$MyModule = $MyInvocation.MyCommand.ScriptBlock.Module
# make it a variable,
$ExecutionContext.SessionState.PSVariable.Set($myModule.Name, $MyModule)
# and decorate it with the module name.
$MyModule.pstypenames.insert(0, $myModule.Name)

# Mount the module's path as a drive.
$newDriveCommonParameters =
    @{PSProvider='FileSystem';Scope='Global';ErrorAction='Ignore'}
New-PSDrive -Name $myModule.name @newDriveCommonParameters -Root ($myModule | Split-Path)

# If $home is set,
if ($home) {
    # mount My$MyModule as a drive.
    $MyMyModule= "My$($myModule.name)"
    New-PSDrive -Name $MyMyModule @newDriveCommonParameters -Root (Join-Path $home $MyMyModule)
}

# Import any regular expressions.
Import-RegEx

# And create aliases
foreach ($k in $script:_RegexLibrary.Keys) {
    Set-Alias -Name "?<$k>" -Value Use-RegEx
}

# Create a few "core" aliases.
Set-Alias ?<> New-RegEx
Set-Alias Write-RegEx New-RegEx
Set-Alias ?<.> Use-Regex

$myTypeData = Get-TypeData -TypeName $MyModule.Name

$myMembers  = if ($myTypeData) {
    @($myTypeData.Members.GetEnumerator())
}
$KnownVerbs = Get-Verb | Select-Object -ExpandProperty Verb

$myMemberCommands  =
    [ScriptBlock]::Create(@(foreach ($myMemberInfo in $myMembers) {
        $myMemberName = $myMemberInfo.Key
        $myMember = $myMemberInfo.Value
        if ($myMember -is [Management.Automation.Runspaces.ScriptMethodData]) {            
            $myFunctionName = 
                if ($myMemberName -in $KnownVerbs) {
                    "$($myMemberName)-$($MyModule.Name)"
                } else {
                    "$($MyModule.Name).$($myMemberName)"
                }
            # Declare My Function
            "function $myFunctionName { $($myMember.Script) }"
            if ($myMemberName -in $KnownVerbs) {
                # Alias it if it's a known verb, so both verb and noun form are available.
                "Set-Alias -Name '$($myFunctionName -replace '-','.')' -Value '$myFunctionName'"
            }
        }
        elseif ($myMember -is [Management.Automation.Runspaces.AliasPropertyData] -and
            $myTypeData.Members[$myMember.ReferencedMemberName] -is [Management.Automation.Runspaces.ScriptMethodData]
        ) {
            "Set-Alias -Name '$($myMember.Name)' -Value '$($myMember.ReferencedMemberName)'"
        }
    }) -join [Environment]::NewLine)

. $myMemberCommands
# Set a script variable of this, set to the module
# (so all scripts in this scope default to the correct `$this`)
$script:this = $myModule

# If the module is removed, remove any temporary modules.
$MyModule.OnRemove = {
    if ($script:_RegexTempModules -and $script:_RegexTempModules.Count) {
        @($script:_RegexTempModules) | Remove-Module
    }
}

# Export everything we want to.
Export-ModuleMember -Function '*[-.]*' -Alias * -Variable $MyModule.Name

# Adding experimental property to replace regex patterns with regex objects.
$MyModule |
    Add-Member NoteProperty Splicers @{
        '\?\<(?<Name>\w+)\>' = {
            $out = "[Regex]::new(@'" + [Environment]::NewLine + (
            Get-RegEx -Name $input.name |
                Select-Object -ExpandProperty Pattern) + "'@, 'IgnoreCase,IgnorePatternWhitespace')"
            $out
        }
    }

