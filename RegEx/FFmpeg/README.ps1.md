This directory contains regular expressions designed to help work with FFMpeg and related tools.

~~~PipeScript{
    $directoryName = $pwd | Split-Path -Leaf 
    [PSCustomObject]@{
        Table = Get-Regex -Name "${directoryName}_*" |
            Sort-Object Name |
            Select @{
                Name='Name'
                Expression={"[$($_.Name)]($($_.Path | Split-Path -Leaf))"}
            }, Description, IsGenerator
    }}
~~~
