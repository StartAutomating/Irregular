<#
.Synopsis
    Matches a PowerShell Region
.Description
    Matches a PowerShell #region/#endregion pair.  Returns the Name of the Region and the Content.
#>
param(
[Parameter()]
[string]
$RegionName = $(
    '(?:.|\s)+?(?=\z|\s{0,}$)' # Matches anything until whitespace and the end of line.
    # This prevents trailing whitespace from failing to pair the match, but allows whitespace within the region name
)
)


if ($PSBoundParameters['RegionName']) {
    $RegionName = $RegionName -replace '\s', '\s'
}

@"
(?m)
^\s{0,}        # Line start and whitespace
\#region       # The literal 'region'
\s{1,} 
(?<Name>$RegionName)
(?<Content>
(?:.|\s)+?(?=
    \z|
    ^\s{0,}\#endregion\s\k<Name>
)
)
^\s{0,}\#endregion\s\k<Name>
"@
