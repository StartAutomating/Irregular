This directory contains regular expressions designed to help work with FFMpeg and related tools.

~~~PipeScript{
    Import-Module ../../Irregular.psd1 -Global
    $directoryName = $pwd | Split-Path -Leaf     
    [PSCustomObject]@{
        Table = Get-Regex -Name "${directoryName}_*" |
            Sort-Object Name |
            Select @{
                Name='Name'
                Expression={"[?<$($_.Name)>]($($_.Path | Split-Path -Leaf))"}
            }, Description, IsGenerator
    }}
~~~