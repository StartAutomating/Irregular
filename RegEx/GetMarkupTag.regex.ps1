<#
.Synopsis
    Gets markup tags
.Description
    Gets one or more specific markup tags.  By default, anchor tags.
#>
param(
[Parameter(ValueFromRemainingArguments=$true)]
[string[]]$Tag = @('a')
)


@"                            
\<                            #  The tag Start
(?<TagName>$($Tag -join '|')) #  The name of the Tag is any non number of non-word characters
(?<TagAttributes>             #  It's attributes are 
    .+?                       #  anything until
    (?=                       #  the close of the tag. 
        (?>                   #  The close of the tag can be either (IsClosed)/> or (IsOpen)> 
            (?<IsClosed>/>)|(?<IsOpen>>)
        )
    )
)
(?(IsOpen)(?:                  # If the tag was open
        >                      # match the end tag (so that it's not captured as TagContent)
        (?<TagContent>         # then capture the tag content            
                (?>
                    (.|\s)+?(?!<\k<TagName>)|
                    (?=\<\k<TagName>)(?<TagDepth>)|
                    (?=\<\/\k<TagName>)(?<-TagDepth>)                    
                )*(?(TagDepth)(?!))   
                                # It is anything until 
        )(?=\<\/\k<TagName>)    # the closing tag
        (?:\<\/\k<TagName>>)
    )
)
"@