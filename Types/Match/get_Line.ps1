
            [Regex]::new('(?>\r\n|\n|\A)', 'RightToLeft').Matches($this.Input, $this.Index).Count
        
