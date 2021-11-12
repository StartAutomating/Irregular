describe 'Markdown Regexes' {    
    context 'Headings' {
        it 'Can match ATX headings' {
            # See https://github.github.com/gfm/#atx-heading
            foreach ($n in 1..6) {
                $headingLine = "$(' ' * (Get-Random -Minimum 0 -Maximum 3))$('#' * $n) h$n"
                $headingMatched = $headingLine | ?<Markdown_Heading> -Extract 
                $headingMatched."h$n" | Should -Match "#{$n}"
                $headingMatched.HeadingName | Should -Be "h$n"
                $headingMatchedSpecifically = $headingLine | ?<Markdown_Heading> -HeadingLevel $n -Extract
                $headingMatchedSpecifically."h$n" | Should -Match "#{$n}"
                $headingMatchedSpecifically.HeadingName | Should -Be "h$n"
            }
        }

        # See https://github.github.com/gfm/#setext-heading
        it 'Can match SETEXT style h1' {
@"
  h1
 ==
"@ | 
    ?<Markdown_Heading> -Extract | 
    ForEach-Object {
        $_.h1 | Should -BeLike '=*'
        $_.HeadingName | Should -BeLike 'h1*'
    }
        }

        # See https://github.github.com/gfm/#setext-heading
        it 'Can match SETEXT style h2' {
@"
   h2
----------------------
"@ | 
    ?<Markdown_Heading> -Extract |
    ForEach-Object {
        $_.h2 | Should -BeLike '-*'
        $_.HeadingName | Should -BeLike 'h2*'
    }          
        }
    }

    context 'Code Blocks' {
        it 'Will match indented code blocks' {
@'
    this is code!
this is not
    this is more code!
   this is not code
'@ | ?<Markdown_CodeBlock> -Extract |  Select-Object -ExpandProperty Code | Should -BeLike '*is*code*'

        }
        
        it 'Will match fenced code blocks' {
            $x = @'
```PowerShell
Get-Process # this is PowerShell code
```
'@ | ?<Markdown_CodeBlock> -Extract
            $x.Language | Should -Be PowerShell
            $x.Code | Should -BeLike '*powershell*code*'

            $x = @'
~~~yaml
a:  
  b: c
    d: e
~~~
'@ | ?<Markdown_CodeBlock> -Extract
            $x.Language | Should -Be yaml
            $x.Code | Should -BeLike '*a:*'
        }
    }
    context 'Thematic Breaks' {
        it 'Will match thematic breaks' {
            # See https://github.github.com/gfm/#thematic-breaks
            foreach ($char in '*','-','_') {
                $rn = Get-Random -Minimum 3 -Maximum 20
                "$($char * $rn)" | 
                    ?<Markdown_ThematicBreak> | 
                    Select-Object -ExpandProperty EndIndex | 
                    Should -Be $rn
            }
        }
    }


    context 'Markdown lists' {
        it 'Will match a bullet point list' {
            $listMatches = "* BulletPoint" | ?<Markdown_List> -Extract
            $listMatches | Select-Object -ExpandProperty Value | Should -Be "BulletPoint"
            $listMatches | Select-Object -ExpandProperty BulletPoint | Should -Be "*"
        }

        it "Will match a numbered list" {
            $listMatches = "1. Thing" | ?<Markdown_List> -Extract
            $listMatches | Select-Object -ExpandProperty Value | Should -Be "Thing"
            $listMatches | Select-Object -ExpandProperty Number | Should -Be "1"
        }

        it "Can support task lists" {
            $listMatches = "1. [x] Thing Is Done" | ?<Markdown_List> -Extract
            $listMatches | Select-Object -ExpandProperty Value | Should -Be "Thing Is Done"
            $listMatches | Select-Object -ExpandProperty Number | Should -Be "1"
            $listMatches | Select-Object -ExpandProperty IsTask | Should -Be "[x]"
            $listMatches | Select-Object -ExpandProperty Done | Should -Be "x"
        }
    }
}
