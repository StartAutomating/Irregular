#requires -Module Irregular
#requires -Module PSDevOps
Import-BuildStep -ModuleName Irregular
New-GitHubAction -Name "UseIrregular" -Description 'Regular Expressions Made Strangle Simple' -Action Irregular -Icon cpu |
    Set-Content .\action.yml -Encoding UTF8 -PassThru
