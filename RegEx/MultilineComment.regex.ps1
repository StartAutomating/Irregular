<#
.Synopsis
    Matches Multiline Comments
.Description

Matches Multline Comments from a variety of languages.
Currently supported: PowerShell, C#, C++, JavaScript, Ruby, HTML, and XML
When this generator is used with a piped in file, the extension will autodetect the format.
If the format could not be autodetected, the match will always fail.
#>
param(
[ValidateSet('PowerShell', 'C#', 'C++', 'C', 'JavaScript', 'JSON', 'Java', 'Ruby', 'HTML', 'XML','')]
[string]
$Language = 'C'
)

if ($inputObject -and $inputObject -is [IO.FileInfo]) {
    $Language = 
        if ('.h', '.cpp', '.c', '.cs', '.js', '.java','.json' -contains $inputObject.Extension) {
            'C'
        } elseif ('.ps1', '.psm1', '.psd1' -contains $inputObject.Extension) {
            'PowerShell'
        } elseif ('.htm', '.html', '.xml', '.pswt' -contains $inputObject.Extension -or 
            $inputObject.Extension -like '.*xml') {
            'XML'
        }
}

if ($inputObject -and $inputObject -is [Management.Automation.CommandInfo] -or $inputObject -is [ScriptBlock]) {
    $Language = 'PowerShell'
}

if (-not $PSBoundParameters.Language -and -not $Language) {
    return
}




switch ($Language) {
    PowerShell {
    @'
\<\# # The opening tag
(?<Block> 
    (.|\s)+?(?=\#>) # anything until the closing tag
)
\#\> # the closing tag
'@ 
    }
    {$_ -match '(C\#)|(C\+\+)|(C)|(JavaScript)'} {
    @'
/\* # The open comment
(?<Block>
    (.|\s)+?(?=\*/)    
)\*/
'@        
    }
    Ruby {
        @'
^=begin # begin line
(?<Block>(.|\s)+?(?=\=end)) # anything that's not =end 
=end # end line
'@
    }
    { $_ -match 'HTML|XML' } {
        @'
    <\!--
        (?<Block>(.|\s)+?(?=-->))
    -->
'@
    }
}