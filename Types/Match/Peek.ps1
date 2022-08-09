param([int]$Length = 1)
if ($Length -gt 0) {
    if ($this.After.Length -gt $Length) {
        $this.After.Substring(0,$Length)
    } elseif ($this.After) {
        $this.After.Substring(0)
    }
} elseif ($Length -lt 0) {
    $Length *= -1
    if ($this.Before.Length -gt $Length) {
        $this.Before.Substring($this.Before.Length - $Length)
    } elseif ($this.Before) {
        $this.Before
    }
}