$word = New-Object -ComObject Word.Application
$word.Visible = $false

$files = Get-ChildItem "C:\Users\sam\Desktop\input" -Filter *.docx | Sort-Object Name
$finalDoc = $word.Documents.Add()

foreach ($file in $files) {
    $range = $finalDoc.Range()
    $range.Collapse(0)  # collapse to end
    $range.InsertFile($file.FullName)
    $range.InsertBreak(7)  # page break between files
}

$outputPdf = "C:\Users\sam\Desktop\input\merged.pdf"
$finalDoc.SaveAs([ref] $outputPdf, [ref] 17)  # 17 = PDF
$finalDoc.Close()
$word.Quit()
