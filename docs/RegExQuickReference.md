## Basic Matching

|Pattern|Meaning|
|-----:|:-------|
|.|any single character|
|+|one or more of the preceeding pattern|
|?|zero or more of the preceeding pattern|
|\\ | escape sequence or [character class](#CharacterClasses) or backreference|
|[*anyofthese*]|Any of these characters|
|[^ *notoneofthese* ]|matches any character that's isnt one of these characters|
|[start-end]|(matches this range)|
|^|the begining of the line or string|
|$|the end of the line or string|

## Character classes <a name='CharacterClasses' />

Instead of writing really long sequences of characters, you can use Regular Expressions to match certain character classes:

|Pattern|Meaning|
|------:|:------|
|\w|any word character (basically, any letter)|
|\d|any decimal character (basically, any number (though not .))|
|\s|any whitespace characters (tabs, spaces, newlines)|
|\p{NAME}|any named group (these are useful, but advanced)|


Each of these character classes also has an opposite.

|Pattern|Meaning|
|-----:|:-------|
|\W|any NON-word character (basically, not letters or digits but a lot of punctutation and whitespace)|
|\D|any NON-decimal character (basically, any non-digit)|
|\S|any NON-whitespace characters (most characters)|
|\P{NAME}|NOT a named group|  

## Groups

|Pattern|Meaning|
|-----:|:-------|
|(Pattern)|unnamed group|
|(?\<GroupName\>Pattern)|named group|
|(?:Pattern)|non-capturing group (this will match but you can't get it later)|
|(?\>Pattern)|atomic group (there can be only one)|

## Lookaround
|Pattern|Meaning|
|-----:|:-------|
|(?=Pattern)|lookahead|
|(?!Pattern)|negative lookahead|
|(?<=Pattern)|lookbehind|
|(?<!Pattern)|negative lookbehind|

