This directory contains regular expressions for [ANSI escape sequences](https://en.wikipedia.org/wiki/ANSI_escape_code).

Note:  Using these regular expressions in the terminal may result in awkward output.  (the .Match will contain an escape sequence, which will make the next output attempt to use this escape sequence)


|Name                                            |Description                                                  |Source                                  |
|------------------------------------------------|-------------------------------------------------------------|----------------------------------------|
|[?<ANSI_24BitColor>](24BitColor.regex.txt)      |Matches an ANSI 24-bit color                                 |[source](24BitColor.regex.source.ps1)   |
|[?<ANSI_4BitColor>](4BitColor.regex.txt)        |Matches an ANSI 3 or 4-bit color                             |[source](4BitColor.regex.source.ps1)    |
|[?<ANSI_8BitColor>](8BitColor.regex.txt)        |Matches an ANSI 8-bit color                                  |[source](8BitColor.regex.source.ps1)    |
|[?<ANSI_Blink>](Blink.regex.txt)                |Matches ANSI Blink Start or End                              |[source](Blink.regex.source.ps1)        |
|[?<ANSI_Bold>](Bold.regex.txt)                  |Matches an ANSI Bold (aka bright) Start or End               |[source](Bold.regex.source.ps1)         |
|[?<ANSI_Code>](Code.regex.txt)                  |Matches an ANSI escape code                                  |[source](Code.regex.source.ps1)         |
|[?<ANSI_Color>](Color.regex.txt)                |Matches an ANSI color                                        |[source](Color.regex.source.ps1)        |
|[?<ANSI_Cursor>](Cursor.regex.txt)              |Matches an ANSI cursor control                               |[source](Cursor.regex.source.ps1)       |
|[?<ANSI_DefaultColor>](DefaultColor.regex.txt)  |Matches an ANSI default color                                |[source](DefaultColor.regex.source.ps1) |
|[?<ANSI_Faint>](Faint.regex.txt)                |Matches an ANSI Faint (aka dim) Start or End                 |[source](Faint.regex.source.ps1)        |
|[?<ANSI_Hide>](Hide.regex.txt)                  |Matches ANSI Hide (aka conceal) Start or End                 |[source](Hide.regex.source.ps1)         |
|[?<ANSI_Invert>](Invert.regex.txt)              |Matches ANSI Invert Start or End                             |[source](Invert.regex.source.ps1)       |
|[?<ANSI_Italic>](Italic.regex.txt)              |Matches ANSI Italic Start or End                             |[source](Italic.regex.source.ps1)       |
|[?<ANSI_Link>](Link.regex.txt)                  |Matches ANSI Hyperlink                                       |[source](Link.regex.source.ps1)         |
|[?<ANSI_Note>](Note.regex.txt)                  |Matches an ANSI VT520 Note                                   |[source](Note.regex.source.ps1)         |
|[?<ANSI_Reset>](Reset.regex.txt)                |Matches an ANSI Reset (this clears formatting)               |[source](Reset.regex.source.ps1)        |
|[?<ANSI_Strikethrough>](Strikethrough.regex.txt)|Matches ANSI Strikethrough (aka crossed out) Start or End    |[source](Strikethrough.regex.source.ps1)|
|[?<ANSI_Style>](Style.regex.txt)                |Matches an ANSI style (color or text option)                 |[source](Style.regex.source.ps1)        |
|[?<ANSI_Underline>](Underline.regex.txt)        |Matches ANSI Underline/DoubleUnderline Start or Underline End|[source](Underline.regex.source.ps1)    |


