#requires -Modules PSDevOps

Push-Location ($PSScriptRoot | Split-Path)

New-ADOPipeline -Stage PowerShellStaticAnalysis, TestPowerShellCrossPlatform, UpdatePowerShellGallery |
    Set-Content .\azure-pipelines.yml -Encoding UTF8

Pop-Location