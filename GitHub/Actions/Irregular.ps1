﻿<#
.Synopsis
    GitHub Action for Irregular
.Description
    GitHub Action for Irregular.  This will:

    * Run all *.Irregular.ps1 files beneath the workflow directory
    * Run all *.Regex.source.ps1 files beneath the workflow directory
    * Run an .IrregularScript parameter.

    Any files changed can be outputted by the script, and those changes can be checked back into the repo.
    Make sure to use the "persistCredentials" option with checkout.
#>

param(
# A PowerShell Script that uses Irregular.  
# Any files outputted from the script will be added to the repository.
# If those files have a .Message attached to them, they will be committed with that message.
[string]
$IrregularScript,

# If set, will not process any files named *.irregular.ps1
[switch]
$SkipIrregularPS1,

# If set, will not process any files named *.regex.source.ps1
[switch]
$SkipRegexSource,

# If provided, will commit any remaining changes made to the workspace with this commit message.
[string]
$CommitMessage,

# The user email associated with a git commit.
[string]
$UserEmail,

# The user name associated with a git commit.
[string]
$UserName
)

"::group::Parameters" | Out-Host
[PSCustomObject]$PSBoundParameters | Format-List | Out-Host
"::endgroup::" | Out-Host

if ($env:GITHUB_ACTION_PATH) {
    $irregularModulePath = Join-Path $env:GITHUB_ACTION_PATH 'Irregular.psd1'
    if (Test-path $irregularModulePath) {
        Import-Module $irregularModulePath -Force -PassThru | Out-String
    } else {
        throw "Irregular not found"
    }
} elseif (-not (Get-Module Irregular)) {    
    throw "Action Path not found"
}

$processScriptOutput = { process { 
    $out = $_
    $outItem = Get-Item -Path $out -ErrorAction SilentlyContinue 
    if ($out -is [IO.FileInfo]) {
        git add $out.FullName
    } elseif ($outItem) {
        git add $outItem.FullName
    }
    if ($out.Message) {
        git commit -m "$($out.Message)"
    } elseif ($out.CommitMessage) {
        git commit -m "$($out.CommitMessage)"
    }

    $out
} }

"::debug::Irregular Loaded from Path - $($irregularModulePath)" | Out-Host

if (-not $UserName) { $UserName = $env:GITHUB_ACTOR }
if (-not $UserEmail) { $UserEmail = "$UserName@github.com" }
git config --global user.email $UserEmail
git config --global user.name  $UserName

if (-not $env:GITHUB_WORKSPACE) { throw "No GitHub workspace" }

if ($IrregularScript) {
    Invoke-Expression -Command $IrregularScript |
        . $processScriptOutput |
        Out-Host
}

if (-not $SkipIrregularPS1) {
    Get-ChildItem -Recurse -Path $env:GITHUB_WORKSPACE |
        Where-Object Name -Match '\.Irregular\.ps1$' |
        ForEach-Object {
            . $_.FullName |            
                . $processScriptOutput  | 
                Out-Host
        }
}


if (-not $SkipRegexSource) {
    Get-ChildItem -Recurse -Path $env:GITHUB_WORKSPACE |
        Where-Object Name -Match '\.regex\.source\.ps1$' |
        ForEach-Object {
            . $_.FullName |            
                . $processScriptOutput  | 
                Out-Host
        }
}

if ($CommitMessage) {
    dir $env:GITHUB_WORKSPACE -Recurse |
        ForEach-Object {
            $gitStatusOutput = git status $_.Fullname -s
            if ($gitStatusOutput) {
                git add $_.Fullname
            }
        }

    git commit -m $ExecutionContext.SessionState.InvokeCommand.ExpandString($CommitMessage)
    $gitPushed =  git push 2>&1
    "Git Push Output: $($gitPushed  | Out-String)"
}