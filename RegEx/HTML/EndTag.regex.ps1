<#
.Synopsis
    Gets end tags
.Description
    Gets one or more end markup tags.  By default, gets end anchor tags.
#>
param(
[Parameter(ValueFromRemainingArguments=$true)]
[string[]]$Tag = @('a')
)

@"
\</                           #  The tag Start
(?<TagName>$($Tag -join '|')) #  The Tag 
\s{0,}                        #  optional whitespace
\>                            #  The end tag
"@