This directory contains regular expressions for [ANSI escape sequences](https://en.wikipedia.org/wiki/ANSI_escape_code).

Note:  Using these regular expressions in the terminal may result in awkward output.  (the .Match will contain an escape sequence, which will make the next output attempt to use this escape sequence)


|Name                                            |Description                                                  |IsGenerator|
|------------------------------------------------|-------------------------------------------------------------|-----------|
|[?<ANSI_24BitColor>](24BitColor.regex.txt)      |Matches an ANSI 24-bit color                                 |False      |
|[?<ANSI_4BitColor>](4BitColor.regex.txt)        |Matches an ANSI 3 or 4-bit color                             |False      |
|[?<ANSI_8BitColor>](8BitColor.regex.txt)        |Matches an ANSI 8 bit color                                  |False      |
|[?<ANSI_Blink>](Blink.regex.txt)                |Matches ANSI Blink Start or End                              |False      |
|[?<ANSI_Bold>](Bold.regex.txt)                  |Matches an ANSI Bold Start or End                            |False      |
|[?<ANSI_Code>](Code.regex.txt)                  |Matches an ANSI escape code                                  |False      |
|[?<ANSI_Color>](Color.regex.txt)                |Matches an ANSI color                                        |False      |
|[?<ANSI_DefaultColor>](DefaultColor.regex.txt)  |Matches an ANSI 24-bit color                                 |False      |
|[?<ANSI_Faint>](Faint.regex.txt)                |Matches an ANSI Faint (aka dim) Start or End                 |False      |
|[?<ANSI_Hide>](Hide.regex.txt)                  |Matches ANSI Hide (aka conceal) Start or End                 |False      |
|[?<ANSI_Invert>](Invert.regex.txt)              |Matches ANSI Invert Start or End                             |False      |
|[?<ANSI_Italic>](Italic.regex.txt)              |Matches ANSI Italic Start or End                             |False      |
|[?<ANSI_Note>](Note.regex.txt)                  |Matches an ANSI VT520 Note                                   |False      |
|[?<ANSI_Reset>](Reset.regex.txt)                |Matches an ANSI Reset (this clears formatting)               |False      |
|[?<ANSI_Strikethrough>](Strikethrough.regex.txt)|Matches ANSI Strikethrough Start or End                      |False      |
|[?<ANSI_Underline>](Underline.regex.txt)        |Matches ANSI Underline/DoubleUnderline Start or Underline End|False      |


