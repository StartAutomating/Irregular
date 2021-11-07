$myName = ($MyInvocation.MyCommand.ScriptBlock.File | Split-Path -Leaf) -replace '\.source', '' -replace '\.ps1', '.txt'
$myRoot = $MyInvocation.MyCommand.ScriptBlock.File | Split-Path

Write-RegEx -Description "Matches a Cron interval" |
    Write-RegEx -Pattern @'
(?>  
  (?<Any>\*)                         # An asterisk
    |                                # or  
  (?<Start>                       
    (?>[0-5][0-9]|[0-4]\d|\d{1,1})   # A number between 0 and 59   
  ) 
  (?<End>
    \-                               # a dash 
    (?>[0-5][0-9]|[0-4]\d|\d{1,1})   # followed by another number between 0 and 59
  ){0,1}
  (?<Or>\,){0,1}                     # followed by an optional comma (which indicates 'or')
)
'@ -Name Minute -Min 1  |
    Write-RegEx -CharacterClass Whitespace -Comment "# A space" |
    Write-RegEx -Pattern @'
(?>  
  (?<Any>\*)                         # An asterisk
    |                                # or  
  (?<Start>                       
    (?>[0-2][0-3]|[0-1]\d|\d{1,1})   # A number between 0 and 23
  ) 
  (?<End>
    \-                               # a dash 
    (?>[0-2][0-3]|[0-1]\d|\d{1,1})   # followed by another number between 0 and 23
  ){0,1}
  (?<Or>\,){0,1}                     # followed by an optional comma (which indicates 'or')
)
'@ -Name Hour -Min 1  |
    Write-RegEx -CharacterClass Whitespace -Comment "# A space" |
    Write-RegEx -Pattern @'
(?>  
  (?<Any>\*)                         # An asterisk
    |                                # or  
  (?<Start>                       
    (?>3[0-1]|[0-2][1-9]|[1-9])      # A number between 1 and 31
  ) 
  (?<End>
    \-                               # a dash 
    (?>3[0-1]|[0-2][1-9]|[1-9])      # followed by another number between 1 and 31
  ){0,1}
  (?<Or>\,){0,1}                     # followed by an optional comma (which indicates 'or')
)
'@ -Name Day -Min 1  |
    Write-RegEx -CharacterClass Whitespace -Comment "# A space" |
    Write-RegEx -Pattern @'
(?>  
  (?<Any>\*)          # An asterisk
    |                 # or  
  (?<Start>                       
    (?>1[0-2]|[1-9])  # A number between 1 and 12
  ) 
  (?<End>
    \-                # a dash 
    (?>1[0-2]|[1-9])  # followed by another number between 1 and 12
  ){0,1}
  (?<Or>\,){0,1}      # followed by an optional comma (which indicates 'or')
)
'@ -Name Month -Min 1  |
    Write-RegEx -CharacterClass Whitespace -Comment "# A space" |
    Write-RegEx -Pattern @'
(?>  
  (?<Any>\*)     # An asterisk
    |            # or  
  (?<Start>                       
    (?>[0-6])    # A number between 0 and 6
  ) 
  (?<End>
    \-           # a dash 
    (?>[0-6])    # followed by another number between 0 and 6
  ){0,1}
  (?<Or>\,){0,1} # followed by an optional comma (which indicates 'or')
)
'@ -Name DayOfWeek -Min 1 |
    Set-Content -Path (Join-Path $myRoot $myName) -PassThru




