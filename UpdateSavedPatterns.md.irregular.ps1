try {
$IrregularModuleRoot = Get-Module Irregular | Split-Path | Select-Object -First 1
$sortedRegexes = @(Get-Regex | Sort-Object Name)

$savedPatternsMarkdown = @(
        
    '### Irregular Patterns'
    @"
Irregular includes $($sortedRegexes.Count) regular expressions
"@

    @($sortedRegexes | # Gets all saved Regular Expressions as a Markdown table            
            ForEach-Object -Begin {
                '|Name|Description|IsGenerator|'
                '|:---|:----------|:----------|'
            } -Process {
                $reg  = $_
                $desc = $_.Description
                $desc = if ($desc) {$desc | ?<NewLine> -Replace '<br/>'} else  { ''}
                $link =
                    if ($reg.Path) {
                        "[$($reg.Name)]($($reg.Path.Replace($IrregularModuleRoot, '')))" -replace '\\', '/'
                    } else {
                        $reg.Name
                    }
                "|$link|$desc|$($_.IsGenerator)|"
            }) -join [Environment]::NewLine -replace '<br/>\|', '|'
)




$savedPatternsMarkdown | Set-Content .\SavedPatterns.md -Encoding UTF8
Get-Item .\SavedPatterns.md |
    Add-Member NoteProperty CommitMessage "Updating SavedPatterns.md [skip ci]" -Force -PassThru
    
 
 } catch {
    $ex = $_
    $ex | Format-Custom|  Out-Host
 }