<#
.Synopsis
    Matches double-quoted strings.
.Description
    Matches a double quoted string, with an optional escape sequence (defaulting to backtick or backslash).
#>
param(
# The escape character
[string]
$Escape
)


if ($inputObject) {
    if ($inputObject -is [IO.FileInfo]) {
        $escape = 
            if ('.h', '.cpp', '.c', '.cs', '.js', '.java','.json', '.htm', '.html', '.xml', '.pswt' -contains $inputObject.Extension) {
                '\'
            } elseif ('.ps1', '.psm1', '.psd1' -contains $inputObject.Extension) {
                '`'
            }

        if (-not $Escape) { return }
    }
    if ($inputObject -is [Management.Automation.CommandInfo] -or
        $inputObject -is [ScriptBlock]) {
        $Escape = '`'    
    }
    if (-not $Escape) { return } 
}


if ($Escape) {    
    $escape = $escape -replace '[\p{P}\p{S}]', '\$0'
    "(?<!\@)`"(?:.|\s)*?(?<!$escape)`""
} else {
    '(?<!\@)"(?:.|\s)*?(?<!(`|\\))"'
}