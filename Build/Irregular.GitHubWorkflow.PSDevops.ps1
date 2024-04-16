#requires -Module PSDevOps
Push-Location ($PSScriptRoot | Split-Path)

Import-BuildStep -SourcePath (
    Join-Path $PSScriptRoot 'GitHub'
) -BuildSystem GitHubWorkflow


New-GitHubWorkflow -Name "Test, Tag, Release, and Publish" -Job PowerShellStaticAnalysis,
    TestPowerShellOnLinux,
    TagReleaseAndPublish,
    BuildIrregular -On Push, Demand -Environment ([Ordered]@{
        REGISTRY = 'ghcr.io'
        IMAGE_NAME = '${{ github.repository }}'
    }) -OutputPath .\.github\workflows\IrregularTests.yml

New-GitHubWorkflow -Name "Run GitHub Action" -On Push,
    Demand -Job UseIrregularAction -OutputPath .\.github\workflows\RunIrregularAction.yml

New-GitHubWorkflow -On Demand -Job RunGitPub -Name "GitPub" -OutputPath .\.github\workflows\RunGitPub.yml
    

Pop-Location