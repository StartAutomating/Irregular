function Remove-RegEx
{
    <#
    .Synopsis
        Removes Regular Expressions
    .Description
        Removes Regular Expressions that have been created.  
        This will remove the associated file, any module sharing the Regex's name, and any dynamic aliases.
    .Example
        Remove-RegEx -Name MyRegEx
    .Link
        Get-RegEx
    .Link
        Set-RegEx
    #>
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact='High')]
    [OutputType([Nullable])]
    param(
    # The name of one or more regular expressions
    [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
    [string[]]
    $Name
    )

    

    process {
        foreach ($n in $Name) {
            $FoundRegex = Get-RegEx -Name $n
            if ($FoundRegex -and $FoundRegex.Path) {
                if ($PSCmdlet.ShouldProcess("Remove $($FoundRegex.Path)")) {
                    Remove-Item -LiteralPath $FoundRegex.Path -ErrorAction SilentlyContinue
                }
            }
            $thereIsAModule = Get-Module "?<$n>" # If the regex had a module
            if ($thereIsAModule) { 
                $thereIsAModule | Remove-Module # remove that too.
            }

            $aliasPath      = "Alias:?<$n>"     # If the regex still has an alias
            $thereIsAnAlias = Get-Item -LiteralPath "Alias:?<$n>"
            if ($thereIsAnAlias) {
                Remove-Item -LiteralPath $aliasPath # remove that, too.
            }
        }
    }
}