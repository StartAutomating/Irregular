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
}
