<#
.Synopsis
    Matches Access Tokens
.Description
    Matches Access Tokens.

    Access Tokens are single-line base64 strings that have more than -MinimumLength characters (default 40)
#>
param(
# The Minimum Length of an Access Token.  By default, 40 characters
[int]
$MinimumLength = 40,


# The Maximum Length of an Access Token.  By default, 1kb characters
[int]
$MaximumLength = 1kb,

# If set, will look for a hexadecimal access token.
# By default, will match Base64 access tokens
[switch]
$Hex,

# If set, will allow the token to be a JSON Web Token.
# These are similar to Base64 tokens, but may contain periods (and will tend to be longer)
[Alias('JSONWebToken')]
[switch]
$JWT
)

if ($Hex) {
    "(?<AccessToken>[0-9a-f]{$MinimumLength,$MaximumLength})"
}
elseif ($JWT) {
    "(?<AccessToken>[0-9a-z/=\+\.]{$MinimumLength,$MaximumLength})"
}
else {
    "(?<AccessToken>[0-9a-z/=\+]{$MinimumLength,$MaximumLength})"
}