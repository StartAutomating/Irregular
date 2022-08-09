
            $this.Index -
                $(
                    $m = [Regex]::new('(?>\r\n|\n|\A)', 'RightToLeft').Match($this.Input, $this.Index)
                    $m.Index + $m.Length
                ) + 1
        
