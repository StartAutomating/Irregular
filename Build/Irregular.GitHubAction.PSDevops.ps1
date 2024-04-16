#requires -Module Irregular
#requires -Module PSDevOps

Import-BuildStep -SourcePath (
    Join-Path $PSScriptRoot 'GitHub'
) -BuildSystem GitHubAction

Push-Location ($PSScriptRoot | Split-Path)

New-GitHubAction -Name "UseIrregular" -Description 'Regular Expressions Made Strangle Simple' -Action Irregular -Icon cpu -OutputPath .\action.yml

Pop-Location