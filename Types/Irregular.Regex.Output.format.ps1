    Write-FormatView -TypeName Irregular.Regex.Output -Action {

$out = $_

$fg = 'Red'
$outIsMatches = $false
foreach ($op in $out.Output) {
    if ($op -is [Text.RegularExpressions.Match]) {
        $fg = 'Green'
        $outIsMatches = $true
        break
    }
    if ($op -is [string]) {
        $fg = 'Green'
        break
    }
}



Write-Host "Pattern:"

Write-Host "$($out.Pattern)" -ForegroundColor $fg

if ($outIsMatches) {
    $out.Output |
        Group-Object { $_.Result('$_') } |
        ForEach-Object {
            $grp = $_

$highlightChars = $grp.Group |
    ForEach-Object { $_.Index..($_.Index + ($_.Length - 1)) } |
    Select-Object -Unique
Write-Host "
Matches:"
$t = $grp.Name
for ($i =0; $i -lt $t.Length; $i++) {
    if ($highlightChars -contains $i) {
        Write-Host -NoNewline "$($t[$i])" -ForegroundColor Yellow
    } else {
        Write-Host -NoNewline "$($t[$i])"
    }
}
Write-Host ''
        }
} else {
Write-Host "
Input Text:
"
Write-Host $out.Input.Match
}


if ($out.Method -and 'Remove', 'Replace', 'Transform' -contains $out.Method) {
Write-Host "
Output Text:"
Write-Host $out.Output
}
    }
