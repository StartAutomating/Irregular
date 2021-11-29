$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

$octet = "(?<Octect>[0-9a-f]{2})"
New-RegEx -Description "Matches a MAC address" |
    New-RegEx -Name OUI -Pattern (    
        New-RegEx -Pattern "$octet\-" -NoCapture -Min 3 -Max 3
    ) -Comment "A MAC consists of 3 octects of Organizationally Unique Identifiers" |
    New-RegEx -Name NIC -Pattern (    
        New-RegEx -Pattern "$octet\-" -NoCapture -Min 2 -Max 2 |
            New-RegEx -Pattern $octet
    ) -Comment "Followed by 3 octects of Network Interface Controller Specific Identifiers"|
    Set-Content -Path (Join-Path $myRoot $myName)



