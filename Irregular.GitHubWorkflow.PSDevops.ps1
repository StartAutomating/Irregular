#requires -Module PSDevOps
New-GitHubWorkflow -Name IrregularTests -Job TestPowerShellOnLinux -On Push, Demand |
    Set-Content .\.github\workflows\IrregularTests.yml -Encoding UTF8