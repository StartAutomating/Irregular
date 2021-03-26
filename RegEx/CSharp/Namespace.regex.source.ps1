$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path
Write-RegEx -Description 'Matches a CSharp namespace' -Pattern '?<Namespace>(CSharp)'|    
    Set-Content -Path (Join-Path $myRoot $myName) -Encoding UTF8