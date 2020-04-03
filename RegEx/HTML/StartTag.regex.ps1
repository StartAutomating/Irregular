<#
.Synopsis
    Gets Start tags
.Description
    Gets one or more start markup tags.  By default, gets start anchor tags.
#>
param(
[Parameter(ValueFromRemainingArguments=$true)]
[string[]]$Tag = @('a')
)

@"
\<                            #  The tag Start
(?<TagName>$($Tag -join '|')) #  The name of the Tag is any non number of non-word characters
(?<TagAttributes>             #  It's attributes are 
    \s{1,}                    #  initial whitespace
    .+?                       #  then anything until
    (?=                       #  the close of the tag. 
        (?>                   #  The close of the tag can be either (IsClosed)/> or (IsOpen)> 
            \z|(?<IsClosed>/>)|(?<IsOpen>\>)
        )
    )
)?
(?>/>|\>)
"@