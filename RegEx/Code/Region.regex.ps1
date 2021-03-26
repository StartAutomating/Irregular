<#
.Synopsis
    Matches a Collapsible Region in code
.Description
    Matches a #region #endregion pair. Returns the Name of the Region and the Content.
#>
param(
# The RegionName.  If no RegionName is provided, will match all top-level regions.
[Parameter()]
[string]
$RegionName = $(
    '(?:.|\s)+?(?=\z|\s{0,}$)' # Matches anything until whitespace and the end of line.
    # This prevents trailing whitespace from failing to pair the match, but allows whitespace within the region name
),

[ValidateSet('PowerShell', 'C#', 'C++', 'C', 'JavaScript', 'JSON', 'Java', 'TypeScript', '')]
[string]
$Language = 'PowerShell'
)


if ($inputObject -and $inputObject -is [IO.FileInfo]) {

        if ('.h', '.cpp', '.c' -contains $inputObject.Extension) {
            
            $Language = 'C'
        }        
        elseif ('.cs', '.ps1', '.psm1', '.psd1' -contains $inputObject.Extension) {
            
            $Language = 
                if ($inputObject.Extension -eq '.cs') { 'C#' } else { 'PowerShell' } 
        } 
        elseif ('.js', '.json', '.ts' -contains $inputObject.Extension) {
            
            $Language = 'Javascript'
        }
        elseif ('.java' -contains $inputObject.Extension) {
            
            $Language = 'Java'
        }
}

if ($inputObject -and $inputObject -is [Management.Automation.CommandInfo] -or $inputObject -is [ScriptBlock]) {
    $Language = 'PowerShell'
}

if (-not $PSBoundParameters.Language -and -not $Language) {
    return
}

$regionStart, $regionEnd = 
    switch ($Language) {
        C {
            '\#\s{1,}pragma\s{1,}region\s{1,}', '\#\s{1,}pragma\s{1,}endregion\s{1,}'
        }
        { $_ -match 'C#|PowerShell'} {
            '\#region\s{1,}', '\#endregion\s{1,}'
        }
        JavaScript {
            '//\#region\s{1,}', '//\#endregion\s{1,}'
        }
        Java {
            '//region\s{1,}', '//endregion\s{1,}'
        }
    }





if ($PSBoundParameters['RegionName']) {
    $RegionName = $RegionName -replace '\s', '\s'
}
   
@"
(?m)
^\s{0,}        # Line start and whitespace
$regionStart   # The region start 
(?<Name>$RegionName)
(?<Content>
(?:.|\s)+?(?=
    (?>
        \z|
        ^\s{0,}$regionEnd$(if ($language -ne 'Java') { '\k<Name>' })
    )
)
)
^\s{0,}$regionEnd$(if ($language -ne 'Java') { '\k<Name>' })
"@
