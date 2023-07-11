$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path
New-Regex -Description @'
Matches PowerShell #requires 
'@ -StartAnchor LineStart -Modifier Multiline -Pattern "\#requires" -Comment " Match the Requires, followed by one of the following" |
    New-Regex -CharacterClass Whitespace -Repeat |
    New-Regex -Atomic -Or @(
        New-Regex -Pattern '\-Module(?:s)?' |
            New-Regex -CharacterClass Whitespace -Repeat |
            New-Regex -Name Module -Pattern '.+?$'
        
        New-Regex -Pattern '-Assembly' -Description "An -Assembly" |
            New-Regex -CharacterClass Whitespace -Repeat |
            New-Regex -Name Assembly -Pattern '.+?$'
    
        New-Regex -Description "A -Version" -Pattern '-Version' |
            New-Regex -CharacterClass Whitespace -Repeat |
            New-Regex -Name Version -Pattern '.+?$'


        New-Regex -Description "The -PSEdition" -Pattern '-PSEdition' |
            New-Regex -CharacterClass Whitespace -Repeat |
            New-Regex -Name PSEdition -Pattern '.+?$'
    
        New-Regex -Description "-RunAsAdministrator" -Pattern '-RunAsAdministrator' -Name RunAsAdministrator

        New-RegEx -Description "Other Requirement" -Pattern (
            New-RegEx -CharacterClass Any -Repeat -EndAnchor LineEnd -Name Requirement
        )
    ) |
    New-Regex -Description "This does not match PSSnapin requirements, because no one has used PSSnapins for a decade." |#>
    Set-Content -Path (Join-Path $myRoot $myName) -Encoding UTF8 -PassThru

    