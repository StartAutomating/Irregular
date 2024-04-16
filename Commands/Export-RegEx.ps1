function Export-RegEx
{
    <#
    .Synopsis
        Exports a RegEx
    .Description
        Exports one or more Regular Expressions
    .Link
        Import-RegEx
    .Link
        Set-RegEx
    .Example
        Export-RegEx -Name Digits, Decimals -Path $home\MyRegExs
    .Example
        Export-RegEx -Name Digits, Decimals -As Script # Creates a script that embedes the expressions and Use-RegEx
    .Notes
        When exporting as a script, Use-RegEx is renamed to UseRegex.
        This enables embedding the core of Irregular and your Regular Expressions into a module while making it easy to avoid exporting Irregular.

        To use this within a module, make sure your module explicitly exports commands, or exports with a wildcard like '*-*'.
    #>
    [CmdletBinding(SupportsShouldProcess=$true)]
    param(
    # The name of the regular expression.  If not provided, this can be inferred if the pattern starts with a capture
    [Parameter(ValueFromPipelineByPropertyName)]
    [string[]]
    $Name,

    # The export path.
    # If this is not provided, it will export regular expressions to the user's Irregular module path.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Path,

    # How the expression will be exported.
    [ValidateSet('Metadata', 'File','Pattern','Hashtable', 'String','Variable', 'Alias','Script','Lambda','Engine','Embedded')]
    [string]
    $As = 'File',

    # If provided, will rename -RegEx commands with the provided -Noun.
    # This option is only valid when -As is Engine.
    # It prevents name conflicts with Irregular. 
    [string]
    $Noun
    )

    begin {
        $exportContent = [Collections.ArrayList]::new()
    }

    process {
        if (-not $PSBoundParameters.Pattern -and -not $PSBoundParameters.Name) {
            Write-Error "Must provide a pattern or a name" -ErrorId Irregular.Missing.Pattern.And.Name
            return
        }

        #region Find the Export Path
        if (-not $path -and $as -eq 'File') { # If haven't been provided a path and we're exporting to a file
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
        #endregion Find the Export Path

        if ($path -match '/|\\.+?\.' -and $name.Count -and $as -eq 'File') {
            Write-Error "Must provide a directory if exporting more than one regular expression into files" -ErrorId Irregular.One.Too.Many.Exports
            return
        }
        if (-not $Name) {
            $Name = $Script:_RegexLibrary.Keys
        }
        $exportContent.AddRange(@(
        foreach ($n in $Name) {
            $regex = $Script:_RegexLibraryMetaData.$n
            if ($as -eq 'File') {
                $ext =
                    if ($_.IsGenerator) {
                        'ps1'
                    } else {
                        'txt'
                    }
                $dest = Join-Path $Path "$n.regex.$ext"
                if ($regex.Path -and $regex.Path -ne $dest) {
                    Copy-Item -LiteralPath $regex.Path -Destination $dest
                } elseif (-not $regex.Path -and $regex.Pattern) {
                    Set-Regex -Path $Path -Name $n -Pattern $regex.Pattern
                }
            } else {
                $regex
            }

        }))
    }

    end {
        $toExport =
            @(if ($exportContent.Count) {
                $exportNames  = $exportContent | Select-Object -ExpandProperty Name
                Get-RegEx -Name $exportNames -As $As -Noun $Noun
            }) -join [Environment]::NewLine

        if ($Path -and $toExport) {
            $toExport | Set-Content $Path -Encoding UTF8
        } elseif ($toExport) {
            $toExport
        }
    }
}