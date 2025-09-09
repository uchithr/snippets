$files = Get-ChildItem "C:\Users\sam\Desktop\sss" -Filter *.docx | Sort-Object Name

if ($files.Count -eq 0) {
    Write-Host "❌ No Word files found"
    exit
}

$word = New-Object -ComObject Word.Application
$word.Visible = $false
$finalDoc = $null

try {
    $finalDoc = $word.Documents.Add()

    for ($i = 0; $i -lt $files.Count; $i++) {
        $file = $files[$i]
        Write-Host "Merging: $($file.Name)"

        if ($i -eq 0) {
            # Replace the blank starter page with the first file
            $finalDoc.Content.Delete()
            $finalDoc.Range().InsertFile($file.FullName)
        } else {
            $range = $finalDoc.Range()
            $range.Collapse(0)
            $range.InsertBreak(7)   # Page break before next file
            $range.InsertFile($file.FullName)
        }
    }

    $outputPdf = "C:\Users\sam\Desktop\sss\merged.pdf"
    $finalDoc.SaveAs([ref] $outputPdf, [ref] 17)  # 17 = PDF
    Write-Host "✅ Saved PDF as $outputPdf"
}
catch {
    Write-Host "⚠️ Error during merge: $_"
}
finally {
    if ($finalDoc -ne $null) { $finalDoc.Close([ref]$false) }
    if ($word -ne $null) { $word.Quit() }
}