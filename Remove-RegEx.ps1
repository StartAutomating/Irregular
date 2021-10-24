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

    begin {
        #region RemoveRegex filter
        filter RemoveRegex {
            $regex = $_
            # If we changed our minds, return
            if (-not $PSCmdlet.ShouldProcess("Remove $($regex.Name)")) { return }
            
            if ($regex.Path) { # If the regex had a path
                Remove-Item -Path $regex.Path # remove it.
            }
            $thereIsAModule = Get-Module "?<$($regex.Name)>" # If the regex had a module
            if ($thereIsAModule) { 
                $thereIsAModule | Remove-Module # remove that too.
            }
            $aliasPath      = "Alias:?<$($regex.Name)>"     # If the regex still has an alias
            $thereIsAnAlias = Get-Item -LiteralPath "Alias:?<$($regex.Name)>" 
            if ($thereIsAnAlias) {
                Remove-Item -LiteralPath $aliasPath # remove that, too.
            }
        }
        #endregion RemoveRegex filter
    }

    process {        
        $foundRegexes = Get-RegEx -Name $Name # Try to find RegExes by that name
        if (-not $foundRegexes) { # If none were found
            Write-Error "No Regular Expressions Named $Name found" # error 
            return # out.
        }

        $foundRegexes | RemoveRegex # If any were found, pipe them to the RemoveRegex filter.
    }
}