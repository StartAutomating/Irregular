This directory contains regular expressions, generators, and RegEx source files for JSON.

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