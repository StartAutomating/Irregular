<#
.Synopsis
    Gets markup tags
.Description
    Gets one or more start markup tags.  By default, gets start anchor tags.
#>
param(
[Parameter(ValueFromRemainingArguments=$true)]
[string[]]$Tag = @('a')
)

Write-Regex -Pattern @"
?<HTML_StartTag>($tag)|
?<HTML_EndTag>($tag)
"@
