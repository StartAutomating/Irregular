try {

$savedPatternsMarkdown = @(
    '### Irregular Patterns'

    @(Get-RegEx | # Gets all saved Regular Expressions as a Markdown table
            Sort-Object Name |
            ForEach-Object -Begin {
                '|Name|Description|IsGenerator|'
                '|:---|:----------|:----------|'
            } -Process {
                $desc = $_.Description
                $desc=  if ($desc) {$desc | ?<NewLine> -Replace '<br/>'} else  { ''}
                "|$($_.Name)|$desc|$($_.IsGenerator)|"
            }) -join [Environment]::NewLine -replace '<br/>\|', '|'
)


$savedPatternsMarkdown | Set-Content .\SavedPatterns.md -Encoding UTF8
Get-Item .\SavedPatterns.md |
    Add-Member NoteProperty CommitMessage "Updating SavedPatterns.md [skip ci]" -Force -PassThru
    
 
 } catch {
    $ex = $_
    $ex | Format-Custom|  Out-Host
 }