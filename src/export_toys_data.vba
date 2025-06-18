Sub ExportToysToJson()
    Dim ws As Worksheet
    Set ws = ThisWorkbook.Sheets("總表")

    Dim lastRow As Long
    lastRow = ws.Cells(ws.Rows.Count, 1).End(xlUp).Row

    Dim json As String
    json = "{""Toys"":["

    Dim i As Long
    For i = 2 To lastRow
        Dim name As String, rank As String, coinbase As Long, colorsRaw As String
        name = ws.Cells(i, 1).Value
        rank = ws.Cells(i, 2).Value
        coinbase = ws.Cells(i, 3).Value
        colorsRaw = ws.Cells(i, 4).Value

        Dim colorArray As String, c As Integer
        colorArray = "["
        For c = 1 To Len(colorsRaw)
            Dim ch As String
            ch = Mid(colorsRaw, c, 1)
            If ch Like "[A-Z]" Then
                If Right(colorArray, 1) <> "[" Then colorArray = colorArray & ","
                colorArray = colorArray & """" & ch & """"
            End If
        Next c
        colorArray = colorArray & "]"

        json = json & vbCrLf & "  {" & _
               """name"":""" & name & """," & _
               """rank"":""" & rank & """," & _
               """coinbase"":" & coinbase & "," & _
               """colors"":" & colorArray & "}"

        If i < lastRow Then json = json & ","
    Next i

    json = json & vbCrLf & "]}"

    ' 儲存為 JSON 檔
    Dim filePath As String
    filePath = ThisWorkbook.Path & "..\json\toys_data.json"

    Dim fileNum As Integer
    fileNum = FreeFile
    Open filePath For Output As #fileNum
    Print #fileNum, json
    Close #fileNum

    MsgBox "JSON 檔案已儲存至：" & filePath, vbInformation
End Sub