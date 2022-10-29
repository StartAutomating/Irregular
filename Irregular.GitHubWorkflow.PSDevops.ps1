#requires -Module PSDevOps
Push-Location $PSScriptRoot

Import-BuildStep -ModuleName Irregular
New-GitHubWorkflow -Name "Test, Tag, Release, and Publish" -Job PowerShellStaticAnalysis, TestPowerShellOnLinux, TagReleaseAndPublish, BuildIrregular -On Push, Demand |
    Set-Content .\.github\workflows\IrregularTests.yml -Encoding UTF8 -PassThru

New-GitHubWorkflow -Name "Run GitHub Action" -On Push, Demand -Job UseIrregularAction |
    Set-Content .\.github\workflows\RunIrregularAction.yml -Encoding UTF8 -PassThru

New-GitHubWorkflow -On Issue, Demand -Job RunGitPub -Name OnIssueChanged |
    Set-Content (Join-Path $PSScriptRoot .github\workflows\OnIssue.yml) -Encoding UTF8 -PassThru
    

Pop-Location