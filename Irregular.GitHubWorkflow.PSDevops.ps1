#requires -Module PSDevOps
New-GitHubWorkflow -Name "Test, Tag, Release, and Publish" -Job PowerShellStaticAnalysis, TestPowerShellOnLinux, TagReleaseAndPublish -On Push, Demand |
    Set-Content .\.github\workflows\IrregularTests.yml -Encoding UTF8