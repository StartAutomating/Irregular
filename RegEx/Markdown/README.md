This directory contains Regular Expressions for Markdown.


|Name                                                |Description                                                                                                                                   |Source                               |
|----------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------|
|[?<Markdown_CodeBlock>](CodeBlock.regex.ps1)        |Matches a Markdown code block.  <br/>    <br/>    Code blocks can start/end with 3 or more backticks or tildas, or 4 indented whitespaces<br/>|[generator](CodeBlock.regex.ps1)     |
|[?<Markdown_Heading>](Heading.regex.ps1)            |Matches Markdown Headings.  Can provide a -HeadingName, -HeadingLevel, and -IncludeContent.<br/>                                              |[generator](Heading.regex.ps1)       |
|[?<Markdown_Link>](Link.regex.ps1)                  |Matches a Markdown Link.  Can customize the link text and link url.<br/>                                                                      |[generator](Link.regex.ps1)          |
|[?<Markdown_List>](List.regex.txt)                  |Matches a Markdown List                                                                                                                       |[source](List.regex.source.ps1)      |
|[?<Markdown_ThematicBreak>](ThematicBreak.regex.txt)|Matches markdown horizontal rules                                                                                                             |
|[?<Markdown_YAMLHeader>](YAMLHeader.regex.txt)      |Matches a Markdown YAML Header                                                                                                                |[source](YAMLHeader.regex.source.ps1)|


