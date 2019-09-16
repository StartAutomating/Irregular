# Understanding Regular Expressions#

Most regular expressions are, to put it mildly, difficult to read and even harder to understand.


Regular expressions are often cobbled together by trial and error, and most of the help you'll find online is deeply technical, focusing on exactly *how* to match this or that.


There's a lot less out there on *why* to use Regular Expressions (past vague "you really shoulds") and even less about *what* is actually going on.


Part of the problem is that there's not tons out there to give help you concisely understand Regular Expressions at a high level.


So before we get into code, here are some high-level Regular Expression understandings:

* Regular Expressions are an insanely powerful arcane little language designed to extract and transform text.
* Regular Expressions are descriptions of a pattern of text to match.
* Patterns can (and probably should) contain groups.
* Any pattern can be put into a group.
* Groups can (and often should) nest.  
* Groups can be used later in a replacement or to extract specific information.
* Contrary to popular belief, Regular Expressions can balance brackets and have comments.
* Used properly, Regular Expressions will match more accurately and more quickly than parsing by hand.
* Used improperly, Regular Expressions will haunt you with errors you could have seen coming.

With all of that in mind, let's get started:

*[Quick Reference](/Regular Expression Quick Reference/) 
*[Using Regular Expressions in PowerShell](/Using Regular Expressions in PowerShell/)



Unfortunately, patterns can get very complicated, very fast.  For an example, let's consider the case of a digit followed by a percentage sign.


    "50%" -match "[0-9]+%"


That looks good, right?  It's not.  When we throw in a decimal point, things get more complicated:

    
    "50.0%" -match "[0-9]+%"

The match still passed, but if we go look at $matches, we can see that it matched 0%, not 50.0%.


    "50.0%" -match "[0-9]+\.[0-9]+%"
