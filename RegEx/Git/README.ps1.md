### Git Regular Expressions

This directory contains regular expressions that can be used with Git.

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