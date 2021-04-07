<#
.Synopsis
    
.Description
    
#>
#requires -Modules PSDevOps
New-ADOPipeline -Stage PowerShellStaticAnalysis, TestPowerShellCrossPlatform, UpdatePowerShellGallery |
    Set-Content .\azure-pipelines.yml -Encoding UTF8