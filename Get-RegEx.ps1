function Get-RegEx
{
    <#
    .Synopsis
        Gets Regular Expressions
    .Description
        Gets saved Regular Expressions.
    .Example
        Get-RegEx
    .Example
        Get-RegEx -Name NextWord
    .Example
        Get-RegEx | # Gets all saved Regular Expressions as a Markdown table 
            Sort-Object Name | 
            ForEach-Object -Begin {
                '|Name|Description|IsGenerator|'
                '|:---|:----------|:----------|'
            } -Process {
                "|$($_.Name)|$($_.Description)|$($_.IsGenerator)|"
            }
    .Link
        Use-RegEx
    .Link
        Write-RegEx
    #>
    [OutputType([PSObject])]
    param(
    # The Name of the Regular Expression.
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [string[]]$Name,

    # The path to one or more files or folders containing regular expressions.
    # Files should be named $Name.regex.txt
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [Alias('Fullname')]
    [string[]]$FilePath,

    # If provided, will get regular expressions from any number of already imported modules.
    [string[]]
    $FromModule,

    [ValidateSet('Metadata', 'File','Pattern','Hashtable', 'String','Variable','Alias', 'Script')]
    [string]
    $As = 'MetaData'
    )

    process {
        #region Determine the Path List
        $pathList = & {
                if ($FilePath) { # If any file paths were provided
                    foreach ($fp in $filePath){ # resolve them
                        $ExecutionContext.SessionState.Path.GetResolvedPSPathFromPSPath($fp)
                    }
                    return # and use just this pathlist.
                }
                if ($FromModule) { # If -FromModule was passed,
                    $loadedModules = Get-Module # get all loaded modules.
                    $loadedModuleNames =
                        foreach ($lm in $loadedModules) { # get their names
                            $lm.Name
                        }
                    $OkModules =
                        foreach ($fm in $fromModule) { # filter the ones that are OK
                            $loadedModuleNames -like $fm
                        }

                    foreach ($lm in $loadedModules) {
                        if ($OkModules -contains $lm.Name) {
                            $lm | Split-Path
                        }
                    }
                }
            }
        #endregion Determine the Path List
        if (-not $script:_RegexLibraryMetaData) { return }

        #region Get RegEx files
        @(if ($pathList) {
            $byPath =
                @(foreach ($_ in $script:_RegexLibraryMetaData.Values) {
                    if ($_.Path) {$_ }
                }) |
                Group-Object Path -AsHashTable

            $pathList = $pathList | Select-Object -Unique
            @(foreach ($p in $pathList) {
                if ([IO.Directory]::Exists($p) -or [IO.File]::Exists($p)) {
                    @(if ([IO.File]::Exists($p)) {
                        [IO.FileInfo]$p
                    } elseif ([IO.Directory]::Exists($p)) {
                        ([IO.DirectoryInfo]"$p").EnumerateFiles('*.regex.*', 'AllDirectories')
                    })
                }
            }) |
            & { process {
                if (-not $byPath.ContainsKey($_.Fullname)) { return }
                if ($Name) {
                    :nextFile foreach ($bp in $byPath[$_.FullName]) {
                        foreach ($n in $name) {
                            if ($bp.Name -like $n) {
                                $bp
                                continue nextFile
                            }
                        }
                    }
                } else {
                    $byPath[$_.FullName]
                }
            } }
        } elseif ($name) {
            :nextItem foreach ($kv in $script:_RegexLibraryMetaData.GetEnumerator()) {
                foreach ($n in $name) {
                    if ($kv.Key -like $n) {
                        $kv.Value
                        continue nextItem
                    }
                }
            }
        } else {
            $script:_RegexLibraryMetaData.Values
        }) | & {
            begin {
                if ($as -eq 'Hashtable' -or $as -eq 'Script') {
                    $outHt = [Text.StringBuilder]::new('@{').AppendLine()
                    $defineAliases = [Text.StringBuilder]::new()
                }
            }
            process {
                $regex = $_
                if ($regex.IsGenerator) {
                    $regexScript = $ExecutionContext.SessionState.InvokeCommand.GetCommand($regex.Path, 'ExternalScript')
                }
                if ($as -eq 'MetaData') {
                    $_
                }
                elseif ($as -eq 'File') {
                    [IO.FileInfo]$_.Path
                }
                elseif ($as -eq 'Alias') {
                    "Set-Alias ?<$($_.Name)> Use-RegEx"
                }
                elseif ($as -eq 'String') {
                    if ($_.Pattern -as [Regex]) {
                        $_.Pattern.ToString()
                    } elseif ($_.IsGenerator) {
                        $regexScript.ScriptContents
                    }
                }
                elseif ('Pattern', 'Variable', 'Hashtable', 'Script' -contains $as) {
                    $def = if ($_.IsGenerator) {
                        "{$($regexScript.ScriptContents)}"
                    } else {
                        "[Regex]::new(@'
$($_.Pattern)
'@, 'IgnoreCase,IgnorePatternWhitespace', '00:00:05')
"
                    }
                    if ($as -eq 'Pattern') {
                        $def
                    } elseif ($as -eq 'Variable') {
                        "`$$($regex.Name) = $def"
                    } elseif ($as -eq 'Hashtable' -or $as -eq 'Script') {
                        $null = $outHt.AppendLine("    $($regex.Name) = $def").AppendLine()
                    }
                    if ($as -eq 'Script') {
                        $null = $defineAliases.AppendLine("Set-Alias ?<$($_.Name)> UseRegEx")
                    }
                }
            }
            end {
                if ($as -eq 'Script') {
                    @(
                    "`$script:_RegexLibrary = $($outHt.AppendLine('}'))"
                    'function UseRegex {'
                    $ExecutionContext.SessionState.InvokeCommand.GetCommand('Use-RegEx','Function').ScriptBlock
                    '}'
                    $defineAliases
                    ) -join [Environment]::NewLine
                } elseif ($as -eq 'Hashtable') {
                    $outHt.AppendLine('}').ToString()
                }

            }
        }
        #endregion Get RegEx files
    }
}
