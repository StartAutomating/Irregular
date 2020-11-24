$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

Write-RegEx -Description "Matches Configuraiton File Content" |
    Write-RegEx -Pattern @(
        Write-Regex -Pattern ?<Unix_Conf_Section>
        Write-Regex -Pattern ?<Unix_Conf_Line>
    ) -Or -Atomic -Repeat |
    Set-Content -Path (Join-Path $myRoot $myName)



