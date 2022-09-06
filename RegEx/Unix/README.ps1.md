This directory contains regular expressions to help parse Unix related content.

Some of these expressions will only be useful in a Unix/Linux environment, where as others will be useful when dealing with technologies that adhere to Unix/Linux conventions.

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
