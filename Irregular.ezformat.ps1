[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingWriteHost", "", Justification="This generates format files (where its ok to Write-Host)")]
param()
$myFile = $MyInvocation.MyCommand.ScriptBlock.File
$myModuleName = $($myFile | Split-Path -Leaf) -replace '\.ezformat\.ps1', ''
$myRoot = $myFile | Split-Path

$typesFile = @(
    Write-TypeView -TypeName Irregular.Regular.Expression -ScriptProperty @{
        Pattern = { $this.ToString() }
        IsValid = { if ($this -is [Regex]) { $true } else { $false } }
        GroupNames = {
            if ($this -is [Regex]) {
                $this.GetGroupNames()
            }
            else { @() }
        }
    }

    Write-TypeView -TypeName Irregular.Match.Extract -HideProperty StartIndex, EndIndex, Match, Input -ScriptProperty @{
        StartIndex = { $this.Match.Index}
        EndIndex = { $this.Match.Index + $this.Match.Length }
        Input = { $this.Match.Result('$_') }
    }

    Write-TypeView -TypeName System.Text.RegularExpressions.Match -ScriptProperty @{
        Input = { $this.Result('$_') }
        Before = { $this.Result('$`') }
        After = { $this.Result('$''') }
        LastGroup = { $this.Result('$+') }
        StartIndex = { $this.Index }
        EndIndex = { $this.Index + $this.Length }
        Line = {
            [Regex]::new('(?>\r\n|\n|\A)', 'RightToLeft').Matches($this.Input, $this.Index).Count
        }
        Column = {
            $this.Index -
                $(
                    $m = [Regex]::new('(?>\r\n|\n|\A)', 'RightToLeft').Match($this.Input, $this.Index)
                    $m.Index + $m.Length
                ) + 1
        }
    } -ScriptMethod @{
        Peek= {param([int]$Length = 1)
            if ($Length -gt 0) {
                if ($this.After.Length -gt $Length) {
                    $this.After.Substring(0,$Length)
                } elseif ($this.After) {
                    $this.After.Substring(0)
                }
            } elseif ($Length -lt 0) {
                $Length *= -1
                if ($this.Before.Length -gt $Length) {
                    $this.Before.Substring($this.Before.Length - $Length)
                } elseif ($this.Before) {
                    $this.Before
                }
            }
        }
    }
)

$formatting = @(
    Write-FormatView -TypeName System.Text.RegularExpressions.Match -Property Success, StartIndex, EndIndex, Value -Wrap -AutoSize
    Write-FormatView -TypeName Irregular.Regular.Expression -Property Pattern, IsValid, Options -Wrap -AutoSize



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

    foreach ($potentialDirectory in 'Formatting','Views') {
        Join-Path $myRoot $potentialDirectory |
            Get-ChildItem -ea silent |
            Import-FormatView -FilePath {$_.Fullname}
    }
)



$myFormatFile = Join-Path $myRoot "$myModuleName.format.ps1xml"
$formatting | Out-FormatData -ModuleName Irregular | Set-Content $myFormatFile -Encoding UTF8
$myTypesFile = Join-Path $myRoot "$myModuleName.types.ps1xml"
$typesFile | Out-TypeData | Set-Content $myTypesFile -Encoding UTF8