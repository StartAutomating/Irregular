This directory contains regular expressions for [ANSI escape sequences](https://en.wikipedia.org/wiki/ANSI_escape_code).

Note:  Using these regular expressions in the terminal may result in awkward output.  (the .Match will contain an escape sequence, which will make the next output attempt to use this escape sequence)


|Name                                          |Description                     |IsGenerator|
|----------------------------------------------|--------------------------------|-----------|
|[?<ANSI_24BitColor>](24BitColor.regex.txt)    |Matches an ANSI 24-bit color    |False      |
|[?<ANSI_4BitColor>](4BitColor.regex.txt)      |Matches an ANSI 3 or 4-bit color|False      |
|[?<ANSI_8BitColor>](8BitColor.regex.txt)      |Matches an ANSI 8 bit color     |False      |
|[?<ANSI_Color>](Color.regex.txt)              |Matches an ANSI color           |False      |
|[?<ANSI_DefaultColor>](DefaultColor.regex.txt)|Matches an ANSI 24-bit color    |False      |
|[?<ANSI_Sequence>](Sequence.regex.txt)        |Matches an ANSI escape code     |False      |


