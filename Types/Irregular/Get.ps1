<#
.SYNOPSIS
    Gets Irregular
.DESCRIPTION
    Gets Irregular.
    
    Get is the default noun, so you can also just call this `Irregular`.
#>
param()

$anyInput = @($input)
$anyArguments = @($args)
if (-not $anyInput -or $anyArguments) {
    return $this
}


