$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path
Write-RegEx -Description @'
Matches PowerShell #requires 
'@ -StartAnchor LineStart -Modifier Multiline -Pattern "\#requires" -Comment " Match the Requires, followed by one of the following" |
    Write-RegEx -CharacterClass Whitespace -Repeat |
    Write-RegEx -Atomic -Or @(
        Write-RegEx -Pattern '\-Module(?:s)?' |
            Write-RegEx -CharacterClass Whitespace -Repeat |
            Write-RegEx -Name Module -Pattern '.+?$'
        
        Write-RegEx -Pattern '-Assembly' -Description "An -Assembly" |
            Write-RegEx -CharacterClass Whitespace -Repeat |
            Write-RegEx -Name Assembly -Pattern '.+?$'
    
        Write-RegEx -Description "A -Version" -Pattern '-Version' |
            Write-RegEx -CharacterClass Whitespace -Repeat |
            Write-RegEx -Name Version -Pattern '.+?$'


        Write-RegEx -Description "The -PSEdition" -Pattern '-PSEdition' |
            Write-RegEx -CharacterClass Whitespace -Repeat |
            Write-RegEx -Name PSEdition -Pattern '.+?$'
    
        Write-RegEx -Description "-RunAsAdministrator" -Pattern '-RunAsAdministrator' -Name RunAsAdministrator        
    ) |
    Write-RegEx -Description "This does not match PSSnapin requirements, because no one has used PSSnapins for a decade." |#>
    Set-Content -Path (Join-Path $myRoot $myName) -Encoding UTF8 -PassThru

    