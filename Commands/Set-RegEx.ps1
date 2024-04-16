function Set-RegEx
{
    <#
    .Synopsis
        Sets a Regular Expression
    .Description
        Sets Regular Expressions to a .regex.txt file
    .Link
        Use-RegEx
    .Example
        New-RegEx -Name Digits -CharacterClass Digit -Repeat |
            Set-RegEx
    #>
    [CmdletBinding(SupportsShouldProcess=$true)]
    [OutputType([Nullable])]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingCmdletAliases", "", Justification="Irregular Uses Smart Aliases")]
    param(
    # The regular expression.
    [Parameter(Mandatory,Position=0,ValueFromPipelineByPropertyName)]
    [string]
    $Pattern,

    # The name of the regular expression.  If not provided, this can be inferred if the pattern starts with a capture
    [Parameter(Position=1,ValueFromPipelineByPropertyName)]
    [string]
    $Name,

    # The description
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Description,

    # The path to the file.  If this is not provided, it will save regular expressions to the user's Irregular module path.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Path,

    # If set, will not save the regular expression to disk.  Instead, it will alter the in-memory RegEx library.
    # To use the alias immediately, call Set-RegEx with the . operator (e.g. . Set-Regex -Pattern '\s+' -Name Whitespace -Temporary)
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $Temporary,

    # The timeout for the regular expression.
    # This will only be used if the expression is temporary.
    # By default, this is 5 seconds
    [TimeSpan]
    $TimeOut = '00:00:05',

    # If set, will output created files or commands.
    # If using -Temporary, will output the created commands.
    # Otherwise, will output the created files.   
    [switch]
    $PassThru
    )
    process {
        #region Find the Preferred Save Location
        if (-not $path -and -not $Temporary) { # If haven't been provided a path
            $modulePaths = # find the preferred path
                $env:PSModulePath -split $(if ($PSVersionTable.Platform -eq 'Unix') { ':' } else {';' })
            $preferredPath =
                foreach ($mp in $modulePaths) { # It's the first valid module path
                    if ($PSVersionTable.Platform -eq 'Unix' -and $mp -like '/usr/*') { # beneath /usr/ (on Unix)
                        $mp;break
                    }
                    if ($PSVersionTable.Platform -ne 'Unix' -and $mp -like "$env:USERPROFILE*") { # or %userprofile% (on Windows)
                        $mp;break
                    }
                }
            if (-not $preferredPath) { return }
            $path = $preferredPath.TrimEnd([IO.Path]::DirectorySeparatorChar), 'Irregular', 'RegEx' -join [IO.Path]::DirectorySeparatorChar
            if (-not [IO.Directory]::Exists($Path)) {
                $path = New-Item -ItemType Directory -Path $path -Force
                if (-not $path) {  return }
            }
        }
        #endregion Find the Preferred Save Location
        $patternLines = $Pattern -split '(?>\r\n|\n)'
        $inlineDescription = [Collections.ArrayList]::new()
        $patternLines = @(foreach ($pl in $patternLines) {
            if ($pl.Trim().StartsWith('#')) {
                $inlineDescription.AddRange(@($pl))
            } elseif ($pl) {
                $pl
            }
        })

        $StartWithCapture = ?<StartsWithCapture> # (?<StartsWithCapture>\A\(\?\<(?<FirstCaptureName>\w+))>
        $rawPattern = $patternLines -join [Environment]::NewLine
        if ($rawPattern -match $StartWithCapture -and -not $Name) {
            $Name = $Matches.FirstCaptureName
        }

        if (-not $Name) {
            Write-Error "Must provide a -Name, or start the pattern with a named capture." -ErrorId Irregular.Missing.Name -Category NotSpecified
            return
        }

        if ($rawPattern -match $StartWithCapture -and $name -eq $Matches.FirstCaptureName) {
            $removeTheName = ($rawPattern -replace $StartWithCapture, '').Trim().Trim([Environment]::NewLine).Trim()
            if ($removeTheName.EndsWith(')')) {
                $removeTheName = $removeTheName.Substring(0, $removeTheName.Length - 1)
            }
            $rawPattern = $removeTheName
        }

        $descriptionLines =
            @(foreach ($d in $Description -split '(?>\r\n|\n)') {
                if ($d -and $d.Trim() -notlike '#*') {
                    "# $d"
                } else {
                    $d
                }
            }) + $inlineDescription

        $patternFileContent =
            if ($descriptionLines) {
                $($descriptionLines -join [Environment]::Newline) +
                [Environment]::Newline +
                $rawPattern
            } else {
                $rawPattern
            }
        if ($Temporary) {
            # If we didn't have a regex library, create one.
            if (-not $script:_RegexLibrary) { $script:_RegexLibrary = @{} }
            $script:_RegexLibrary[$Name] = [Regex]::new("(?<$($Name)>
$rawPattern
)","IgnoreCase,IgnorePatternWhitespace", '00:00:05.00')
            $tempModule =
                New-Module -Name "?<$Name>" -ScriptBlock {
                    Set-Alias "?<$args>" Use-RegEx; Export-ModuleMember -Alias *
                } -ArgumentList $name |
                    Import-Module -Global -PassThru
            if (-not $script:_RegexTempModules) {
                $script:_RegexTempModules = [Collections.Queue]::new()
            }
            $script:_RegexTempModules.Enqueue($tempModule)
            if ($passThru) {
                $tempModule.ExportedCommands.Values
            }
        } else {
            $semiResolvedPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Path)
            $path =
                if ([IO.Directory]::Exists($semiResolvedPath)) {
                    "$semiResolvedPath".TrimEnd([IO.Path]::DirectorySeparatorChar), "$Name.regex.txt" -join [IO.Path]::DirectorySeparatorChar
                } elseif ($semiResolvedPath -like '*.regex.*') {
                    $semiResolvedPath
                }
            if ($Path) {
                $patternFileContent | Set-Content -Path $path -Force -Encoding UTF8
                if ($PassThru) {
                    Get-Item -Path $Path
                }
            }
        }
    }
}